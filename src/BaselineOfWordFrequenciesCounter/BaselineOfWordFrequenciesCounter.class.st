Class {
	#name : #BaselineOfWordFrequenciesCounter,
	#superclass : #BaselineOf,
	#category : #BaselineOfWordFrequenciesCounter
}

{ #category : #baselines }
BaselineOfWordFrequenciesCounter >> baseline: spec [
	<baseline>
	spec for: #common do: [	
		"Packages"
		spec 
			package: 'WordFrequenciesCounter';
			package: 'WordFrequenciesCounter-Tests' with: [ spec requires: #('WordFrequenciesCounter') ] ].
]
