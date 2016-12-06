## Spring Framework for Dart and StageXL

Port of [Spring Actionscript](http://www.springactionscript.org/) to StageXL/Dart.

### Note that this will never become a full port!

#### What's there
* ApplicationContext
* ObjectFactory, InstanceCache, PostProcessing, PropertyProvider
* IoC - Interface Injection
* Micro MVC library

#### What's not there
* XMLApplicationContext - would screw up minification and introspection; Dart doesn't have a mature XML parser anyways
* Stageprocessing - would screw up minification, and the author doesn't like magic functionality, anyways
* Metadata-based injection - would screw up minification, and the author doesn't like magic functionality, anyways
* Type-based injection - would screw up minification, and the author doesn't like magic functionality, anyways

## What's it good for

The [Rockdot framework](https://github.com/blockforest/rockdot-framework) is built upon Spring for Dart.

Rockdot for Dart is a blazing fast IoC/DI/MVC framework for WebGL and Canvas2D, based on StageXL.
It lets you write apps as well as games (or a mix of the two) in pure Dart. You read that right: No HTML, no CSS.

### Examples

* [Full Framework Demo](http://rockdot.sounddesignz.com/template/) - Generated with [Rockdot CLI](https://github.com/blockforest/rockdot-generator)
* [FlexBook (experimental on mobile)](http://rockdot.sounddesignz.com/stagexl-commons/experimental_book.html) - [Source](https://github.com/blockforest/rockdot-commons/blob/master/web/experimental_book.dart)
* [Box2D](http://rockdot.sounddesignz.com/box2d/) - [Source](https://github.com/blockforest/rockdot-physics/tree/master/lib/src/Examples)
* [BabylonJS StageXL Wrapper](http://rockdot.sounddesignz.com/dart/babylonjs-interop/) - [Source](https://github.com/blockforest/babylonjs-dart-facade/tree/master/example)
* [THREE.js StageXL Wrapper](http://rockdot.sounddesignz.com/dart/threejs-interop/) - [Source](https://github.com/blockforest/threejs-dart-facade/tree/master/example)
* [Material Design - Buttons (Commons only, just 92 KiB!)](http://rockdot.sounddesignz.com/stagexl-commons/paper_buttons.html) - [Source](https://github.com/blockforest/rockdot-commons/blob/master/web/material_buttons.dart)
* [Material Design - Controls (Commons only)](http://rockdot.sounddesignz.com/stagexl-commons/paper_radio.html) - [Source](https://github.com/blockforest/rockdot-commons/blob/master/web/material_radio.dart)
* [Material Design - Input (Commons only)](http://rockdot.sounddesignz.com/stagexl-commons/paper_input.html) - [Source](https://github.com/blockforest/rockdot-commons/blob/master/web/material_input.dart)
