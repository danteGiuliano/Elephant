Class {
	#name : #BaselineOfElephant,
	#superclass : #BaselineOf,
	#category : #'BaselineOfSmall-UI'
}

{ #category : #baselines }
BaselineOfElephant >> baseline: spec [
	<baseline>
	spec
		for: #pharo
		do: [
			"Packages"
			spec
				package: 'Small-UI']
]

{ #category : #accessing }
BaselineOfElephant >> projectClass [

	^ MetacelloCypressBaselineProject
]
