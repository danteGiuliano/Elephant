Class {
	#name : #TextBox,
	#superclass : #RubScrolledTextMorph,
	#category : #'Elephant-Input'
}

{ #category : #accessing }
TextBox class >> size:aSize [ 
^self new extent:aSize.
]
