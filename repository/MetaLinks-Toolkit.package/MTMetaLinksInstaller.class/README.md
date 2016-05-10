I install the provided metalink to methods and reinstall them if the method has changed.

## Installing Links

I have two primary entry points:

* `installPermanent:toAttribute:of:`

Which will keep the metalink installed in all `AssignmentNode`s EXCEPT for #initialization method.
This means that if you add a new method that assigns to the attribute, the MetaLink will be automatically installed.

* `installPermanent:toMethod:of:`

This will install the MetaLink to a single method (or rather a selector) and will keep it there even on change, or removal & addition.

## Uninstalling Links

To uninstall all links use

`uninstallAllPermanentLinksIn:`

If you just need to wipe all metalinks in a class without removing the permanent feature, you can use `uninstallAllLinksIn:`.