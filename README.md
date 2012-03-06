This library adds CommonJS support to [Sprockets](https://github.com/sstephenson/sprockets).

## What is CommonJS?

The CommonJS module format is a way of encapsulating JavaScript libraries, ensuring they have to explicitly require and export properties they use. In a nutshell:

1. You require in files using `require()`:

        var Asset = require('models/asset');

2. You export properties using `module.exports`:

        var Asset = function(){ /* ... */ };
        module.exports = Asset;

## Usage

1. Add `gem 'sprockets-commonjs'` to your `Gemfile`
1. Add `.module` to any JavaScript files you want as modules, i.e. `users.js.module`
1. Require the CommonJS lib before any modules: `//= require commonjs`
1. Require all the modules, e.g.: `//= require_tree ./modules`
