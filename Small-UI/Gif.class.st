Class {
	#name : #Gif,
	#superclass : #AnimatedImageMorph,
	#category : #'Small-UI-Display'
}

{ #category : #accessing }
Gif class >> src:aStringRouteFile [
|fs gif |
fs := aStringRouteFile asFileReference binaryReadStream.
gif := GIFReadWriter on: fs.
gif
   readHeader;
   readBody.
^self fromGIFReader:gif.
]
