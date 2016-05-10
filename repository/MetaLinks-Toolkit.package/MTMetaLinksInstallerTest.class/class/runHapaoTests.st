as yet unclassified
runHapaoTests
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