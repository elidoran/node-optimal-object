# @optimal/object
[![Build Status](https://travis-ci.org/elidoran/node-optimal-object.svg?branch=master)](https://travis-ci.org/elidoran/node-optimal-object)
[![Dependency Status](https://gemnasium.com/elidoran/node-optimal-object.png)](https://gemnasium.com/elidoran/node-optimal-object)
[![npm version](https://badge.fury.io/js/%40optimal%2Fobject.svg)](http://badge.fury.io/js/%40optimal%2Fobject)
[![Coverage Status](https://coveralls.io/repos/github/elidoran/node-optimal-object/badge.svg?branch=master)](https://coveralls.io/github/elidoran/node-optimal-object?branch=master)

Force V8 to optimize an object's properties or check its status.

Use this when:

1. the object ends up in slow mode
2. it's not possible to refactor code to avoid slow mode (such as defining all the properties on it ahead of time and only altering their values, not adding properties, and not deleting them)
3. an object's properties are accessed often enough to affect performance

The optimization doesn't require `'--allow_natives_syntax'`; only the check does.

Check if an object's property access is in optimized mode with `optimize.check()`. This tries to enable the flag `'--allow_natives_syntax'`, so, use in testing and performance benchmarking. (The flag is required in order to check the optimization status.)

See [V8 test](https://github.com/v8/v8/blob/master/test/mjsunit/fast-prototype.js)


## Install

```sh
npm install @optimal/object --save
```


## Usage

```javascript
// 1. optimize a an object
var optimize = require('@optimal/object')
  , object = {
      key :'value',
      some:'thing',
      and :'more',
  }

// trigger slow mode
delete object.and

// back to fast access
optimize(object)

// 2. test an object to know if it's optimized:
var someOtherObject = getSomeOtherObject()
result = optimize.check(someOtherObject) // returns true or false
```

## Others

1. [@optimal/fn](https://www.npmjs.com/package/@optimal/fn)


## MIT License
