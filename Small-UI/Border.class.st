Class {
	#name : #Border,
	#superclass : #RoundedBorderStyle,
	#category : #'Small-UI-CSS'
}

{ #category : #'as yet unclassified' }
Border class >> r:aRadio color:aColor [
|br|
br := super new.
br cornerRadius:aRadio;width:aRadio.
br color:aColor.
^br
]
