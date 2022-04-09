Class {
	#name : #WordFrequenciesCounter,
	#superclass : #Object,
	#instVars : [
		'alphabet'
	],
	#category : #WordFrequenciesCounter
}

{ #category : #'as yet unclassified' }
WordFrequenciesCounter class >> withAlphabet: aString [

	^ self new
		alphabet: aString;
		yourself.
]

{ #category : #accessing }
WordFrequenciesCounter >> alphabet: aString [
	"Words that have at least one character outside this alphabet will be filtered out.
	If alphabet is not specified, all words will be considered valid"
	alphabet := aString
]

{ #category : #calculating }
WordFrequenciesCounter >> calculateWordFrequencies: aString [
	"Count word frequencies in a text and return the dictionary"
	| words |

	words := self splitIntoWords: aString.
	words := self cleanWords: words.
	words := self filterWords: words.
		
	^ words asBag valuesAndCounts.
	
]

{ #category : #'word preprocessing' }
WordFrequenciesCounter >> cleanWords: aCollectionOfWords [
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
WordFrequenciesCounter >> filterWords: aCollectionOfWords [
	"Remove empty words. If alphabet is specified, remove all words that have at least one character outside the alphabet. For example, in English texts, we want to remove all words that have French characters"
	| words |
	words := aCollectionOfWords select: [ :word | word isNotEmpty ].
	
	"If alphabet is specified, select only those words that have valid characters"
	alphabet ifNotNil: [ 
		words := words select: [ :word | word
			allSatisfy: [ :c | (alphabet includes: c) or: [ c = $' ] ] ] ].
	
	^ words
	
	
]

{ #category : #'file in/out' }
WordFrequenciesCounter >> saveFrequencies: aDictionary toCsv: aFileReference [

	aFileReference writeStreamDo: [ :stream |
		aDictionary keysAndValuesDo: [ :word :count |
			stream
				nextPutAll: word;
				nextPut: $,;
				nextPutAll: count asString;
				cr ] ].
]

{ #category : #'file in/out' }
WordFrequenciesCounter >> saveTop: aNumber frequencies: anOrderedDictionary toCsv: aFileReference [

	| topWords topWordFrequencies |
	topWords := anOrderedDictionary keys first: aNumber.
	
	topWordFrequencies := (topWords collect: [ :word |
		word -> (anOrderedDictionary at: word) ]) asOrderedDictionary.
	
	self saveFrequencies: topWordFrequencies toCsv: aFileReference
]

{ #category : #'word preprocessing' }
WordFrequenciesCounter >> splitIntoWords: aString [
	"Answer an array of non-empty substrings from the receiver separated by
	one or more whitespace characters or a dash."
	
	"self splitIntoWords: 'let''s make open-source' >>>  #('let''s' 'make' 'open' 'source')"
	
	^ aString substrings: (CharacterSet separators, { $- })
]

{ #category : #calculating }
WordFrequenciesCounter >> wordFrequenciesInFile: aFileReference [
	
	| frequencies frequenciesInLine |
	frequencies := Dictionary new.

	aFileReference readStreamDo: [ :stream |
		[ stream atEnd ] whileFalse: [ 
			frequenciesInLine := self calculateWordFrequencies: stream nextLine.
			
			frequenciesInLine keysAndValuesDo: [ :word :count |
				frequencies at: word put: ((frequencies at: word ifAbsent: [ 0 ]) + count) ] ] ].
	
	"Sort frequencies in descending order"
	^ (frequencies associations sorted: [ :a :b | a value > b value ]) asOrderedDictionary.
]

{ #category : #calculating }
WordFrequenciesCounter >> wordFrequenciesInString: aString [
	
	| frequencies |
	frequencies := self calculateWordFrequencies: aString.
	
	"Sort frequencies in descending order"
	^ (frequencies associations sorted: [ :a :b | a value > b value ]) asOrderedDictionary.
	
]
