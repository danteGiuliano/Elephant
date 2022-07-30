Class {
	#name : #H2,
	#superclass : #StringMorph,
	#category : #'Elephant-Text'
}

{ #category : #accessing }
H2 class >> content:stringContent [
|temp|
temp :=self new.
temp contents:stringContent.
temp font:(LogicalFont
				 familyName: StandardFonts defaultFont familyName
				 pointSize: 24).
^temp
]
