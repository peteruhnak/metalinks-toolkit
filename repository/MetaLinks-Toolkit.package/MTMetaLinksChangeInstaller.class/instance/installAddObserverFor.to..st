installing - private
installAddObserverFor: aSymbol to: aClass
	| link |
	link := MetaLink new
		metaObject: addMetaObjectBlock;
		selector: #value:value:;
		arguments: #(object arguments);
		control: #after.
	installer installPermanent: link toMethod: aSymbol of: aClass