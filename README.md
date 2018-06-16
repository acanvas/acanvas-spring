# Acanvas Spring

*Acanvas Spring – for Dart 2.0 and StageXL.*

*Acanvas Spring* is part of the *[Acanvas Framework](http://acanvas.sounddesignz.com/acanvas-framework/)* layered architecture [(diagram)](http://acanvas.sounddesignz.com/template/assets/home/acanvas_spring_architecture.png).

Build your own *Acanvas* project now – with *[Acanvas Generator](https://github.com/acanvas/acanvas-generator)*!
* Blazing fast IoC/DI/MVC UI framework for WebGL and Canvas2D, written in Dart.
* Write web apps, games, or both, in pure Dart. No HTML, no CSS, no JS.


### Features

*Acanvas Spring* is a port of [Spring Actionscript](http://www.springactionscript.org/), an official Spring Framework implementation, to Dart 2.0 and StagelXL.

* *ApplicationContext* - Add any object to the project's runtime context, and by Interface injection and Interface postprocessing, wire them into *Acanvas Spring* or *Acanvas Framework*.
  * *ObjectFactory* - Creates and manages objects.
  * *InstanceCache* - So much better than singletons. 
  * *PropertyProvider* - Load and access language or configuration properties conveniently.
* *Inversion of Control*
  * *Interface Injection* - Inject other *Acanvas Spring* objects into your object based on the Interfaces it implements.
  * *PostProcessing* - Have other *Acanvas Spring* objects postprocess your object based on its Interfaces, object name, or type.
* *Micro MVC library* - The Controller is implemented as front controller dispatching to *Commands* and *Command Sequences* via *Signals*.


### Examples

* The [Acanvas Framework Demo](http://acanvas.sounddesignz.com/acanvas-framework/) wouldn't be possible without *Acanvas Spring*.
* The best way to learn how to use *Acanvas Spring* and *Acanvas Framework* by generating a project with [Acanvas Generator](https://github.com/acanvas/acanvas-generator).

### Limitations

Acanvas Spring is targeted for use in Dart 2.0 web projects, and as such is omitting all Spring functionality that would negatively affect file size, especially those requiring *reflection*.
As such, not present in *Acanvas Spring* are:

* *XMLApplicationContext* - Additional impediment: Dart offers only basic XML libraries.
* *Stageprocessing* - Additional impediment: CPU resource heavy.
* Configuration with *Annotations* and *Metadata*.
* Instantiation and Injection based on class *Type*.