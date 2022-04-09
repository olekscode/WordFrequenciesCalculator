Class {
	#name : #WordFrequenciesCounterTest,
	#superclass : #TestCase,
	#instVars : [
		'counter'
	],
	#category : #'WordFrequenciesCounter-Tests'
}

{ #category : #initialization }
WordFrequenciesCounterTest >> setUp [

	counter := WordFrequenciesCounter new.
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
