Class {
	#name : #AlphabetTest,
	#superclass : #TestCase,
	#category : #'WordFrequenciesCalculator-Tests'
}

{ #category : #tests }
AlphabetTest >> testDutchAlphabet [
	"26 lowercase + 26 uppercase letters = 52"
	self assert: Alphabet dutch size equals: 52.
]

{ #category : #tests }
AlphabetTest >> testEnglishAlphabet [
	"26 lowercase + 26 uppercase letters = 52"
	self assert: Alphabet english size equals: 52.
]

{ #category : #tests }
AlphabetTest >> testFrenchAlphabet [
	"26 letters + 16 special letters:
		3 letters with grave accent (à, è, ù)
		1 acute accent (é)
		5 circumflex (â, ê, î, ô, û)
		4 tréma (ë, ï, ü, ÿ)
		2 orthographic ligatures (æ, œ)
		1 cedilla (ç)
	42 lowercase + 42 uppercase letters = 84"
	
	self assert: Alphabet french size equals: 84.
]

{ #category : #tests }
AlphabetTest >> testGermanAlphabet [
	"26 letters + 4 special letters:
		3 umlauts (ä, ö, ü)
		1 ligature - scharfes S (ß)
	30 lowercase + 30 uppercase letters = 60"
	
	self assert: Alphabet german size equals: 60.
]

{ #category : #tests }
AlphabetTest >> testSpanishAlphabet [
	"26 letters + 7 special letters:
		1 letter with tilde (ñ)
		5 letters with acute accent (á, é, í, ó, ú)
		1 diaeresis (ü)
	33 lowercase + 33 uppercase letters = 66"
	
	self assert: Alphabet spanish size equals: 66.
]
