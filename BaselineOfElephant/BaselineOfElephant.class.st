Class {
	#name : #BaselineOfElephant,
	#superclass : #BaselineOf,
	#category : #BaselineOfElephant
}

{ #category : #baselines }
BaselineOfElephant >> baseline: spec [
	<baseline>
	spec
		for: #pharo
		do: [
			"Packages"
			spec
				package: 'Elephant']
]

{ #category : #accessing }
BaselineOfElephant >> projectClass [

	^ MetacelloCypressBaselineProject
]
