// Generated by LiveScript 1.3.1
var slice$ = [].slice;
(function(){
  var _, proxise;
  _ = function(q, v, n){
    return q.splice(0, q.length).map(function(o){
      o[n](v);
      if (o.timeout) {
        return clearTimeout(o.timeout);
      }
    });
  };
  proxise = function(a, b){
    var ref$, f, timeout, q, ret;
    ref$ = a instanceof Function
      ? [a, b || 0]
      : [b, a || 0], f = ref$[0], timeout = ref$[1];
    q = [];
    ret = function(){
      var args, r, pair, handle;
      args = slice$.call(arguments);
      if ((r = f.apply(this, args)) instanceof Promise) {
        return r;
      } else {
        pair = null;
        handle = timeout ? setTimeout(function(){
          var idx;
          if (!(pair && ~(idx = q.indexOf(pair)))) {
            return;
          }
          q.splice(idx, 1);
          return pair.rej(new Error("timeout"));
        }, timeout) : null;
        return new Promise(function(res, rej){
          return q.push(pair = {
            res: res,
            rej: rej,
            timeout: handle
          });
        });
      }
    };
    ret.resolve = function(v){
      return _(q, v, 'res');
    };
    ret.reject = function(v){
      return _(q, v, 'rej');
    };
    return ret;
  };
  if (typeof module != 'undefined' && module !== null) {
    module.exports = proxise;
  }
  if (typeof window != 'undefined' && window !== null) {
    return window.proxise = proxise;
  }
})();
