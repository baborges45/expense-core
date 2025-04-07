#!/bin/bash

## Gera relatório com os dados das métricas
flutter pub run dart_code_metrics:metrics analyze lib -r html

## Abre o arquivo de métricas no browser 
open metrics/index.html