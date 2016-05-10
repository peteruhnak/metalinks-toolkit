announcements
silentlyDo: aBlock
	| oldAnnouncer |
	oldAnnouncer := self announcer.
	self announcer: Announcer new.
	aBlock value.
	self announcer: oldAnnouncer