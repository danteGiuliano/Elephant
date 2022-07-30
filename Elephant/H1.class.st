Class {
	#name : #H1,
	#superclass : #StringMorph,
	#category : #'Elephant-Text'
}

{ #category : #accessing }
H1 class >> content:stringContent [
|temp|
temp :=self new.
temp contents:stringContent.
temp font: (LogicalFont
				 familyName:StandardFonts defaultFont familyName
				 pointSize: 10).
^temp
]
