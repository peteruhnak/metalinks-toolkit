installing - private
installChangeObserverFor: aSymbol to: aClass
	| link |
	link := MetaLink new
		metaObject: changeMetaObjectBlock;
		selector: #value:value:;
		arguments: #(object newValue);
		control: #after.
	installer installPermanent: link toAttribute: aSymbol of: aClass