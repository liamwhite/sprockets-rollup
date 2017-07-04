# sprockets-rollup

`sprockets-rollup` allows you to write your JavaScript in a Rails application using ES6 language features and modules, compiling them back to ES5 for browser support.
It uses [Rollup](https://github.com/rollup/rollup) to manage imports and [Bublé](https://gitlab.com/Rich-Harris/buble) to compile the result back to ES5.

## Prerequisites

*nix system, `nodejs` >= v4  installed, `/usr/bin/node` present and in `$PATH`

## How to use

```rb
gem 'sprockets-rollup'
```

1. Add the gem
2. `bundle install`
3. Rename your application.js to application.js.es, so that Sprockets will then pass it to sprockets-rollup
4. Profit! You can now use most ES6 features, including modules.

This utility does not generate source maps for the resulting files.

## Example input application.js.es
```js
// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//

// Third-party code, polyfills
import './vendor/promise.polyfill.js';
import './vendor/fetch.polyfill.js';
import './vendor/closest.polyfill.js';
import './vendor/customevent.polyfill.js';
import './vendor/es6.polyfill.js';
import './vendor/md5.js';

// Our code
import './analytics.js';
import './when-ready.js';
```

## Why not just use [webpack](http://weblog.rubyonrails.org/2017/2/23/Rails-5-1-beta1/)?

1. sprockets-rollup was written before webpack support was added to Rails.
2. Using sprockets-rollup only affects your JavaScript and does not serve as a replacement for your asset pipeline.
3. Rails' webpack support still expects you to write code that uses CommonJS modules for certain tasks.

## Why use webpack instead?

1. Webpack serves as a complete replacement for your asset pipeline: it can see more than the directory graph created by your application scripts, and other transformations can be performed.
2. Currently, sprockets-rollup must be the first step in the compilation chain for all assets except those at the top level. This means you cannot use ERB parsing on an imported file; it must be required using Sprockets' require directive.
3. Webpack is used widely inside and outside of the Rails ecosystem and developers familiar with its workings abound.
