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
part of stagexl_spring;


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
	 *
	 * @author Roland Zwaga
	 */
class DefaultObjectFactory extends EventDispatcher implements IObjectFactory, IEventBusAware, IAutowireProcessorAware, IDisposable {

  static const String OBJECT_FACTORY_PREFIX = "&";
  static const String NON_LAZY_SINGLETON_CTOR_ARGS_ERROR = "The object definition for '{0}' is not lazy. Constructor arguments can only be supplied for lazy instantiating objects.";
  static const String OBJECT_DEFINITION_NOT_FOUND_ERROR = "An object definition for '{0}' was not found.";

  Logger logger;

  /**
		 * Creates a new <code>DefaultObjectFactory</code> instance.
		 * @param parentFactory optional other <code>IObjectFactory</code> to be used as this <code>ObjectFactory's</code> parent.
		 *
		 */
  DefaultObjectFactory() : super() {
    logger = new Logger("DefaultObjectFactory");
  }

  IAutowireProcessor _autowireProcessor;
  IInstanceCache _cache;
  IDependencyInjector _dependencyInjector;
  IEventBus _eventBus;
  bool _isDisposed = false;
  bool _isReady = false;
  IObjectDefinitionRegistry _objectDefinitionRegistry;
  IObjectDestroyer _objectDestroyer;
  List<IObjectPostProcessor> _objectPostProcessors;
  IObjectFactory _parent;
  IPropertiesProvider _propertiesProvider;

  /**
		 * @inheritDoc
		 */
  IAutowireProcessor get autowireProcessor {
    return _autowireProcessor;
  }

  /**
		 * @
		 */
  void set autowireProcessor(IAutowireProcessor value) {
    _autowireProcessor = value;
  }

  /**
		 * @inheritDoc
		 */
  IInstanceCache get cache {
    return _cache;
  }

  /**
		 * @
		 */
  void set cache(IInstanceCache value) {
    _cache = value;
  }

  /**
		 * @inheritDoc
		 */
  IDependencyInjector get dependencyInjector {
    return _dependencyInjector;
  }

  /**
		 * @
		 */
  void set dependencyInjector(IDependencyInjector value) {
    _dependencyInjector = value;
  }

  /**
		 * @inheritDoc
		 */
  IEventBus get eventBus {
    return _eventBus;
  }

  /**
		 * @
		 */
  void set eventBus(IEventBus value) {
    if (value != _eventBus) {
      _eventBus = value;
    }
  }


  bool get isDisposed {
    return _isDisposed;
  }

  /**
		 * @inheritDoc
		 */
  bool get isReady {
    return _isReady;
  }

  /**
		 * @
		 */
  void set isReady(bool value) {
    _isReady = value;
  }

  /**
		 * @inheritDoc
		 */
  IObjectDefinitionRegistry get objectDefinitionRegistry {
    return _objectDefinitionRegistry;
  }

  /**
		 * @
		 */
  void set objectDefinitionRegistry(IObjectDefinitionRegistry value) {
    _objectDefinitionRegistry = value;
  }

  /**
		 * @inheritDoc
		 */
  IObjectDestroyer get objectDestroyer {
    return _objectDestroyer;
  }

  /**
		 * @
		 */
  void set objectDestroyer(IObjectDestroyer value) {
    _objectDestroyer = value;
  }

  /**
		 * @inheritDoc
		 */
  List<IObjectPostProcessor> get objectPostProcessors {
    return (_objectPostProcessors != null) ? _objectPostProcessors : _objectPostProcessors = new List<IObjectPostProcessor>();
  }

  /**
		 * @inheritDoc
		 */
  IObjectFactory get parent {
    return _parent;
  }


  /**
		 * @inheritDoc
		 */
  IPropertiesProvider get propertiesProvider {
    if (_propertiesProvider == null) {
      _propertiesProvider = new Properties();
    }
    return _propertiesProvider;
  }

  /**
		 * @
		 */
  void set propertiesProvider(IPropertiesProvider value) {
    _propertiesProvider = value;
  }

  /**
		 * @inheritDoc
		 */
  IObjectFactory addObjectPostProcessor(IObjectPostProcessor objectPostProcessor) {
    if (objectPostProcessor != null) {
      if (objectPostProcessors.indexOf(objectPostProcessor) < 0) {
        objectPostProcessors.add(objectPostProcessor);
        _objectPostProcessors.sort(OrderedUtils.orderedCompareFunction);
      }
    } else {
      logger.severe("addObjectPostProcessor() received a null argument");
    }
    return this;
  }


  /**
		 * @inheritDoc
		 */
  bool canCreate(String objectName) {
    return ((_objectDefinitionRegistry.containsObjectDefinition(objectName)) || (cache.hasInstance(objectName)));
  }

  /**
		 * @inheritDoc
		 */
  dynamic createInstance(Type clazz, String objectName, [List constructorArguments = null]) {
    dynamic result = ClassUtils.newInstance(clazz, constructorArguments);
    result = manage(result, objectName);
    logger.finer("Created and injected an instance of {0}", [clazz]);
    return result;
  }

  /**
		 * @inheritDoc
		 */
  void destroyObject(Object instance) {
    if (_objectDestroyer != null) {
      logger.finer("Destroying instance {0}...", [instance]);
      _objectDestroyer.destroy(instance);
    }
  }

  /**
		 * @inheritDoc
		 */
  void dispose() {
    if (!_isDisposed) {
      ContextUtils.disposeInstance(_autowireProcessor);
      _autowireProcessor = null;
      if (_objectDestroyer != null) {
        List<String> names = _cache.getCachedNames();
        for (String name in names) {
          _objectDestroyer.destroy(_cache.getInstance(name));
        }
      }
      ContextUtils.disposeInstance(_objectDestroyer);
      _objectDestroyer = null;
      ContextUtils.disposeInstance(_cache);
      _cache = null;
      ContextUtils.disposeInstance(_dependencyInjector);
      _dependencyInjector = null;
      ContextUtils.disposeInstance(_objectDefinitionRegistry);
      _objectDefinitionRegistry = null;
      for (IObjectPostProcessor postProcessor in _objectPostProcessors) {
        ContextUtils.disposeInstance(postProcessor);
      }
      _objectPostProcessors = null;
      _parent = null; //Do NOT invoke dispose() on the parent!
      ContextUtils.disposeInstance(_propertiesProvider);
      _propertiesProvider = null;
      _isDisposed = true;
      logger.finer("Instance {0} has been disposed...", [this]);
    }
  }

  dynamic manage(dynamic instance, [String objectName = null]) {
    IObjectDefinition definition;
    if (objectName == null) {
      Type cls = reflect(instance).runtimeType;
      List<String> names = _objectDefinitionRegistry.getObjectDefinitionNamesForType(cls);
      if ((names != null) && (names.length == 1)) {
        objectName = names[0];
      } else if ((names != null) && (names.length > 1)) {
        logger.severe("More than one object definition found for class ", [cls]);
      } else {
        logger.info("No object definition found for class ", [cls]);
      }
    }
    if (objectName != null) {
      definition = objectDefinitionRegistry.getObjectDefinition(objectName);
    }
    instance = wire(instance, definition, null, objectName);
    if (_objectDestroyer != null) {
      _objectDestroyer.registerInstance(instance, objectName);
    }
    if ((definition != null) && ((definition.scope == ObjectDefinitionScope.SINGLETON || definition.scope == ObjectDefinitionScope.REMOTE)) && (!cache.hasInstance(objectName))) {
      cache.putInstance(objectName, instance);
    }
    return instance;
  }



  /**
		 * @inheritDoc
		 */
  dynamic getObject(String name, [List constructorArguments = null]) {
    dynamic result;
    bool isFactoryDereference = (name[0] == OBJECT_FACTORY_PREFIX);
    String objectName = (isFactoryDereference ? name.substring(1) : name);

    // try to get the object from the explicit singleton cache
    if (_cache.hasInstance(objectName)) {
      result = _cache.getInstance(objectName);
    } else {
      // we don't have an object in the cache, so create it
      result = buildObject(name, constructorArguments);
    }

    if (result != null) {
      ObjectFactoryEvent evt = new ObjectFactoryEvent(ObjectFactoryEvent.OBJECT_RETRIEVED, result, name, constructorArguments);
      dispatchEvent(evt);
      dispatchEventThroughEventBus(evt);
    }
    return result;
  }

  /**
		 * @inheritDoc
		 */
  IObjectDefinition getObjectDefinition(String objectName) {
    if (_objectDefinitionRegistry != null) {
      return _objectDefinitionRegistry.getObjectDefinition(objectName);
    }
    return null;
  }



  dynamic wire(dynamic instance, [IObjectDefinition objectDefinition = null, List constructorArguments = null, String objectName = null]) {
    if (dependencyInjector != null) {
      dynamic wiredResult = dependencyInjector.wire(instance, this, objectDefinition, objectName);
      if (wiredResult != null) {
        instance = wiredResult;
      }
      ObjectFactoryEvent objectWiredEvent = new ObjectFactoryEvent(ObjectFactoryEvent.OBJECT_WIRED, instance, objectName, constructorArguments);
      dispatchEvent(objectWiredEvent);
    }

    //because we dont't have a dependencyinjector in dart port yet:
    for (IObjectPostProcessor processor in objectPostProcessors) {
      logger.finer("Executing object postprocessor {0} after initialization on instance {1}", [processor, instance]);
      dynamic result = processor.postProcessBeforeInitialization(instance, objectName);
      result = processor.postProcessAfterInitialization(result, objectName);
      if (result != null) {
        instance = result;
      }
    }

    return instance;
  }


  dynamic attemptToInstantiate(IObjectDefinition objectDefinition, List constructorArguments, String name, String objectName) {
    dynamic result = null;
    try {
      logger.finer("Attempting to instantiate object for definition '{0}'...", [objectName]);
      result = instantiateClass(objectDefinition, (constructorArguments == null) ? objectDefinition.constructorArguments : constructorArguments, objectName);
      ObjectFactoryEvent objectCreatedEvent = new ObjectFactoryEvent(ObjectFactoryEvent.OBJECT_CREATED, result, name, constructorArguments);
      dispatchEvent(objectCreatedEvent);
      dispatchEventThroughEventBus(objectCreatedEvent);
      result = wire(result, objectDefinition, constructorArguments, objectName);
    } catch (Error) {
      throw new StateError("Error");
    }
    return result;
  }


  dynamic buildObject(String name, List constructorArguments) {
    dynamic result;
    bool isFactoryDereference = (name[0] == OBJECT_FACTORY_PREFIX);
    String objectName = (isFactoryDereference ? name.substring(1) : name);
    IObjectDefinition objectDefinition = getObjectDefinition(objectName);

    if (objectDefinition == null) {
      return null;
    }

    if (objectDefinition.isInterface) {
      throw new StateError(StringUtils.substitute("Objectdefinition {0} describes an abstract class which cannot be directly instantiated", [objectName]));
    } else if ((objectDefinition.scope == ObjectDefinitionScope.STAGE) || (objectDefinition.scope == ObjectDefinitionScope.REMOTE)) {
      logger.finer("Object definition scope is '{0}', returning null", [objectDefinition.scope]);
      return null;
    }

    if ((objectDefinition.scope != ObjectDefinitionScope.SINGLETON) && (objectDefinition.scope != ObjectDefinitionScope.PROTOTYPE)) {
      throw new StateError(StringUtils.substitute("Only definitions with scope 'singleton' or 'prototype' can be instantiated. Definition name: {0}", [objectName]));
    }

    if (objectDefinition.isSingleton && (constructorArguments != null && !objectDefinition.isLazyInit)) {
      throw new StateError(StringUtils.substitute(NON_LAZY_SINGLETON_CTOR_ARGS_ERROR, [objectName]));
    }

    if (objectDefinition.isSingleton) {
      result = getInstanceFromCache(objectName);
    }

    if (result == null) {
      result = attemptToInstantiate(objectDefinition, constructorArguments, name, objectName);
      if (objectDefinition.isSingleton && !cache.hasInstance(objectName)) {
        cache.putInstance(objectName, result);
      }
      if (_objectDestroyer != null) {
        _objectDestroyer.registerInstance(result, name);
      }
    }

    return result;
  }


  void dispatchEventThroughEventBus(ObjectFactoryEvent evt) {
    if (_eventBus != null) {
      _eventBus.dispatchEvent(evt);
    }
  }

  dynamic getInstanceFromCache(String objectName) {
    dynamic result;
    if (_cache.hasInstance(objectName)) {
      result = _cache.getInstance(objectName);
    }

    // not in cache -> perhaps it is prepared as a circular reference
    if ((result == null) && (_cache.isPrepared(objectName))) {
      result = _cache.getPreparedInstance(objectName);
    }
    return result;
  }


  dynamic instantiateClass(IObjectDefinition objectDefinition, List constructorArguments, String objectName) {
    logger.finer("Instantiating class: {0}", [objectDefinition.className]);

    if (_autowireProcessor != null) {
      _autowireProcessor.preprocessObjectDefinition(objectDefinition);
    }
    if(objectDefinition.func != null){
      //Function.apply(objectDefinition.func, []);
      //var obj = cache.getInstance(objectName);
      var obj = objectDefinition.func();
      print(obj);
      //cache.removeInstance(objectName);
      wire(obj);
      return obj;
    }
    else{
      Type clazz = objectDefinition.clazz;
      try {
        return ClassUtils.newInstance(clazz, constructorArguments);
      } catch (Error) {
        throw new StateError(StringUtils.substitute("Failed to instantiate class '{0}' for definition with id '{1}':{2} , original error:\n{3}", [clazz, objectName, objectDefinition]));
      }
    }
  }

}
