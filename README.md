# CRAN-INDEXER

Indexer for R packages, based on cran-r list: [https://cran.r-project.org/src/contrib/](https://cran.r-project.org/src/contrib/)

## Requirements:

* Ruby 2.5.1
* Postgresql

## Setup

* Initialize the project:
```
bin/setup
```

* Populate with some packages (There's a cron job that does that every day at 12pm):
```
bundle exec rake cran:update
```

* Start the server:
```
bundle exec rails server
```

* Access the project on: [http://localhost:3000/](http://localhost:3000/)

## Tests

* Execute:
```
bundle exec rspec
```
