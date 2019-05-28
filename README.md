# proxise

Use Promise Proxy ( Proxise ) for easily resolving promises outside the Promise function.


## Usage

    ```
    somefunc = proxise (params) -> if (ready) => return Promise.resolve('some value')
    somefunc params .then (v) -> /* doing something ... */
    somefunc.resolve 'some value'
    ```

Proxise use the return value inside the proxise function to decide how things work:

 * return promise - then the promise will be used when somefunc is called.
 * otherwise - proxise create a new Promise object and enqueues it until somefunc.resolve is called.
   When somefunc.resolve is called, all queued promises will be resolved immediately.

Proxise is quite helpful for resolving promise outside the promise function, for example, by user interaction:

    ```
    until-user-click = proxise ->
    until-user-click!then -> console.log \user-clicked.
    document.body.addEventListner \click, -> until-user-click.resolve!
    ```


## License

MIT
