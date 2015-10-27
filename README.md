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

## What to do with it

The Röckdöt project awesomeness is based on Spring for Dart.

Röckdöt for Dart is a blazing fast IoC/DI/MVC framework for WebGL and Canvas2D, based on StageXL.
It lets you write apps as well as games (or a mix of the two) in pure Dart. You read that right: No HTML, no CSS.

[Demo](http://rockdot.sounddesignz.com/template/).

## History

The Actionscript ancestor of Röckdöt has been in continuous development for about five years,
serving millions of pageviews in individual web apps for brands such as Mercedes-Benz, Nike, or Nikon.

## Why the Dart port?

To save creativity on the internet! Due to the continuing demise of Flash Player (non-existent on mobile),
web apps nowadays need to support a myriad of devices and screen sizes. At the same time, budgets did not
really increase. Meh.
With Röckdöt for Dart, you now again have a powerful engine to conveniently deliver rich content in creative ways - without a million dollar budget.

## How was the port done?

It all started with the [Actionscript to StageXL Conversion Helper](https://github.com/blockforest/stagexl-converter-pubglobal),
which automates about 90% of the braindead task of syntax conversion. Thanks to it, about 400 classes of AS3 Commons, Spring Actionscript, and Röckdöt
found their way to Dart without pain. The rest was mere optimization.

## What are Röckdöt's Building Blocks?
* [StageXL Röckdöt](https://github.com/blockforest/stagexl-rockdot) Plugin System, UI Lifecycle and Asset Manager, i18n, Google and Facebook Integration, Generic User Generated Content backend communication
* [StageXL Spring](https://github.com/blockforest/stagexl-spring) IoC/DI container (ObjectFactory, ObjectFactory and Object Postprocessing, Interface Injection)
* [StageXL Commons](https://github.com/blockforest/stagexl-commons) Async library (FrontController and Commands/Operations, also sequences)
* [StageXL Commons](https://github.com/blockforest/stagexl-commons) EventBus (with some tweaks to Operations to make them as effective as Signals)
* [StageXL Commons](https://github.com/blockforest/stagexl-commons) Logging
* [StageXL](https://github.com/bp74/StageXL) - Flash API for Dart

## What are Röckdöt's main Features?
* Plugin system making use of all of the above
* Mature UI lifecycle management
* Asset load management (porting in progress)
* Generic User Generated Content backend communication (porting in progress. reading does work.)
* i18n
* Focus on highly interactive rich media applications
* LOTS of examples (porting in progress, coming soon)