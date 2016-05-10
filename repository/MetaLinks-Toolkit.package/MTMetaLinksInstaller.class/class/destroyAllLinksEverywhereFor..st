destroy
destroyAllLinksEverywhereFor: aClass
	MTMetaLinksInstaller allInstances
		do: [ :each | each uninstallAllPermanentLinksIn: aClass ]