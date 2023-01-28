Class {
	#name : #BaselineOfSmallUI,
	#superclass : #BaselineOf,
	#category : #'BaselineOfSmall-UI'
}

{ #category : #baselines }
BaselineOfSmallUI >> baseline: spec [
	<baseline>
	spec
		for: #pharo
		do: [
			"Packages"
			spec
				package: 'Small-UI']
]

{ #category : #accessing }
BaselineOfSmallUI >> projectClass [

	^ MetacelloCypressBaselineProject
]
