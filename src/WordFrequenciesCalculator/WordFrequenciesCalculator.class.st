Class {
	#name : #WordFrequenciesCalculator,
	#superclass : #Object,
	#instVars : [
		'frequencies',
		'alphabet'
	],
	#category : #WordFrequenciesCalculator
}

{ #category : #'as yet unclassified' }
WordFrequenciesCalculator class >> withAlphabet: aString [

	^ self new
		alphabet: aString;
		yourself.
]

{ #category : #accessing }
WordFrequenciesCalculator >> alphabet: aString [
	"Words that have at least one character outside this alphabet will be filtered out.
	If alphabet is not specified, all words will be considered valid"
	alphabet := aString
]

{ #category : #'as yet unclassified' }
WordFrequenciesCalculator >> calculateWordFrequenciesInCorpus: aFileReference [
	
	| words sentenceFrequencies |
	frequencies := Dictionary new.

	aFileReference readStreamDo: [ :stream |
		[ stream atEnd ] whileFalse: [ 
			words := stream nextLine validLowercaseWords.
			
			"If alphabet is specified, select only those words that have valid characters"
			alphabet ifNotNil: [ 
				words := words select: [ :word | word
					allSatisfy: [ :c | alphabet includes: c ] ] ].
		
			sentenceFrequencies := words asBag valuesAndCounts.
			
			sentenceFrequencies keysAndValuesDo: [ :word :count |
				frequencies at: word put: ((frequencies at: word ifAbsent: [ 0 ]) + count) ] ] ].
	
	"Sort frequencies in descending order"
	frequencies := (frequencies associations sorted: [ :a :b | a value > b value ]) asOrderedDictionary.
]

{ #category : #accessing }
WordFrequenciesCalculator >> frequencies [

	^ frequencies 
]

{ #category : #initialization }
WordFrequenciesCalculator >> initialize [ 

	super initialize.
	frequencies := Dictionary new.
]

{ #category : #'as yet unclassified' }
WordFrequenciesCalculator >> saveFrequencies: aDictionary toCsv: aFileReference [

	aFileReference writeStreamDo: [ :stream |
		aDictionary keysAndValuesDo: [ :word :count |
			stream
				nextPutAll: word;
				nextPut: $,;
				nextPutAll: count asString;
				cr ] ].
]

{ #category : #'as yet unclassified' }
WordFrequenciesCalculator >> saveToCsv: aFileReference [

	self saveFrequencies: frequencies toCsv: aFileReference
]

{ #category : #'as yet unclassified' }
WordFrequenciesCalculator >> saveTop: aNumber toCsv: aFileReference [

	| topWords topWordFrequencies |
	topWords := frequencies keys first: aNumber.
	
	topWordFrequencies := (topWords collect: [ :word |
		word -> (frequencies at: word) ]) asOrderedDictionary.
	
	self saveFrequencies: topWordFrequencies toCsv: aFileReference
]
