installing - private
installRemoveObserverFor: aSymbol to: aClass
	| link |
	link := MetaLink new
		metaObject: removeMetaObjectBlock;
		selector: #value:value:;
		arguments: #(object arguments);
		control: #after.
	installer installPermanent: link toMethod: aSymbol of: aClass