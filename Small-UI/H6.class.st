Class {
	#name : #H6,
	#superclass : #StringMorph,
	#category : #'Small-UI-Text'
}

{ #category : #accessing }
H6 class >> content:stringContent [
|temp|
temp :=self new.
temp contents:stringContent.
temp font:(LogicalFont
				 familyName: StandardFonts defaultFont familyName
				 pointSize: 9).
^temp
]
