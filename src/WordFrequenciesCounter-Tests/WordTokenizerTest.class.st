Class {
	#name : #WordTokenizerTest,
	#superclass : #TestCase,
	#instVars : [
		'tokenizer'
	],
	#category : #'WordFrequenciesCounter-Tests'
}

{ #category : #initialization }
WordTokenizerTest >> setUp [

	tokenizer := WordTokenizer new.
]

{ #category : #tests }
WordTokenizerTest >> testCleanWords [

	| dirtyWords cleanWords expectedCleanWords |
	
	dirtyWords := #('Lorem' 'ipsum,' 'doL32or' 'àáâäÀÆÃ' 'it''s').
	expectedCleanWords := #('lorem' 'ipsum' 'dolor' 'àáâäàæã' 'it''s').
	
	cleanWords := tokenizer cleanWords: dirtyWords.
	self assert: cleanWords equals: expectedCleanWords.
]

{ #category : #tests }
WordTokenizerTest >> testFilterWords [
	"Alphabet not specified - only remove empty words"
	| words filteredWords expectedFilteredWords |
	
	words := #('let''s' '' 'dance' '' 'ich' 'heiße' 'Benoît').
	expectedFilteredWords := #('let''s' 'dance' 'ich' 'heiße' 'Benoît').
	
	filteredWords := tokenizer filterWords: words.
	self assert: filteredWords equals: expectedFilteredWords.
]

{ #category : #tests }
WordTokenizerTest >> testFilterWordsWithAlphabet [

	| words filteredWords expectedFilteredWords |
	
	tokenizer alphabet: Alphabet french.
	
	words := #('let''s' '' 'dance' '' 'ich' 'heiße' 'Benoît').
	expectedFilteredWords := #('let''s' 'dance' 'ich' 'Benoît').
	
	filteredWords := tokenizer filterWords: words.
	self assert: filteredWords equals: expectedFilteredWords.
]

{ #category : #tests }
WordTokenizerTest >> testSplitIntoWords [

	| text words expectedWords |
	
	text := 'let''s make open-source'.
	expectedWords := #('let''s' 'make' 'open' 'source').
	
	words := tokenizer splitIntoWords: text.
	self assert: words equals: expectedWords.
]

{ #category : #tests }
WordTokenizerTest >> testWithAlphabet [

	tokenizer := WordTokenizer withAlphabet: 'abc'.
	self assert: tokenizer alphabet equals: 'abc'
]
