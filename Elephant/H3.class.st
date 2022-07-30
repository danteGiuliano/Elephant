Class {
	#name : #H3,
	#superclass : #StringMorph,
	#category : #'Elephant-Text'
}

{ #category : #accessing }
H3 class >> content:stringContent [
|temp|
temp :=self new.
temp contents:stringContent.
temp font:(LogicalFont
				 familyName: StandardFonts defaultFont familyName
				 pointSize: 18).
^temp
]
