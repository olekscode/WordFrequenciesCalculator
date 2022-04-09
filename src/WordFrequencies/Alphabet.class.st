Class {
	#name : #Alphabet,
	#superclass : #Object,
	#category : #WordFrequencies
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
	"Special letters:
		3 letters with grave accent (à, è, ù)
		1 acute accent (é)
		5 circumflex (â, ê, î, ô, û)
		4 tréma (ë, ï, ü, ÿ)
		2 orthographic ligatures (æ, œ)
		1 cedilla (ç)"
	
	^ 'AÀÂÆBCÇDEÉÈÊËFGHIÎÏJKLMNOÔŒPQRSTUÙÛÜVWXYŸZaàâæbcçdeéèêëfghiîïjklmnoôœpqrstuùûüvwxyÿz'
]

{ #category : #'as yet unclassified' }
Alphabet class >> german [
	"Special letters:
		3 umlauts (ä, ö, ü)
		1 ligature - scharfes S (ß)"

	^ 'AÄBCDEFGHIJKLMNOÖPQRSẞTUÜVWXYZaäbcdefghijklmnoöpqrsßtuüvwxyz'
]

{ #category : #'as yet unclassified' }
Alphabet class >> spanish [
	"Special letters:
		1 letter with tilde (ñ)
		5 letters with acute accent (á, é, í, ó, ú)
		1 diaeresis (ü)"
		
	^ 'AÁBCDEÉFGHIÍJKLMNÑOÓPQRSTUÚÜVWXYZaábcdeéfghiíjklmnñoópqrstuúüvwxyz'
]
