# Bodacc
Bodacc is a scraper application that scrape every Bodacc announcements (2008-actual year) on the DILA website in a Postgresql database [Bodacc](https://echanges.dila.gouv.fr/OPENDATA/BODACC/)

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.
### Prerequisites

Be sure to have Ruby >= 2.3.4 and Docker

### Installing gems

Clone the repository and install all necessary gem by running the following command:

```sh
$> bundle install
```

### Launch scraper (local without docker)

The repository include a dump of the empty database called "structure.sql". Create your database with it by running the following command:

```sh
$ pg_dump bodacc < structure.sql
```

The database is `bodacc`

```
bodacc
  ├── bilans
  ├── immatriculations
  ├── modifications
  ├── pcls
  └── radiations
```

Then you just have to launch the script:
```sh
$ DATABASE_URL=postgres://localhost:5432/bodacc ruby main.rb
$ DATABASE_URL=postgres://localhost:5432/bodacc ruby main.rb 2009
```

### Launch scraper (local with docker)

```sh
$ docker-compose build
$ docker run <tag name>
```

### Launch scraper (production with docker)

Create a `docker-compose.yml` including all your configurations
```sh
$ bin/deploy
```
## How it works

The first time you use the scraper it will download every bodacc announcements from 2008 to now. After that, if you launch the same command again, it will only download announcements that were posted after the last `parution_at` datetime.

Bodacc use the [Nokogiri](https://github.com/sparklemotion/nokogiri) gem and the [Mechanize](https://github.com/sparklemotion/nokogiri) gem in order to scrape and download every files. After unzipping them, the script inserts them into the bodacc database.

If you use this scraper for the first time be aware that inserting everything from 2008 to the year before actual will take a lot of time (you'll have time to watch the Star Wars saga with all the bonuses ... twice). In fact the files weigh about 2-3 GB !!!

![](https://media.giphy.com/media/l0HlBO7eyXzSZkJri/giphy.gif)

## Possible errors

Based on a maintained site, the scraper may not work in many cases:
  - The url is note the same anymore `https://echanges.dila.gouv.fr/OPENDATA/BODACC/<actual year>`, if this is the case, change it inside `services/actual.rb`
  - The url is note the same anymore `https://echanges.dila.gouv.fr/OPENDATA/BODACC/FluxHistoriques`, if this is the case, change it inside `services/archives.rb`
  - Not enough space on the server ?
