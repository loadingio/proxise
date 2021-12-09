require! <[../src/proxise]>

run = proxise -> console.log 'run immediately but resolve by external resolver'
init = proxise.once -> console.log 'should be run for only once.'

run!then -> console.log 'resolved(1):', it
run!then -> console.log 'resolved(2):', it
init!then -> console.log 'after init'
init!then -> console.log 'after init (2)'
run.resolve "value from resolve"
