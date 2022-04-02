# WordFrequenciesCalculator

[![Build status](https://github.com/olekscode/WordFrequenciesCalculator/workflows/CI/badge.svg)](https://github.com/olekscode/WordFrequenciesCalculator/actions/workflows/test.yml)
[![Coverage Status](https://coveralls.io/repos/github/olekscode/WordFrequenciesCalculator/badge.svg?branch=master)](https://coveralls.io/github/olekscode/WordFrequenciesCalculator?branch=master)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/olekscode/WordFrequenciesCalculator/master/LICENSE)

Calculate word frequencies in text corpora

## How to install it

To install `WordFrequenciesCalculator`, go to the Playground (Ctrl+OW) in your [Pharo](https://pharo.org/) image and execute the following Metacello script (select it and press Do-it button or Ctrl+D):

```Smalltalk
Metacello new
  baseline: 'WordFrequenciesCalculator';
  repository: 'github://olekscode/WordFrequenciesCalculator/src';
  load.
```

## How to depend on it

If you want to add a dependency on `WordFrequenciesCalculator` to your project, include the following lines into your baseline method:

```Smalltalk
spec
  baseline: 'WordFrequenciesCalculator'
  with: [ spec repository: 'github://olekscode/WordFrequenciesCalculator/src' ].
```

## How to use it
