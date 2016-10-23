require 'shellwords'
require 'sprockets'
require 'ostruct'

module Sprockets
  class Rollup

    class << self

      attr_accessor :configuration

      def configuration_hash
        configuration.to_h.reduce({}) do |hash, (key, val)|
          hash[key.to_s] = val
          hash
        end
      end

      def instance
        @instance ||= new
      end

      def configure
        self.configuration ||= OpenStruct.new
        yield configuration
      end

      def reset_configuration
        self.configuration = OpenStruct.new
      end

      def call(input)
        instance.call(input)
      end

      def cache_key
        instance.cache_key
      end

    end

    attr_reader :cache_key

    def configuration_hash
      self.class.configuration_hash
    end

    def initialize(options = {})
      @options = configuration_hash.merge(options).freeze
    end

    def call(input)
      transform input
    end

    def transform(input)
      path_to_rollup = File.join File.dirname(__FILE__), "rollup.js"
      path_to_buble  = File.join File.dirname(__FILE__), "buble.js"
      `node #{path_to_rollup} #{input[:filename].shellescape} | node #{path_to_buble}`
    end

  end

  if respond_to?(:register_transformer)
    register_mime_type 'text/ecmascript-6', extensions: ['.es'], charset: :unicode
    register_transformer 'text/ecmascript-6', 'application/javascript', Rollup
    register_preprocessor 'text/ecmascript-6', DirectiveProcessor
  end
  
  if respond_to?(:register_engine)
    args = ['.es', Rollup]
    args << { mime_type: 'text/ecmascript-6', silence_deprecation: true } if Sprockets::VERSION.start_with?("3")
    register_engine(*args)
  end

end
