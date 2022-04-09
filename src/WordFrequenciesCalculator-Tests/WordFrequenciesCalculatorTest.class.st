Class {
	#name : #WordFrequenciesCalculatorTest,
	#superclass : #TestCase,
	#instVars : [
		'frequenciesCalculator'
	],
	#category : #'WordFrequenciesCalculator-Tests'
}

{ #category : #initialization }
WordFrequenciesCalculatorTest >> setUp [

	frequenciesCalculator := WordFrequenciesCounter new.
]

{ #category : #tests }
WordFrequenciesCalculatorTest >> testCleanWords [

	| dirtyWords cleanWords expectedCleanWords |
	
	dirtyWords := #('Lorem' 'ipsum,' 'doL32or' 'àáâäÀÆÃ' 'it''s').
	expectedCleanWords := #('lorem' 'ipsum' 'dolor' 'àáâäàæã' 'it''s').
	
	cleanWords := frequenciesCalculator cleanWords: dirtyWords.
	self assert: cleanWords equals: expectedCleanWords.
]

{ #category : #tests }
WordFrequenciesCalculatorTest >> testFilterWords [
	"Alphabet not specified - only remove empty words"
	| words filteredWords expectedFilteredWords |
	
	words := #('let''s' '' 'dance' '' 'ich' 'heiße' 'Benoît').
	expectedFilteredWords := #('let''s' 'dance' 'ich' 'heiße' 'Benoît').
	
	filteredWords := frequenciesCalculator filterWords: words.
	self assert: filteredWords equals: expectedFilteredWords.
]

{ #category : #tests }
WordFrequenciesCalculatorTest >> testFilterWordsWithAlphabet [

	| words filteredWords expectedFilteredWords |
	
	frequenciesCalculator alphabet: Alphabet french.
	
	words := #('let''s' '' 'dance' '' 'ich' 'heiße' 'Benoît').
	expectedFilteredWords := #('let''s' 'dance' 'ich' 'Benoît').
	
	filteredWords := frequenciesCalculator filterWords: words.
	self assert: filteredWords equals: expectedFilteredWords.
]

{ #category : #tests }
WordFrequenciesCalculatorTest >> testSplitIntoWords [

	| text words expectedWords |
	
	text := 'let''s make open-source'.
	expectedWords := #('let''s' 'make' 'open' 'source').
	
	words := frequenciesCalculator splitIntoWords: text.
	self assert: words equals: expectedWords.
]
