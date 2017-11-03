initialization
initialize
	super initialize.
	(link := MetaLink new)
		metaObject: [ :object |  ];
		selector: #value:;
		arguments: #(object);
		control: #after