Extension { #name : #String }

{ #category : #'*WordFrequenciesCalculator' }
String >> validLowercaseWords [
	"Split into words, convert to lowercase, remove all non-alphabetic characters"
	
	| words |
	words := self substrings.
	
	words := words
		collect: [ :word | word select: [ :c | c isLetter ] ]
		thenSelect: [ :word | word isNotEmpty ].
		
	words := words collect: [ :word | word asLowercase ].
	^ words
	
	
]
