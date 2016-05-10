example
example
	<playgroundExample>
| observations ci el c |
observations := {
	MTObservationSet
		target: MTElement
		change: #(name owner uuid)
		add: #()
		remove: #().

	MTObservationSet
		target: MTContainer
		change: #()
		add: #(add:)
		remove: #(remove:)
}.
ci := MTMetaLinksChangeInstaller new.
ci installer uninstallAllPermanentLinksIn: MTElement.
ci installer uninstallAllPermanentLinksIn: MTContainer.
ci install: observations.
el := MTElement new.
c := MTContainer new.

"Inspect both instances and look at announcements of their announcers."
el.
c.

el name: 'new name'.
c add: el.
c remove: el