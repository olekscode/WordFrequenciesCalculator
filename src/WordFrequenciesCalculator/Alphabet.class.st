Class {
	#name : #Alphabet,
	#superclass : #Object,
	#category : #WordFrequenciesCalculator
}

{ #category : #'as yet unclassified' }
Alphabet class >> dutch [

	^ self english
]

{ #category : #'as yet unclassified' }
Alphabet class >> english [

	^ 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'
]

{ #category : #'as yet unclassified' }
Alphabet class >> french [

	^ 'AÀÂÆBCÇDEÉÈÊËFGHIÎÏJKLMNOÔŒPQRSTUÙÛÜVWXYŸZaàâæbcçdeéèêëfghiîïjklmnoôœpqrstuùûüvwxyÿz'
]

{ #category : #'as yet unclassified' }
Alphabet class >> german [

	^ 'AÄBCDEFGHIJKLMNOÖPQRSẞTUÜVWXYZaäbcdefghijklmnoöpqrsßtuüvwxyz'
]

{ #category : #'as yet unclassified' }
Alphabet class >> spanish [

	^ 'AÁBCDEÉFGHIÍJKLMNÑOÓPQRSTUÚÜVWXYZaábcdeéfghiíjklmnñoópqrstuúüvwxyz'
]
