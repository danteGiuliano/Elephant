Class {
	#name : #H4,
	#superclass : #StringMorph,
	#category : #'Small-UI-Text'
}

{ #category : #accessing }
H4 class >> content:stringContent [
|temp|
temp :=self new.
temp contents:stringContent.
temp font:(LogicalFont
				 familyName: StandardFonts defaultFont familyName
				 pointSize: 16).
^temp
]
