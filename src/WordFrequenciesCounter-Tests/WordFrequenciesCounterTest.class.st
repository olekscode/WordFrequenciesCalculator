Class {
	#name : #WordFrequenciesCounterTest,
	#superclass : #TestCase,
	#instVars : [
		'counter'
	],
	#category : #'WordFrequenciesCounter-Tests'
}

{ #category : #'as yet unclassified' }
WordFrequenciesCounterTest >> fileWithText [
	"Create an in-memory file containing a dummy text that will be used for testing"
	| text file |
	
	text := 'I am Sam,
Sam I am!
I don''t like green eggs and ham.'.

	file := FileSystem memory / 'file.txt'.
	
	file writeStreamDo: [ :stream |
		stream nextPutAll: text ].
	
	^ file
]

{ #category : #initialization }
WordFrequenciesCounterTest >> setUp [

	counter := WordFrequenciesCounter new.
]

{ #category : #tests }
WordFrequenciesCounterTest >> testCalculateWordFrequencies [

	| text frequencies expectedFrequencies |
	text := 'I am Sam, Sam I am! I don''t like green eggs and ham.'.
	
	expectedFrequencies := { 
		'i' -> 3 .
		'am' -> 2 .
		'sam' -> 2 .
		'don''t' -> 1 .
		'like' -> 1 .
		'green' -> 1 .
		'eggs' -> 1 .
		'and' -> 1 .
		'ham' -> 1
	} asDictionary.
	
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
	
	file := self fileWithText.
	
	expectedFrequencies := { 
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
	
	frequencies := counter wordFrequenciesInFile: file.
	self assert: frequencies equals: expectedFrequencies.
	
	"Check the order"
	2 to: frequencies size do: [ :i |
		self assert: (frequencies values at: i) <= (frequencies values at: i - 1) ]
]

{ #category : #tests }
WordFrequenciesCounterTest >> testWordFrequenciesInString [

	| text frequencies expectedFrequencies |
	text := 'I am Sam, Sam I am! I don''t like green eggs and ham.'.
	
	expectedFrequencies := { 
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
	
	frequencies := counter wordFrequenciesInString: text.
	self assert: frequencies equals: expectedFrequencies.
	
	"Check the order"
	2 to: frequencies size do: [ :i |
		self assert: (frequencies values at: i) <= (frequencies values at: i - 1) ]
]
