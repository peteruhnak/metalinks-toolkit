example
example
	<playgroundExample>
| el installer link |
el := MTElement new.
"inspect announcer > announcements tab"
el.

installer := MTMetaLinksInstaller new.
installer uninstallAllLinksIn: MTElement.

link := MetaLink new
	metaObject: [ :object :newValue |
		object announcer announce: (ValueChanged newValue: newValue)
	];
	selector: #value:value:;
	arguments: #(object newValue);
	control: #after.

installer uninstallAllPermanentLinksIn: MTElement.
installer installPermanent: link toAttribute: #name of: MTElement.
el name: 'changed value'.
el class compile: 'resetName
	name := ''some default value'''.

el resetName.