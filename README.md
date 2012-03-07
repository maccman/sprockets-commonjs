This library adds CommonJS support to [Sprockets](https://github.com/sstephenson/sprockets).

## What is CommonJS?

The CommonJS module format is a way of encapsulating JavaScript libraries, ensuring they have to explicitly require and export properties they use. In a nutshell:

1. You require in files using `require()`:

    var Asset = require('models/asset');

2. You export properties using `module.exports`:

    var Asset = function(){ /* ... */ };
    module.exports = Asset;
        
## This library

This library adds CommonJS support to Sprockets, so it can wrap up JavaScript files as modules, and serve them appropriately. This is done by giving any JS files you want as modules, the `.module` extension.

Sprockets will then wrap up the JS library when it's requested, with the following:

    require.define(function(exports, require, module){ /* Your library */ });
    
`require.define()` is defined inside `commonjs.js`, which you'll need to include in the page before any modules are loaded.

One caveat to the approach this library takes, is that dependencies loaded through `require()` will not be added to the dependency graph. This library will not parse the AST tree for require calls. This decision has been made for a variety of reasons, but it does mean you need to require files through both CommonJS and Sprockets. 

## Usage

1. Add `gem 'sprockets-commonjs'` to your `Gemfile`
1. Add `.module` to any JavaScript files you want as modules, i.e. `users.js.module`
1. Require the CommonJS lib before any modules: `//= require commonjs`
1. Require all the modules, e.g.: `//= require_tree ./modules`
