# WordFrequenciesCounter

[![Build status](https://github.com/olekscode/WordFrequenciesCounter/workflows/CI/badge.svg)](https://github.com/olekscode/WordFrequenciesCounter/actions/workflows/test.yml)
[![Coverage Status](https://coveralls.io/repos/github/olekscode/WordFrequenciesCounter/badge.svg?branch=master)](https://coveralls.io/github/olekscode/WordFrequenciesCounter?branch=master)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/olekscode/WordFrequenciesCounter/master/LICENSE)

Calculate word frequencies in text corpora

## How to install it

To install `WordFrequenciesCounter`, go to the Playground (Ctrl+OW) in your [Pharo](https://pharo.org/) image and execute the following Metacello script (select it and press Do-it button or Ctrl+D):

```Smalltalk
Metacello new
  baseline: 'WordFrequencies';
  repository: 'github://olekscode/WordFrequenciesCounter/src';
  load.
```

## How to depend on it

If you want to add a dependency on `WordFrequenciesCounter` to your project, include the following lines into your baseline method:

```Smalltalk
spec
  baseline: 'WordFrequencies'
  with: [ spec repository: 'github://olekscode/WordFrequenciesCounter/src' ].
```

## How to use it

### 1. Selecting a text corpus

First, we need to select a text corpus on which we will be calculating the word frequencies.
A corpus is just a file with very long text or combination of texts that is used to train language models.
For example, the [Guttenberg Corpus](https://languagelog.ldc.upenn.edu/nll/?p=45629) contains full texts of hundreds of English books, [Brown Corpus](https://en.wikipedia.org/wiki/Brown_Corpus) contains different-purpose texts in English such as Press, Hobbies, Science, Religion, Fiction.
[Leipzig WortSchatz](https://wortschatz.uni-leipzig.de/en/download) provides corpora in many different languages, including Wikipedia articles, news, and web corpora.

By analysing a text corpus, we can learn about the language that is used in it.
More specifically, with `WordFrequenciesCalculator`, we can calculate the word frequencies in a corpus, which will be representative of the word frequency of its language.

We download a selected corpus into a `.txt` file and create a file reference in Pharo:
```st
corpusFile := '/Users/oleks/Documents/Data/brown.txt' asFileReference.
```
The contents of that file may look like this:

> The Fulton County Grand Jury said Friday an investigation of Atlanta's recent primary election produced no evidence that any irregularities took place. The jury further said in term-end presentments that the City Executive Committee, which had over-all charge of the election, deserves the praise and thanks of the City of Atlanta for the manner in which the election was conducted. The September-October term jury had been charged by Fulton Superior Court Judge Durwood Pye to investigate reports of possible irregularities in the hard-fought primary which was won by Mayor-nominate Ivan Allen Jr. Only a relative handful of such reports was received, the jury said, considering the widespread interest in the election, the number of voters and the size of this city. The jury said it did find that many of Georgia's registration and election laws are outmoded or inadequate and often ambiguous ...

### 2. Creating an instance on WordFrequenciesCalculator

```st
counter := WordFrequenciesCounter withAlphabet: Alphabet english.
```

### 3. Calculating word frequencies

```st
frequencies := counter wordFrequenciesInFile: corpusFile.
```

### 4. Saving the frequencies table into a CSV file

```st
brownFrequenciesFile := '/Users/oleks/Documents/Data/brown-frequencies.csv' asFileReference.
```
```st
counter
    saveFrequencies: frequencies
    toCsv: brownFrequenciesFile.
```
```st
counter
    saveTop: 10000
    frequencies: frequencies
    toCsv: brownFrequenciesFile.
```
