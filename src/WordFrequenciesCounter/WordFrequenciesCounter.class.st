Class {
	#name : #WordFrequenciesCounter,
	#superclass : #Object,
	#instVars : [
		'tokenizer'
	],
	#category : #WordFrequenciesCounter
}

{ #category : #calculating }
WordFrequenciesCounter >> calculateWordFrequencies: aString [
	"Count word frequencies in a text and return the dictionary"
	| words |
	words := tokenizer tokenize: aString.
	^ words asBag valuesAndCounts.
	
]

{ #category : #initialization }
WordFrequenciesCounter >> initialize [

	tokenizer := WordTokenizer new.
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
