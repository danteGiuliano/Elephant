Class {
	#name : #H5,
	#superclass : #StringMorph,
	#category : #'Small-UI-Text'
}

{ #category : #accessing }
H5 class >> content:stringContent [
|temp|
temp :=self new.
temp contents:stringContent.
temp font:(LogicalFont
				 familyName: StandardFonts defaultFont familyName
				 pointSize: 12).
^temp
]
