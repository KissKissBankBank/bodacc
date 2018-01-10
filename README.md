# Bodacc

Boaper is a scraper application that scrape every Bodacc announcements (2008-actual) on the DILA website in a Postgresql database [Bodacc](https://echanges.dila.gouv.fr/OPENDATA/BODACC/)

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

Be sure to have Ruby >= 2.3.4

### Installing gems

Clone the repository and install all necessary gem by running the following command:

```
$> bundle install
```

### Intalling database

The repository include a dump of the empty database called "database_dump". Create your database with it by running the following command:

```
$> pg_dump bodacc < database_dump
```

The database is called "bodacc"

### Launch scrapper

The scrapper is a single Ruby file. Just launch it with Ruby

```
$> ruby scraper.rb
$> ruby scraper.rb 2015   // Download only 2015 announcements
```

## How it works

Bodacc use the [Nokogiri](https://github.com/sparklemotion/nokogiri) gem and the [Mechanize](https://github.com/sparklemotion/nokogiri) gem in order to scrape and download every files. After unzipping them, the script insert them into the bodacc database

If you use this scrapper for the first time be aware that inserting everything from 2008 to the year before actual will take a lot of time (you'll have time to watch the Star Wars saga with all the bonuses ... twice). In fact the files weigh about 300 MB and contain a total of just over 20 million announcements

At the end, the script create a 'last_update.txt' file which contain the last time bodacc announcements were inserted into database preventing to download announcements that are already added.

## Built With

* [Ruby](https://www.ruby-lang.org/fr/) - The programming language used

## Authors

* **Castres Maxime** - *Initial work* - [Mcastres](https://github.com/Mcastres)
