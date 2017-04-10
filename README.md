[![CircleCI](https://circleci.com/gh/sgmap/boussole.svg?style=svg)](https://circleci.com/gh/sgmap/boussole)
[![Code Climate](https://codeclimate.com/github/sgmap/boussole/badges/gpa.svg)](https://codeclimate.com/github/sgmap/boussole)
[![Issue Count](https://codeclimate.com/github/sgmap/boussole/badges/issue_count.svg)](https://codeclimate.com/github/sgmap/boussole)
[![Test Coverage](https://codeclimate.com/github/sgmap/boussole/badges/coverage.svg)](https://codeclimate.com/github/sgmap/boussole/coverage)
[![Dependency Status](https://gemnasium.com/badges/github.com/sgmap/boussole.svg)](https://gemnasium.com/github.com/sgmap/boussole)
[![Inline docs](http://inch-ci.org/github/sgmap/boussole.svg?branch=master)](http://inch-ci.org/github/sgmap/boussole)

# Boussole

### Contribuer

```
git clone https://github.com/sgmap/boussole.git
cd boussole
gem install --no-ri --no-rdoc bundler
bundle install
cp config/database.yml.example config/database.yml
```

Modifiez ```config/database.yml``` si besoin est.

```
bundle exec rake db:setup
bundle exec guard
```

Visitez ```localhost:5000```

### Génération du modèle entité-association (ERD)

```
bundle exec erd
```

### Génération de la documentation

```
bundle exec yardoc
```

### Génération d'une nouvelle version

```
git tag -s vx.y.z -m 'yadda-yadda'
git push origin --tags
```

### Génération du changelog

```
bundle exec rake changelog
```

### Consulter la guide de styles

Visitez ```localhost:5000/styleguides```
