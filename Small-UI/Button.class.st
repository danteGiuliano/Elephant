Class {
	#name : #Button,
	#superclass : #Morph,
	#instVars : [
		'target',
		'actionSelector',
		'arguments',
		'actWhen',
		'aBlock',
		'label',
		'oldColor'
	],
	#category : #'Small-UI-Buttons'
}

{ #category : #'as yet unclassified' }
Button class >> create:aName [
|temp|.
temp:=self new.
^temp initializeButton:aName.
]

{ #category : #'as yet unclassified' }
Button class >> create:aName size:aSize [
|temp|.
temp:=self new.
temp extent:aSize.
temp text:aName.
^temp.
]

{ #category : #'as yet unclassified' }
Button class >> icon:aIcon size:aSize [
|temp|
temp :=self new.
temp extent:aSize.
temp icon:aIcon.
^temp
]

{ #category : #accessing }
Button >> actWhen [
	^ actWhen
]

{ #category : #accessing }
Button >> actWhen: condition [
	actWhen := condition.
	actWhen == #startDrag
		ifFalse: [self on: #startDrag send: nil to: nil ]
		ifTrue:[self on: #startDrag send: #doButtonAction to: self].
]

{ #category : #accessing }
Button >> actionSelector [

	^ actionSelector
]

{ #category : #accessing }
Button >> actionSelector: aSymbolOrString [

	(nil = aSymbolOrString or:
	 ['nil' = aSymbolOrString or:
	 [aSymbolOrString isEmpty]])
		ifTrue: [^ actionSelector := nil].

	actionSelector := aSymbolOrString asSymbol.
]

{ #category : #accessing }
Button >> arguments [

	^ arguments
]

{ #category : #accessing }
Button >> arguments: aCollection [

	arguments := aCollection asArray copy.
]

{ #category : #initialization }
Button >> centerText [
label center:self center.
]

{ #category : #accessing }
Button >> clearTarget [

	target := nil.
]

{ #category : #accessing }
Button >> disable [ 
self clearTarget.
]

{ #category : #accessing }
Button >> doButtonAction [
	(target notNil and: [actionSelector notNil]) 
		ifTrue: 
			[Cursor normal 
				showWhile: [target perform: actionSelector withArguments: arguments]].
	actWhen == #startDrag ifTrue: [oldColor ifNotNil: [self color: oldColor]]
]

{ #category : #accessing }
Button >> font:aFont [
label font:aFont
]

{ #category : #accessing }
Button >> handlesMouseDown: evt [
	^  true
]

{ #category : #accessing }
Button >> handlesMouseStillDown: evt [
	^actWhen == #whilePressed
]

{ #category : #accessing }
Button >> icon:aIconMorph [
self addMorph:aIconMorph.
aIconMorph resize:self extent.
aIconMorph center:self center.
]

{ #category : #accessing }
Button >> initialize [
super initialize.
self borderWidth: 1.
	self color: (Color r: 0.4 g: 0.8 b: 0.6).
	self borderColor: self color darker.
	self borderStyle: BorderStyle thinGray.
actionSelector := #flash.
arguments := EmptyArray.
actWhen := #buttonUp.
self setDefaultLabel.
]

{ #category : #accessing }
Button >> mouseAction:aEvent [
aBlock :=aEvent
]

{ #category : #accessing }
Button >> mouseDown: evt [

	super mouseDown: evt.
	evt yellowButtonPressed ifTrue: [ ^self ] .
	oldColor := self fillStyle. 
	actWhen == #buttonDown
		ifTrue: [ self doButtonAction]
		ifFalse: [ self updateVisualState: evt ].
	self mouseStillDown: evt.
]

{ #category : #accessing }
Button >> mouseMove: evt [
	actWhen == #buttonDown ifTrue: [^ self].
	self updateVisualState: evt.
]

{ #category : #accessing }
Button >> mouseStillDown: evt [
	actWhen == #whilePressed ifFalse:[^self].
	(self containsPoint: evt cursorPoint) ifTrue:[self doButtonAction].
]

{ #category : #accessing }
Button >> mouseStillDownStepRate [
	^200
]

{ #category : #accessing }
Button >> mouseUp:evt [
	super mouseUp: evt.
	oldColor ifNotNil:[
		self color: oldColor.
		oldColor := nil.
		(self containsPoint: evt cursorPoint) 
				ifTrue: [ actWhen == #buttonUp 
							ifTrue: [self doButtonAction]  ]
				ifFalse: [ self mouseLeave: evt "This is a balk. Note that we have left." ]].
aBlock value.
]

{ #category : #accessing }
Button >> setDefaultLabel [
label :=StringMorph new contents:''.
self addMorph:label.
label center:self center.
]

{ #category : #accessing }
Button >> setTarget: evt [ 
	| rootMorphs |
	rootMorphs := self world rootMorphsAt: evt hand targetPoint.
	target := rootMorphs size > 1
				ifTrue: [rootMorphs second]
]

{ #category : #accessing }
Button >> target [

	^ target
]

{ #category : #accessing }
Button >> target: anObject [

	target := anObject
]

{ #category : #accessing }
Button >> text:aString [
label contents:aString.
label center:self center.
]

{ #category : #initialization }
Button >> textColor [ 
^label color.
]

{ #category : #initialization }
Button >> textColor:aColor [
label color:aColor.
]

{ #category : #accessing }
Button >> textSize:aSize [
label contents font:(label contents font
        pointSize: aSize).
label center:self center
]

{ #category : #accessing }
Button >> updateVisualState: evt [
	
	oldColor ifNotNil: [
		 self color: 
			((self containsPoint: evt cursorPoint)
				ifTrue: [oldColor mixed: 0.5 with: Color white]
				ifFalse: [oldColor])]
]
