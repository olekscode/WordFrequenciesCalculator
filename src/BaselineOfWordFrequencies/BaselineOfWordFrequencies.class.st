Class {
	#name : #BaselineOfWordFrequencies,
	#superclass : #BaselineOf,
	#category : #BaselineOfWordFrequencies
}

{ #category : #baselines }
BaselineOfWordFrequencies >> baseline: spec [
	<baseline>
	spec for: #common do: [	
		"Packages"
		spec 
			package: 'WordFrequencies';
			package: 'WordFrequencies-Tests' with: [ spec requires: #('WordFrequencies') ] ].
]
