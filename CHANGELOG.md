# Change Logs

## v0.1.2

 - bug fix: when proxise.once fails, promise for caller is still resolved instead of rejected.


## v0.1.1

 - don't assume `cb` in proxise.once return Promise - just wrap it with promise.


## v0.1.0

 - add `proxise.once` for running functions that should be executed successfully for at most only once.
