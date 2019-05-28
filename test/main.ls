require! <[../dist/proxise]>

ready = false

obj = do
  val: 2
  until-ready: proxise 1000, ->
    console.log "access obj.val correctly? ", (obj.val == 2)
    if ready => Promise.resolve(ready)

test = ->
  obj.until-ready!
    .then -> console.log "get ready state correct?", it
    .catch -> console.log "timeout correctly if this is a timeout error: ", it

test!
setTimeout (->
  obj.until-ready.resolve true
  test!
), 900

