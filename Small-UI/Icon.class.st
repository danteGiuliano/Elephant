Class {
	#name : #Icon,
	#superclass : #ImageMorph,
	#category : #'Small-UI-Display'
}

{ #category : #accessing }
Icon class >> src:aStringRoute [
^self fromStream:((File named:aStringRoute asFileReference fullName ) readStream)
]
