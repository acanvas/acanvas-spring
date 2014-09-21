## Spring Dart

Port of [Spring Actionscript](http://www.springactionscript.org/) to Dart.

### Note that this will never become a full port!

#### What's there
* ApplicationContext
* ObjectFactory, InstanceCache, PostProcessing, PropertyProvider
* IoC - Interface Injection
* Micro MVC library

#### What's not there
* XMLApplicationContext - would screw up minification; Dart doesn't have a mature XML parser
* Stageprocessing - would screw up minification, and the author doesn't like magic functionality, anyways
* Metadata-based injection - would screw up minification, and the author doesn't like magic functionality, anyways
* Type-based injection - would screw up minification, and the author doesn't like magic functionality, anyways

