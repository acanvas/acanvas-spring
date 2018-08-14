/*
 * Copyright 2007-2011 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
part of acanvas_spring;

/**
	 *
	 */
// [Event(name="objectCreated", type="org.springextensions.actionscript.ioc.factory.event.ObjectFactoryEvent")]
/**
	 *
	 */
// [Event(name="objectRetrieved", type="org.springextensions.actionscript.ioc.factory.event.ObjectFactoryEvent")]
/**
	 *
	 */
// [Event(name="objectWired", type="org.springextensions.actionscript.ioc.factory.event.ObjectFactoryEvent")]
/**
	 * Describes an object that is capable of creating and configuring instances of other classes.
	 * @author Christophe Herreman
	 * @author Roland Zwaga
	 */

abstract class IObjectFactory extends EventDispatcher
    implements IObjectDefinitionRegistryAware {
  /**
		 * The <code>ApplicationDomain</code> that is associated with the current <code>IObjectFactory</code>
		 */
  // ApplicationDomain get applicationDomain;
  /**
		 * @
		 */
  // void set applicationDomain(ApplicationDomain value);

  /**
		 * An <code>IInstanceCache</code> instance used to hold the singletons created by the current <code>IObjectFactory</code>.
		 */
  IInstanceCache get cache;

  /**
		 *
		 */
  IDependencyInjector get dependencyInjector;

  /**
		 * @
		 */
  void set dependencyInjector(IDependencyInjector value);

  /**
		 * Returns <code>true</code> when the current <code>IObjectFactory</code> is fully initialized and ready for use.
		 */
  bool get isReady;

  /**
		 * @
		 */
  void set isReady(bool value);

  /**
		 *
		 */
  IObjectDestroyer get objectDestroyer;

  /**
		 * @
		 */
  void set objectDestroyer(IObjectDestroyer value);

  /**
		 *
		 */
  List<IObjectPostProcessor> get objectPostProcessors;

  /**
		 *
		 */
  IPropertiesProvider get propertiesProvider;
  /**
		 * @
		 */
  void set propertiesProvider(IPropertiesProvider value);

  /**
		 */
  // List<IReferenceResolver> get referenceResolvers;

  /**
		 *
		 * @param objectPostProcessor
		 */
  IObjectFactory addObjectPostProcessor(
      IObjectPostProcessor objectPostProcessor);

  /**
		 *
		 * @param referenceResolver
		 */
  //IObjectFactory addReferenceResolver(IReferenceResolver referenceResolver);

  /**
		 * Determines if the current <code>ObjectFactory</code> is able to create the object for the sepcified object name.
		 * @param objectName The specified object name
		 * @return <code>True</code> if the current <code>ObjectFactory</code> is able to create the object for the sepcified object name.
		 */
  bool canCreate(String objectName);

  /**
		 * Creates an instance of the specified <code>Class</code>, wires the instance and returns it.
		 * Useful for creating objects that have only been annotated with [Autowired] metadata and need
		 * no object definition.
		 * @param clazz The specified <code>Class</code>.
		 * @param constructorArguments Optional <code>List</code> of constructor arguments to be used for the instance.
		 * @return The created and wired instance of the specified <code>Class</code>.
		 */
  dynamic createInstance(Type clazz, String objectName,
      [List constructorArguments = null]);

  /**
		 *
		 * @param instance
		 */
  void destroyObject(Object instance);
  /**
		 * Will retrieve an object by it's name/id If the definition is a singleton it will be retrieved from
		 * cache if possible. If the definition defines an init method, the init method will be called after
		 * all properties have been set.
		 * <p />
		 * If any object post processors are defined they will be run against the newly created instance.
		 * <p />
		 * The class that is instantiated can implement the following abstract classs for a special treatment: <br />
		 * <ul>
		 *   <li><code>IInitializingObject</code>: The method defined by the abstract class will called after the
		 *                       properties have been set.</li>
		 *   <li><code>IFactoryObject</code>:    The actual object will be retrieved using the getObject method.</li>
		 * </ul>
		 *
		 * @param name            The name of the object as defined in the object definition
		 * @param constructorArguments    The arguments that should be passed to the constructor. Note that
		 *                   the constructorArguments can only be passed if the object is
		 *                   defined as lazy.
		 *
		 * @return An instance of the requested object
		 *
		 * @see #resolveReference()
		 * @see org.springextensions.actionscript.ioc.IObjectDefinition
		 * @see org.springextensions.actionscript.ioc.factory.config.IObjectPostProcessor
		 * @see org.springextensions.actionscript.ioc.factory.IInitializingObject
		 * @see org.springextensions.actionscript.ioc.factory.IFactoryObject
		 *
		 * @throws org.springextensions.actionscript.ioc.ObjectDefinitionNotFoundError    The name of the given object should be
		 *                                   present as an object definition
		 * @throws flash.errors.IllegalOperationError            A singleton object definition that is not lazy
		 *                                   can not be given constructor arguments
		 * @throws org.springextensions.actionscript.errors.PropertyTypeError        The type of a property definition should
		 *                                   match the type of property on the instance
		 * @throws org.springextensions.actionscript.errors.ClassNotFoundError        The class set on the definition should
		 *                                   be compiled into the application
		 * @throws org.springextensions.actionscript.errors.ResolveReferenceError      Indicating a problem resolving the
		 *                                   references of a certain property
		 *
		 * @example The following code retrieves an object named "myPerson" from the object factory: dynamic <listing version="3.0">
		 *   Person myPerson = objectFactory.getObject("myPerson");
		 * </listing>
		 */
  T getObject<T extends dynamic>(String name,
      [List constructorArguments = null]);

  /**
		 *
		 * @param objectName
		 * @return
		 */
  IObjectDefinition getObjectDefinition(String objectName);

  dynamic manage(dynamic instance, String objectName);

  /**
		 *
		 * @param instance
		 * @param objectDefinition
		 * @param constructorArguments
		 * @param objectName
		 * @return
		 */
  dynamic wire(dynamic instance,
      [IObjectDefinition objectDefinition = null,
      List constructorArguments = null,
      String objectName = null]);
}
