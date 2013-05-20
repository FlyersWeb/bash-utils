#!/bin/bash
MSYMFONYPATH="$1"
MBUNDLEPATH="$2"
MBUNDLENAME="$3"

if [ $# -ne 3 ]
then
    echo "Usage: $0 {Symfony_Path} {Symfony_Bundle_Path} {Symfony_Bundle_Name}"
    echo "Generate entities from database"
    exit 1
fi

php $MSYMFONYPATH/app/console doctrine:mapping:convert yml $MBUNDLEPATH/Resources/config/doctrine/metadata/orm --from-database --force &&
php $MSYMFONYPATH/app/console doctrine:mapping:import $MBUNDLENAME annotation &&
php $MSYMFONYPATH/app/console doctrine:generate:entities $MBUNDLENAME