# github-es-bulk-delete-index
The repository contains code for deleting Github Enterprise repos in bulk

## Prerequisites
The script requires below prerequisites to be installed in your Linux System.
* ```curl```
* Access to internet from the server (example: configured proxy on the server)

## Usage
Set the below three variables in the script.

* ES_ENDPOINT="https://XYZ.ES.AWS.COM:PORT"
* ES_API="/_cat/indices?v&s=index"
* ES_TOKEN="YOUR-TOKEN"

The script takes in exactly one parameter which is the number of days for which to retain the indexes in elasticsearch.
```
./es-bulk-delete-index.sh 4
```
Here the first argument "4" makes the script retain 4 days of indexes in elasticsearch.

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request.

## Maintainer
pawarrchetan@gmail.com
* Please have a look at CONTRIBUTING.md for further details on teram for contributing.