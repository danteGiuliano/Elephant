Class {
	#name : #TextBox,
	#superclass : #RubScrolledTextMorph,
	#category : #'Small-UI-Input'
}

{ #category : #accessing }
TextBox class >> size:aSize [ 
^self new extent:aSize.
]
