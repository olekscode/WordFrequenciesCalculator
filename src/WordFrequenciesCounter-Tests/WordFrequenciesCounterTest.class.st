Class {
	#name : #WordFrequenciesCounterTest,
	#superclass : #TestCase,
	#instVars : [
		'counter'
	],
	#category : #'WordFrequenciesCounter-Tests'
}

{ #category : #'private - testing' }
WordFrequenciesCounterTest >> areValuesSorted: anOrderedDictionary [
	"Answer true if values of an OrderedDictionary are sorted in the descending order"
	| values |
	anOrderedDictionary size < 2 ifTrue: [ ^ true ].
	
	values := anOrderedDictionary values.
	
	2 to: values size do: [ :i |
		(values at: i) > (values at: i - 1) ifTrue: [ ^ false ] ].
	
	^ true
]

{ #category : #'tests - fixture' }
WordFrequenciesCounterTest >> exampleFileWithText [
	"Create an in-memory file containing a dummy text that will be used for testing"
	| text file |
	
	text := self exampleText.
	file := FileSystem memory / 'file.txt'.
	
	file writeStreamDo: [ :stream |
		stream nextPutAll: text ].
	
	^ file
]

{ #category : #'tests - fixture' }
WordFrequenciesCounterTest >> exampleFrequencies [
	
	^ { 
		'i' -> 3 .
		'am' -> 2 .
		'sam' -> 2 .
		'don''t' -> 1 .
		'like' -> 1 .
		'green' -> 1 .
		'eggs' -> 1 .
		'and' -> 1 .
		'ham' -> 1
	} asOrderedDictionary.
]

{ #category : #'tests - fixture' }
WordFrequenciesCounterTest >> exampleFrequenciesFileContents [
	
	^ 'i,3
am,2
sam,2
don''t,1
like,1
green,1
eggs,1
and,1
ham,1'
]

{ #category : #'tests - fixture' }
WordFrequenciesCounterTest >> exampleText [
	
	^ 'I am Sam,
Sam I am!
I don''t like green eggs and ham.'
]

{ #category : #'tests - fixture' }
WordFrequenciesCounterTest >> exampleTop5FrequenciesFileContents [
	
	^ String cr join: (self exampleFrequenciesFileContents lines first: 5)
]

{ #category : #initialization }
WordFrequenciesCounterTest >> setUp [

	counter := WordFrequenciesCounter new.
]

{ #category : #tests }
WordFrequenciesCounterTest >> testCalculateWordFrequencies [

	| text frequencies expectedFrequencies |
	
	text := self exampleText.
	expectedFrequencies := self exampleFrequencies asDictionary.
	
	frequencies := counter calculateWordFrequencies: text.
	self assert: frequencies equals: expectedFrequencies.
]

{ #category : #tests }
WordFrequenciesCounterTest >> testCleanWords [

	| dirtyWords cleanWords expectedCleanWords |
	
	dirtyWords := #('Lorem' 'ipsum,' 'doL32or' 'àáâäÀÆÃ' 'it''s').
	expectedCleanWords := #('lorem' 'ipsum' 'dolor' 'àáâäàæã' 'it''s').
	
	cleanWords := counter cleanWords: dirtyWords.
	self assert: cleanWords equals: expectedCleanWords.
]

{ #category : #tests }
WordFrequenciesCounterTest >> testFilterWords [
	"Alphabet not specified - only remove empty words"
	| words filteredWords expectedFilteredWords |
	
	words := #('let''s' '' 'dance' '' 'ich' 'heiße' 'Benoît').
	expectedFilteredWords := #('let''s' 'dance' 'ich' 'heiße' 'Benoît').
	
	filteredWords := counter filterWords: words.
	self assert: filteredWords equals: expectedFilteredWords.
]

{ #category : #tests }
WordFrequenciesCounterTest >> testFilterWordsWithAlphabet [

	| words filteredWords expectedFilteredWords |
	
	counter alphabet: Alphabet french.
	
	words := #('let''s' '' 'dance' '' 'ich' 'heiße' 'Benoît').
	expectedFilteredWords := #('let''s' 'dance' 'ich' 'Benoît').
	
	filteredWords := counter filterWords: words.
	self assert: filteredWords equals: expectedFilteredWords.
]

{ #category : #tests }
WordFrequenciesCounterTest >> testSaveFrequenciesToCsv [

	| frequencies file expectedContents |
	
	frequencies := self exampleFrequencies.
	file := FileSystem memory / 'frequencies.csv'.
	expectedContents := self exampleFrequenciesFileContents.
	
	counter saveFrequencies: frequencies toCsv: file.
	
	self assert: file contents trim equals: expectedContents.
]

{ #category : #tests }
WordFrequenciesCounterTest >> testSaveTopFrequenciesToCsv [

	| frequencies file expectedContents |
	
	frequencies := self exampleFrequencies.
	file := FileSystem memory / 'frequencies.csv'.
	expectedContents := self exampleTop5FrequenciesFileContents.
	
	counter saveTop: 5 frequencies: frequencies toCsv: file.
	
	self assert: file contents trim equals: expectedContents.
]

{ #category : #tests }
WordFrequenciesCounterTest >> testSplitIntoWords [

	| text words expectedWords |
	
	text := 'let''s make open-source'.
	expectedWords := #('let''s' 'make' 'open' 'source').
	
	words := counter splitIntoWords: text.
	self assert: words equals: expectedWords.
]

{ #category : #tests }
WordFrequenciesCounterTest >> testWordFrequenciesInFile [

	| file frequencies expectedFrequencies |
	
	file := self exampleFileWithText.
	expectedFrequencies := self exampleFrequencies.
	
	frequencies := counter wordFrequenciesInFile: file.
	self assert: frequencies equals: expectedFrequencies.
	
	"Check the order"
	self assert: (self areValuesSorted: frequencies).
]

{ #category : #tests }
WordFrequenciesCounterTest >> testWordFrequenciesInString [

	| text frequencies expectedFrequencies |
	
	text := self exampleText.
	expectedFrequencies := self exampleFrequencies.
	
	frequencies := counter wordFrequenciesInString: text.
	self assert: frequencies equals: expectedFrequencies.
	
	"Check the order"
	self assert: (self areValuesSorted: frequencies).
]
