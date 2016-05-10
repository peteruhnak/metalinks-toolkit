as yet unclassified
isActionHandled
	"Return true if the provided method fits this action requirement"

	^ method pragmas anySatisfy: [ :each | each keyword = 'playgroundExample' ]