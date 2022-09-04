"
a simple button circle 

ButtonCircle create:'Hello!' size: 200


"
Class {
	#name : #ButtonCircle,
	#superclass : #CircleMorph,
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
ButtonCircle class >> create:aName size:aSize [
|temp|.
temp:=self new.
temp extent:aSize@aSize.
temp text:aName.
^temp.
]

{ #category : #'as yet unclassified' }
ButtonCircle class >> create:aName size:aSize color:aColor [
|temp|.
temp:=self new.
temp extent:aSize@aSize.
temp text:aName.
temp color:aColor.
^temp.
]

{ #category : #'as yet unclassified' }
ButtonCircle class >> create:aName size:aSize icon:aIcon [
|temp|.
temp:=self new.
temp extent:aSize@aSize.
temp text:aName.
temp icon:aIcon.
^temp.
]

{ #category : #accessing }
ButtonCircle >> actWhen [
	^ actWhen
]

{ #category : #accessing }
ButtonCircle >> actWhen: condition [
	actWhen := condition.
	actWhen == #startDrag
		ifFalse: [self on: #startDrag send: nil to: nil ]
		ifTrue:[self on: #startDrag send: #doButtonAction to: self].
]

{ #category : #accessing }
ButtonCircle >> actionSelector [

	^ actionSelector
]

{ #category : #accessing }
ButtonCircle >> actionSelector: aSymbolOrString [

	(nil = aSymbolOrString or:
	 ['nil' = aSymbolOrString or:
	 [aSymbolOrString isEmpty]])
		ifTrue: [^ actionSelector := nil].

	actionSelector := aSymbolOrString asSymbol.
]

{ #category : #accessing }
ButtonCircle >> arguments [

	^ arguments
]

{ #category : #accessing }
ButtonCircle >> arguments: aCollection [

	arguments := aCollection asArray copy.
]

{ #category : #menu }
ButtonCircle >> clearTarget [

	target := nil.
]

{ #category : #protocol }
ButtonCircle >> disable [ 
self clearTarget.
]

{ #category : #button }
ButtonCircle >> doButtonAction [
	(target notNil and: [actionSelector notNil]) 
		ifTrue: 
			[Cursor normal 
				showWhile: [target perform: actionSelector withArguments: arguments]].
	actWhen == #startDrag ifTrue: [oldColor ifNotNil: [self color: oldColor]]
]

{ #category : #accessing }
ButtonCircle >> fitContents [
	| aMorph aCenter |
	aCenter := self center.
	submorphs isEmpty ifTrue: [^self].
	aMorph := submorphs first.
	self extent: aMorph extent + (borderWidth + 6).
	self center: aCenter.
	aMorph position: aCenter - (aMorph extent // 2)
]

{ #category : #Style }
ButtonCircle >> font:aFont [
label font:aFont
]

{ #category : #'event handling' }
ButtonCircle >> handlesMouseDown: evt [
	^  true
]

{ #category : #'event handling' }
ButtonCircle >> handlesMouseStillDown: evt [
	^actWhen == #whilePressed
]

{ #category : #Style }
ButtonCircle >> icon:aIconMorph [
self addMorph:aIconMorph.
aIconMorph resize:self extent.
aIconMorph center:self center.
]

{ #category : #initialization }
ButtonCircle >> initialize [
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

{ #category : #initialization }
ButtonCircle >> mouseAction:aEvent [
aBlock :=aEvent
]

{ #category : #'event handling' }
ButtonCircle >> mouseDown: evt [

	super mouseDown: evt.
	evt yellowButtonPressed ifTrue: [ ^self ] .
	oldColor := self fillStyle. 
	actWhen == #buttonDown
		ifTrue: [ self doButtonAction]
		ifFalse: [ self updateVisualState: evt ].
	self mouseStillDown: evt.
]

{ #category : #'event handling' }
ButtonCircle >> mouseMove: evt [
	actWhen == #buttonDown ifTrue: [^ self].
	self updateVisualState: evt.
]

{ #category : #'event handling' }
ButtonCircle >> mouseStillDown: evt [
	actWhen == #whilePressed ifFalse:[^self].
	(self containsPoint: evt cursorPoint) ifTrue:[self doButtonAction].
]

{ #category : #'event handling' }
ButtonCircle >> mouseStillDownStepRate [
	^200
]

{ #category : #'event handling' }
ButtonCircle >> mouseUp:evt [
	super mouseUp: evt.
	oldColor ifNotNil:
		["if oldColor nil, it signals that mouse had not gone DOWN
		inside me, e.g. because of a cmd-drag; in this case we want
		to avoid triggering the action!"
		self color: oldColor.
		oldColor := nil.
		(self containsPoint: evt cursorPoint) 
				ifTrue: [ actWhen == #buttonUp 
							ifTrue: [self doButtonAction]  ]
				ifFalse: [ self mouseLeave: evt "This is a balk. Note that we have left." ]].
aBlock value.
]

{ #category : #initialization }
ButtonCircle >> setDefaultLabel [
label :=StringMorph new contents:''.
self addMorph:label.
label center:self center.
]

{ #category : #initialization }
ButtonCircle >> setTarget: evt [ 
	| rootMorphs |
	rootMorphs := self world rootMorphsAt: evt hand targetPoint.
	target := rootMorphs size > 1
				ifTrue: [rootMorphs second]
]

{ #category : #accessing }
ButtonCircle >> target [

	^ target
]

{ #category : #accessing }
ButtonCircle >> target: anObject [

	target := anObject
]

{ #category : #Style }
ButtonCircle >> text:aString [
label contents:aString.
label center:self center.
]

{ #category : #Style }
ButtonCircle >> textSize:aSize [
label contents font:(label contents font
        pointSize: aSize).
label center:self center
]

{ #category : #'event handling' }
ButtonCircle >> updateVisualState: evt [
	
	oldColor ifNotNil: [
		 self color: 
			((self containsPoint: evt cursorPoint)
				ifTrue: [oldColor mixed: 0.5 with: Color white]
				ifFalse: [oldColor])]
]
