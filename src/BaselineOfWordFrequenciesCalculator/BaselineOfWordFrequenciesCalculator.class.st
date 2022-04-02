Class {
	#name : #BaselineOfWordFrequenciesCalculator,
	#superclass : #BaselineOf,
	#category : #BaselineOfWordFrequenciesCalculator
}

{ #category : #baselines }
BaselineOfWordFrequenciesCalculator >> baseline: spec [
	<baseline>
	spec for: #common do: [	
		"Packages"
		spec 
			package: 'WordFrequenciesCalculator';
			package: 'WordFrequenciesCalculator-Tests' with: [ spec requires: #('WordFrequenciesCalculator') ] ].
]
