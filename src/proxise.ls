(->
  _ = (q,v,n) -> q.splice(0, q.length).map (o) -> o[n](v); if o.timeout => clearTimeout(o.timeout)
  proxise = (a,b) ->
    [f,timeout] = if (a instanceof Function) => [a,b or 0] else [b,a or 0]
    q = []
    ret = (...args) ->
      if (r = f.apply @, args) instanceof Promise => return r
      else 
        pair = null
        handle = if timeout =>
          setTimeout (->
            if !(pair and ~(idx = q.indexOf(pair))) => return
            q.splice(idx, 1)
            pair.rej new Error("timeout")
          ), timeout
        else null
        return new Promise (res, rej) -> q.push(pair := {res, rej, timeout: handle})
    ret.resolve = (v) -> _ q, v, \res
    ret.reject = (v) -> _ q, v, \rej
    return ret

  proxise.once = (cb) ->
    lc = {}
    ret = proxise ->
      if lc.inited => return Promise.resolve!
      if lc.initing => return
      lc.initing = true
      cb!
        .finally -> lc.initing = false
        .then -> lc.inited = true
        .then -> ret.resolve!
        .catch -> ret.reject it

  if module? => module.exports = proxise
  if window? => window.proxise = proxise
)!
