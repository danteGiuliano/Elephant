Class {
	#name : #Icon,
	#superclass : #ImageMorph,
	#category : #'Elephant-Display'
}

{ #category : #accessing }
Icon class >> src:aStringRoute [
^self fromStream:((File named:aStringRoute asFileReference fullName ) readStream)
]
