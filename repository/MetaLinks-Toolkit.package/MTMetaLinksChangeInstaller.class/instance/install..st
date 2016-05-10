installing
install: observations
	observations do: [ :each | self installObservation: each ]