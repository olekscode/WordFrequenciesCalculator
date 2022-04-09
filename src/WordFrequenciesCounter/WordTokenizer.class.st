Class {
	#name : #WordTokenizer,
	#superclass : #Object,
	#instVars : [
		'alphabet'
	],
	#category : #WordFrequenciesCounter
}

{ #category : #'as yet unclassified' }
WordTokenizer class >> withAlphabet: aString [

	^ self new
		alphabet: aString;
		yourself.
]

{ #category : #accessing }
WordTokenizer >> alphabet [

	^ alphabet
]

{ #category : #accessing }
WordTokenizer >> alphabet: aString [
	"Words that have at least one character outside this alphabet will be filtered out.
	If alphabet is not specified, all words will be considered valid"
	alphabet := aString
]

{ #category : #'word preprocessing' }
WordTokenizer >> cleanWords: aCollectionOfWords [
	"Remove non-letter characters and convert to lowercase"
	| words |
	
	"Remove all non-letter characters except the apostrophe ' (e.g., punctuation)"
	words := aCollectionOfWords collect: [ :word |
		word select: [ :c | c isLetter or: [ c = $' ] ] ].
		
	"Convert each word to lowercase"
	words := words collect: [ :word | word asLowercase ].
	^ words
]

{ #category : #'word preprocessing' }
WordTokenizer >> filterWords: aCollectionOfWords [
	"Remove empty words. If alphabet is specified, remove all words that have at least one character outside the alphabet. For example, in English texts, we want to remove all words that have French characters"
	| words |
	words := aCollectionOfWords select: [ :word | word isNotEmpty ].
	
	"If alphabet is specified, select only those words that have valid characters"
	alphabet ifNotNil: [ 
		words := words select: [ :word | word
			allSatisfy: [ :c | (alphabet includes: c) or: [ c = $' ] ] ] ].
	
	^ words
	
	
]

{ #category : #'word preprocessing' }
WordTokenizer >> splitIntoWords: aString [
	"Answer an array of non-empty substrings from the receiver separated by
	one or more whitespace characters or a dash."
	
	"self splitIntoWords: 'let''s make open-source' >>>  #('let''s' 'make' 'open' 'source')"
	
	^ aString substrings: (CharacterSet separators, { $- })
]

{ #category : #public }
WordTokenizer >> tokenize: aString [ 
	
	| words |
	words := self splitIntoWords: aString.
	words := self cleanWords: words.
	words := self filterWords: words.
	^ words
]
