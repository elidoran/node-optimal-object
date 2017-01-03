module.exports = (object) ->
  Object.create object       # 1. make the object a prototype for new object
  enforcer = -> object.blah  # 2. make a function access its properties
  enforcer()                 # 3. call the function so it learns about it
  enforcer()                 # 4. yup, twice is necessary (tested it)
  return

module.exports.check = (object) ->
  enable()
  eval '%HasFastProperties(object)'

# only required for check()
# try to enable the native function we need.
# changes to a NOOP function once it's successful.
enable = ->
  # if they're already on the command line then they're enabled.
  # so, replace this function with a noop function and return.
  # can't test this in the same run as testing the later part, so...
  ### !pragma coverage-skip-block ###
  if '--allow_natives_syntax' in process.argv then return enable = ->

  try # otherwise, try to get the v8 module and enable it via the flag
    require('v8').setFlagsFromString '--allow_natives_syntax'
    enable = ->
  catch error1
    # Node 4 added v8, so, before that, it'll throw an error.
    # Can't cause in other Node versions, so, don't cover this
    ### !pragma coverage-skip-next ###
    throw new Error 'Unable to set flag during runtime. Try setting \'--allow_natives_syntax\' via command line.'
