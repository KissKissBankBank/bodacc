# Bodacc

Bodacc est un scrapper qui insère toutes les annonces du Bodacc (2008-2018) en base de données [Bodacc](https://echanges.dila.gouv.fr/OPENDATA/BODACC/)

## Getting Started

Ces instructions vous permettront d'obtenir une copie du projet opérationnel sur votre machine locale à des fins de développement et de test.

### Prerequisites

Soyez sur d'avoir Ruby >= 2.2

### Installing

Cloner le repos, installez les gems necessaires et créer votre base de donnée a partir de database_dump

```
$> bundle install
$> pg_dump bodacc < database_dump
```

### Lauch scrapper

Le scrapper est un simple fichier ruby, lancer le ruby tout simplement

```
$> ruby scraper.rb
$> ruby scraper.rb 2015 // Downloading only 2015 announcements
```

## How it works

Bodacc utilise la gem [Nokogiri](https://github.com/sparklemotion/nokogiri) et la gem [Mechanize](https://github.com/sparklemotion/nokogiri) afin de scrapper et télécharger les fichiers. Apres les avoir decompressés, il les insère en base de données

Si vous utilisez ce scrapper pour la première fois, sachez qu'insérer les annonces de 2008 à 2017 prendra beaucoup de temps (vous aurez le temps de regarder la saga Star Wars avec tout les bonus... deux fois). En effet les fichiers pèsent environ 300 Mo et contiennent au total un peu plus de 20 Million d'annonces


## Built With

* [Ruby](https://www.ruby-lang.org/fr/) - The programming language used

## Authors

* **Castres Maxime** - *Initial work* - [Mcastres](https://github.com/Mcastres)
