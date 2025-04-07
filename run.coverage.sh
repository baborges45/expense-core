#!/bin/bash

## Gera o coverage
flutter test --coverage

## Transforma o lcov para html
genhtml coverage/lcov.info -o coverage/html

## Abre o arquivo no browser
open coverage/html/index.html