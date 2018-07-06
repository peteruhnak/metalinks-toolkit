Class {
	#name : #MTMetaLinksInstallerTest,
	#superclass : #TestCase,
	#instVars : [
		'installer',
		'link',
		'target',
		'metaLink'
	],
	#category : 'MetaLinks-Toolkit-Tests'
}

{ #category : #cleaning }
MTMetaLinksInstallerTest class >> manualCleanup [
	10 timesRepeat: [ Smalltalk garbageCollect ].
	MTMetaLinksInstaller allInstances first.
	MTMetaLinksInstaller allInstances
		do: [ :each | SystemAnnouncer uniqueInstance unsubscribe: each ].
	MTMetaLinksInstaller destroyAllLinksEverywhereFor: MTElement.
	MTMetaLinksInstaller destroyAllLinksEverywhereFor: MTContainer
]

{ #category : #'as yet unclassified' }
MTMetaLinksInstallerTest class >> runHapaoTests [
	<script: 'self runHapaoTests inspect'>
	^ Hapao2
		runTestsForClasses:
			((RPackage organizer packageNamed: 'MetaLinks-Toolkit') classes
				copyWithoutAll:
					{MTElement.
					MTContainer.
					MTMetalinkIconStyler.
					MTMethodHasMetaLinkAction.
					MTPlaygroundExampleAction})
]

{ #category : #asserting }
MTMetaLinksInstallerTest >> array: actualCollection equals: expectedCollection [
	self assert: actualCollection asArray equals: expectedCollection asArray
]

{ #category : #asserting }
MTMetaLinksInstallerTest >> set: actualCollection equals: expectedCollection [
	self assert: actualCollection asSet equals: expectedCollection asSet
]

{ #category : #running }
MTMetaLinksInstallerTest >> setUp [
	super setUp.
	installer := MTMetaLinksInstaller new.
	target := MTElement new
]

{ #category : #running }
MTMetaLinksInstallerTest >> tearDown [
	super tearDown.
	installer uninstallAllPermanentLinksIn: MTElement.
	(MTElement selectors includes: #resetName)
		ifTrue: [ MTElement removeSelector: #resetName ]
]

{ #category : #tests }
MTMetaLinksInstallerTest >> testAssignmentNodes [
	self deny: (target class selectors includes: #resetName).
	self
		set: (installer assignmentNodesOf: #name in: target class)
		equals: {(target class >> #name:) ast assignmentNodes first}
]

{ #category : #tests }
MTMetaLinksInstallerTest >> testEnsureContains [
	| ast m1 m2 |
	m1 := MetaLink new.
	m2 := MetaLink new.
	ast := (target class >> #name) ast.
	self assert: ast links equals: nil.
	installer ensureNode: ast containsLink: m1.
	self set: ast links equals: {m1}.
	self assert: (target class >> #name) reflectiveMethod linkCount equals: 1.
	installer ensureNode: ast containsLink: m1.
	self set: ast links equals: {m1}.
	self assert: (target class >> #name) reflectiveMethod linkCount equals: 1.
	installer ensureNode: ast containsLink: m2.
	self set: ast links equals: (Set with: m1 with: m2).
	self assert: (target class >> #name) reflectiveMethod linkCount equals: 2
]

{ #category : #tests }
MTMetaLinksInstallerTest >> testExample [
	installer class example
]

{ #category : #tests }
MTMetaLinksInstallerTest >> testInstallAttribute [
	metaLink := MetaLink new.
	self deny: (target class >> #name:) hasLinks.
	self assert: (target class >> #name:) ast assignmentNodes first links equals: nil.
	self array: (installer attributeLinksAt: target class at: #name) equals: #().
	installer installPermanent: metaLink toAttribute: #name of: target class.
	self array: (installer attributeLinksAt: target class at: #name) equals: {metaLink}.
	self set: (target class >> #name:) ast assignmentNodes first links equals: {metaLink}
]

{ #category : #tests }
MTMetaLinksInstallerTest >> testInstallMethod [
	metaLink := MetaLink new.
	self assert: (target class >> #name) ast links equals: nil.
	self array: (installer methodLinksAt: target class at: #name) equals: #().
	installer installPermanent: metaLink toMethod: #name of: target class.
	self set: (target class >> #name) ast links equals: {metaLink}.
	self array: (installer methodLinksAt: target class at: #name) equals: {metaLink}
]

{ #category : #tests }
MTMetaLinksInstallerTest >> testNoAttributeLinkToInitialize [
	target primitiveChangeClassTo: target class newAnonymousSubclass new.
	metaLink := MetaLink new.
	installer installPermanent: metaLink toAttribute: #name of: target class.
	target class
		compile:
			'initialize
	super initialize.
	name := '''''.
	self assert: (target class >> #initialize) ast assignmentNodes first links equals: nil.
	self deny: (target class >> #initialize) hasLinks
]

{ #category : #tests }
MTMetaLinksInstallerTest >> testReinstallAttribute [
	target primitiveChangeClassTo: (target class subclass: (target className , 'ForTest') asSymbol) new.
	metaLink := MetaLink new.
	installer installPermanent: metaLink toAttribute: #name of: target class.
	target class compile: 'resetName name := ''some name'''.
	self set: (target class >> #resetName) ast assignmentNodes first links equals: {metaLink}
]

{ #category : #tests }
MTMetaLinksInstallerTest >> testReinstallMethod [
	target primitiveChangeClassTo: (target class subclass: (target className , 'ForTest') asSymbol) new.
	target class compile: 'name ^ name'.
	metaLink := MetaLink new.
	installer installPermanent: metaLink toMethod: #name of: target class.
	target class removeSelector: #name.
	self deny: (target class selectors includes: #name).
	target class compile: 'name ^ name'.
	self set: (target class >> #name) ast links equals: {metaLink}.
	self array: (installer methodLinksAt: target class at: #name) equals: {metaLink}
]

{ #category : #tests }
MTMetaLinksInstallerTest >> testUninstallAttribute [
	metaLink := MetaLink new.
	installer installPermanent: metaLink toAttribute: #name of: target class.
	installer uninstallAttribute: #name of: target class.
	self assert: (target class >> #name:) ast assignmentNodes first links equals: nil.
	self array: (installer attributeLinksAt: target class at: #name) equals: #()
]

{ #category : #tests }
MTMetaLinksInstallerTest >> testUninstallMethod [
	metaLink := MetaLink new.
	installer installPermanent: metaLink toMethod: #name of: target class.
	installer uninstallMethod: #name of: target class.
	self assert: (target class >> #name) ast links equals: nil.
	self array: (installer methodLinksAt: target class at: #name) equals: #()
]

{ #category : #tests }
MTMetaLinksInstallerTest >> testUnsubscribe [
	self assert: (SystemAnnouncer uniqueInstance hasSubscriber: installer).
	installer unsubscribeFromSystemAnnouncer.
	self deny: (SystemAnnouncer uniqueInstance hasSubscriber: installer)
]
