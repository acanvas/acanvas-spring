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
// [Event(name="afterApplicationContextDispose", type="org.springextensions.actionscript.context.event.ContextEvent")]
/**
	 *
	 */
// [Event(name="beforeChildContextRemove", type="org.springextensions.actionscript.context.event.ChildContextEvent")]
/**
	 *
	 */
// [Event(name="afterChildContextRemove", type="org.springextensions.actionscript.context.event.ChildContextEvent")]
/**
	 *
	 */
// [Event(name="beforeChildContextAdd", type="org.springextensions.actionscript.context.event.ChildContextEvent")]
/**
	 *
	 */
// [Event(name="afterChildContextAdd", type="org.springextensions.actionscript.context.event.ChildContextEvent")]
/**
	 *
	 */
// [Event(name="complete", type="flash.events.Event")]
/**
	 * Basic implementation of the <code>IApplicationContext</code> abstract class. No object or factory processors are created by default inside this base class. Use this class for
	 * custom configured application contexts. Otherwise use the <code>DefaultApplicationContext</code> which offers some basic functionality 'out-of-the-box'.
	 * @author Roland Zwaga
	 */
class SpringApplicationContext extends EventDispatcher implements IApplicationContext, IDisposable, IEventBusAware /*, IAutowireProcessorAware, IEventBusAware, IEventBusUserRegistryAware, ILoaderInfoAware*/ {

  static const String APPLICATIONCONTEXTINITIALIZER_CHANGED_EVENT = "applicationContextInitializerChanged";
  static const String GET_ASSOCIATED_FACTORY_METHOD_NAME = "getAssociatedFactory";
  Logger LOGGER;
  static const String MXMODULES_MODULE_MANAGER_CLASS_NAME = "mx.modules.ModuleManager";

  /**
		 * Creates a new <code>ApplicationContext</code> instance.
		 */
  SpringApplicationContext([List<DisplayObject> rootViews = null, IObjectFactory objFactory = null]) : super() {
    if (objFactory == null) {
      objectFactory = createDefaultObjectFactory();
    }
    LOGGER = new Logger("SpringApplicationContext");
    addFactoryListeners(_objectFactory);
    _definitionProviders = new List<IObjectDefinitionsProvider>();
    _rootViews = rootViews;
    //applicationDomain = resolveRootViewApplicationDomain(_rootViews);
    //loaderInfo = resolveRootViewLoaderInfo(_rootViews);
  }

  IObjectFactory _objectFactory;
  IApplicationContextInitializer _applicationContextInitializer;
  String _childContextManagerName;
  List<IApplicationContext> _childContexts;
  List<IObjectDefinitionsProvider> _definitionProviders;
  IEventBus _eventBus; //decided to implement own simple EventBus, as we do not need the channel stuff
  List<DisplayObject> _ignoredRootViews;
  bool _isDisposed;
  LoaderInfo _loaderInfo;
  List<IObjectFactoryPostProcessor> _objectFactoryPostProcessors;
  List<DisplayObject> _rootViews;
  /* //not using stage processing, so implementation was skipped
		 IStageObjectProcessorRegistry _stageProcessorRegistry;
		  */
  int _token;

  IObjectFactory get objectFactory {
    return _objectFactory;
  }
  void set objectFactory(IObjectFactory iof) {
    _objectFactory = iof;
  }

  // [Bindable(event="applicationContextInitializerChanged")]
  IApplicationContextInitializer get applicationContextInitializer {
    return _applicationContextInitializer;
  }

  void set applicationContextInitializer(IApplicationContextInitializer value) {
    if (_applicationContextInitializer != value) {
      _applicationContextInitializer = value;
      dispatchEvent(new Event(APPLICATIONCONTEXTINITIALIZER_CHANGED_EVENT));
    }
  }


  /**
		 * @inheritDoc
		 */
  IInstanceCache get cache {
    return _objectFactory.cache;
  }


  /**
		 * @inheritDoc
		 */
  List<IObjectDefinitionsProvider> get definitionProviders {
    return _definitionProviders;
  }

  /**
		 * @inheritDoc
		 */
  IDependencyInjector get dependencyInjector {
    return _objectFactory.dependencyInjector;
  }

  /**
		 * @
		 */
  void set dependencyInjector(IDependencyInjector value) {
    _objectFactory.dependencyInjector = value;
  }

  /**
		 * @inheritDoc
		 */
  IEventBus get eventBus {
    return (_objectFactory is IEventBusAware) ? (_objectFactory as IEventBusAware).eventBus : _eventBus;
  }

  /**
		 * @
		 */
  void set eventBus(IEventBus value) {
    if (_objectFactory is IEventBusAware) {
      (_objectFactory as IEventBusAware).eventBus = value;
    } else {
      _eventBus = value;
    }
  }

  /**
		 * @inheritDoc
		  IEventBusUserRegistry get eventBusUserRegistry {
			if (_objectFactory is IEventBusUserRegistryAware) {
				return (_objectFactory as IEventBusUserRegistryAware).eventBusUserRegistry;
			}
			return null;
		}
	 */

  /**
		 * @
		  void set eventBusUserRegistry(IEventBusUserRegistry value) {
			if (_objectFactory is IEventBusUserRegistryAware) {
				(_objectFactory as IEventBusUserRegistryAware).eventBusUserRegistry = value;
			}
		}
	 */

  List<DisplayObject> get ignoredRootViews {
    return _ignoredRootViews;
  }

  /**
		 * @inheritDoc
		 */
  bool get isDisposed {
    return _isDisposed;
  }

  /**
		 * @inheritDoc
		 */
  bool get isReady {
    return _objectFactory.isReady;
  }

  /**
		 * @
		 */
  void set isReady(bool value) {
    _objectFactory.isReady = value;
  }

  /**
		 * @inheritDoc
		 */
  LoaderInfo get loaderInfo {
    return _loaderInfo;
  }

  /**
		 * @
		 */
  void set loaderInfo(LoaderInfo value) {
    _loaderInfo = value;
  }

  /**
		 * @inheritDoc
		 */
  IObjectDefinitionRegistry get objectDefinitionRegistry {
    return _objectFactory.objectDefinitionRegistry;
  }

  /**
		 * @
		 */
  void set objectDefinitionRegistry(IObjectDefinitionRegistry value) {
    _objectFactory.objectDefinitionRegistry = value;
  }

  /**
		 * @inheritDoc
		 */
  IObjectDestroyer get objectDestroyer {
    return _objectFactory.objectDestroyer;
  }

  /**
		 * @
		 */
  void set objectDestroyer(IObjectDestroyer value) {
    _objectFactory.objectDestroyer = value;
  }

  /**
		 * @inheritDoc
		 */
  List<IObjectFactoryPostProcessor> get objectFactoryPostProcessors {
    return (_objectFactoryPostProcessors != null) ? _objectFactoryPostProcessors : _objectFactoryPostProcessors = new List<IObjectFactoryPostProcessor>();
  }

  /**
		 * @inheritDoc
		 */
  List<IObjectPostProcessor> get objectPostProcessors {
    return _objectFactory.objectPostProcessors;
  }


  /**
		 * @inheritDoc
		 */
  IPropertiesProvider get propertiesProvider {
    return _objectFactory.propertiesProvider;
  }

  /**
		 * @
		 */
  void set propertiesProvider(IPropertiesProvider value) {
    _objectFactory.propertiesProvider = value;
  }

  /**
		 * @inheritDoc
  List<IReferenceResolver> get referenceResolvers {
    return _objectFactory.referenceResolvers;
  }
*/

  /**
		 * @inheritDoc
		 */
  List<DisplayObject> get rootViews {
    return _rootViews;
  }

  /**
		 * @inheritDoc
		  IStageObjectProcessorRegistry get stageProcessorRegistry {
			return _stageProcessorRegistry;
		}
	 */

  /**
		 * @
		  void set stageProcessorRegistry(IStageObjectProcessorRegistry value) {
			_stageProcessorRegistry = value;
		}
	 */

  /**
		 * @inheritDoc
		  IApplicationContext addChildContext(IApplicationContext childContext,[ContextShareSettings settings=null]) {
			IChildContextManager manager = getChildContextManager();
			manager.addEventListener(ChildContextEvent.BEFORE_CHILD_CONTEXT_ADD, redispatch);
			manager.addEventListener(ChildContextEvent.AFTER_CHILD_CONTEXT_ADD, redispatch);
			manager.addChildContext(this, childContext, settings);
			manager.removeEventListener(ChildContextEvent.BEFORE_CHILD_CONTEXT_ADD, redispatch);
			manager.removeEventListener(ChildContextEvent.AFTER_CHILD_CONTEXT_ADD, redispatch);
			childContext.addEventListener(ContextEvent.AFTER_DISPOSE, childContextDisposedHandler, false, 0, true);
			return this;
		}
	 */

  /**
		 * @inheritDoc
		  IApplicationContext addDefinitionProvider(IObjectDefinitionsProvider provider) {
			if (definitionProviders.indexOf(provider) < 0) {
				if (provider is IApplicationDomainAware) {
					(provider as IApplicationDomainAware).applicationDomain = applicationDomain;
				}
				if (provider is IApplicationContextAware) {
					(provider as IApplicationContextAware).applicationContext = this;
				}
				definitionProviders[definitionProviders.length] = provider;
				LOGGER.finer("Definition provider {0} added", [provider]);
			}
			return this;
		}
	 */

  void addIgnoredRootView(DisplayObject rootView) {
    (_ignoredRootViews != null) ? _ignoredRootViews : _ignoredRootViews = new List<DisplayObject>();
    if (addDisplayObject(_ignoredRootViews, rootView)) {

    }
  }

  /**
		 * @inheritDoc
		 */
  IApplicationContext addObjectFactoryPostProcessor(IObjectFactoryPostProcessor objectFactoryPostProcessor) {
    if (objectFactoryPostProcessors.indexOf(objectFactoryPostProcessor) < 0) {
      //if (objectFactoryPostProcessor is IApplicationDomainAware) {
      //	(objectFactoryPostProcessor as IApplicationDomainAware).applicationDomain = applicationDomain;
      //}
      objectFactoryPostProcessors.add(objectFactoryPostProcessor);
      _objectFactoryPostProcessors.sort(OrderedUtils.orderedCompareFunction);
      LOGGER.finer("Object factory postprocessor {0} added", [objectFactoryPostProcessor]);
    }
    return this;
  }

  /**
		 * @inheritDoc
		 */
  IObjectFactory addObjectPostProcessor(IObjectPostProcessor objectPostProcessor) {
    LOGGER.finer("Object postprocessor {0} added", [objectPostProcessor]);
    return _objectFactory.addObjectPostProcessor(objectPostProcessor);
  }

  /**
		 * @inheritDoc
  IObjectFactory addReferenceResolver(IReferenceResolver referenceResolver) {
    LOGGER.finer("Reference resolver {0} added", [referenceResolver]);
    return _objectFactory.addReferenceResolver(referenceResolver);
  }
*/

  /**
		 * @inheritDoc
			 */
  void addRootView(DisplayObject rootView) {
    (_rootViews != null) ? _rootViews : _rootViews = new List<DisplayObject>();
    if (addDisplayObject(_rootViews, rootView)) {
      LOGGER.finer("Root view {0} added", [rootView]);
      /*
				if ((_objectFactory.isReady) && (rootViews.length > 1) && (stageProcessorRegistry != null)) {
					List<IStageObjectProcessor> processors = stageProcessorRegistry.getStageProcessorsByRootView(rootViews[0]);
					for (IStageObjectProcessor processor in processors) {
						List<IObjectSelector> selectors = stageProcessorRegistry.getObjectSelectorsForStageProcessor(processor);
						for (IObjectSelector selector in selectors) {
							stageProcessorRegistry.registerStageObjectProcessor(processor, selector, rootView);
						}
					}
				}
				 */
    }
  }

  /**
		 * @inheritDoc
		 */
  bool canCreate(String objectName) {
    return _objectFactory.canCreate(objectName);
  }

  /**
		 * @inheritDoc
		 */
  IApplicationContext configure(IConfigurationPackage configurationPackage) {
    configurationPackage.execute(this);
    LOGGER.finer("Configuration package {0} executed on current application context", [configurationPackage]);
    return this;
  }

  /**
		 * @inheritDoc
		 */
  dynamic createInstance(Type clazz, String objectName, [List constructorArguments = null]) {
    return _objectFactory.createInstance(clazz, objectName, constructorArguments);
  }

  /**
		 * @inheritDoc
		 */
  void destroyObject(Object instance) {
    _objectFactory.destroyObject(instance);
  }

  /**
		 * Clears, disposes and nulls out every member of the current <code>ApplicationContext</code>.
		 */
  void dispose() {
    if (!_isDisposed) {
      try {
        for (IApplicationContext childContext in _childContexts) {
          ContextUtils.disposeInstance(childContext);
        }
        _childContexts = null;

        for (IObjectDefinitionsProvider provider in _definitionProviders) {
          ContextUtils.disposeInstance(provider);
        }
        _definitionProviders = null;

        ContextUtils.disposeInstance(_objectFactory);
        _objectFactory = null;

        ContextUtils.disposeInstance(_applicationContextInitializer);
        _applicationContextInitializer = null;

        _rootViews = null;
        _loaderInfo = null;
        /*
					if ((_stageProcessorRegistry is SpringStageObjectProcessorRegistry) && ((_stageProcessorRegistry as SpringStageObjectProcessorRegistry).owner !== this)) {
						unregisterStageProcessors(_stageProcessorRegistry);
					} else {
						if (_stageProcessorRegistry != null) {
							_stageProcessorRegistry.clear();
							ContextUtils.disposeInstance(_stageProcessorRegistry);
						}
					}
					_stageProcessorRegistry = null;
          */
        for (IObjectFactoryPostProcessor factoryPostProcessor in _objectFactoryPostProcessors) {
          ContextUtils.disposeInstance(factoryPostProcessor);
        }
        _objectFactoryPostProcessors = null;
        LOGGER.finer("Context disposed");
      } finally {
        _isDisposed = true;
      }
      dispatchEvent(new ContextEvent(ContextEvent.AFTER_DISPOSE, this));
    }
  }

  /**
		 * @inheritDoc
		 */
  dynamic getObject(String name, [List constructorArguments = null]) {
    return _objectFactory.getObject(name, constructorArguments);
  }

  /**
		 * @inheritDoc
		 */
  IObjectDefinition getObjectDefinition(String objectName) {
    return _objectFactory.getObjectDefinition(objectName);
  }

  /**
		 *
		 */
  void load() {
    (_applicationContextInitializer != null) ? _applicationContextInitializer : _applicationContextInitializer = new DefaultApplicationContextInitializer();
    _applicationContextInitializer.addEventListener(Event.COMPLETE, handleInitializationComplete);
    _applicationContextInitializer.initialize(this);
  }

  dynamic manage(dynamic instance, [String objectName = null]) {
    return _objectFactory.manage(instance, objectName);
  }

  /**
		 *
		 * @param childContext
		 * @return The current <code>IApplicationContext</code>
			 */
  IApplicationContext removeChildContext(IApplicationContext childContext) {
    /*
		    IChildContextManager manager = getChildContextManager();
			Function removeListener = function(event:ChildContextEvent):void {
				event.childContext.removeEventListener(ChildContextEvent.AFTER_CHILD_CONTEXT_REMOVE, childContextDisposedHandler);
				redispatch(event);
			};
			manager.addEventListener(ChildContextEvent.AFTER_CHILD_CONTEXT_REMOVE, removeListener);
			manager.addEventListener(ChildContextEvent.BEFORE_CHILD_CONTEXT_REMOVE, redispatch);
			manager.removeChildContext(this, childContext);
			manager.removeEventListener(ChildContextEvent.AFTER_CHILD_CONTEXT_REMOVE, removeListener);
			manager.removeEventListener(ChildContextEvent.BEFORE_CHILD_CONTEXT_REMOVE, redispatch);
			 */
    return this;
  }

  void removeIgnoredRootView(DisplayObject rootView) {
    if (removeDisplayObject(_ignoredRootViews, rootView)) {

    }
  }

  /**
		 * @inheritDoc
		 */
  void removeRootView(DisplayObject rootView) {
    if (removeDisplayObject(_rootViews, rootView)) {
      removeRootViewFromStageProcessing(rootView);
      LOGGER.finer("Removed root view {0}", [rootView]);
    }
  }


  dynamic wire(dynamic instance, [IObjectDefinition objectDefinition = null, List constructorArguments = null, String objectName = null]) {
    return _objectFactory.wire(instance, objectDefinition, constructorArguments, objectName);
  }

  bool addDisplayObject(List<DisplayObject> list, DisplayObject displayObject) {
    if ((null != displayObject) && list.indexOf(displayObject) < 0) {
      list[list.length] = displayObject;
      return true;
    }
    return false;
  }

  void addFactoryListeners(IObjectFactory objectFactory) {
    objectFactory.addEventListener(ObjectFactoryEvent.OBJECT_CREATED, redispatch);
    objectFactory.addEventListener(ObjectFactoryEvent.OBJECT_RETRIEVED, redispatch);
    objectFactory.addEventListener(ObjectFactoryEvent.OBJECT_WIRED, redispatch);
  }
/*
		  void childContextDisposedHandler(ContextEvent event) {
			removeChildContext(event.applicationContext);
		}

		  IChildContextManager getChildContextManager() {
			if (_childContextManagerName == null) {
				List<String> names = objectDefinitionRegistry.getObjectDefinitionNamesForType(IChildContextManager);
				_childContextManagerName = (names != null) ? names[0] : "";
			}
			if (_childContextManagerName.length > 0) {
				LOGGER.finer("Found definition for IChildContextManager in the current context, retrieving it");
				return _objectFactory.getObject(_childContextManagerName);
			} else {
				LOGGER.finer("No definition found for IChildContextManager in the current context, creating DefaultChildContextManager instance instead");
				return new DefaultChildContextManager();
			}
		}
*/
  void handleInitializationComplete(Event event) {
    _applicationContextInitializer.removeEventListener(Event.COMPLETE, handleInitializationComplete);
    ContextUtils.disposeInstance(_applicationContextInitializer);
    _applicationContextInitializer = null;
    _objectFactoryPostProcessors = null;
    _definitionProviders = null;
    LOGGER.finer("Application context initialization complete");
    redispatch(event);
  }

  void redispatch(Event event) {
    dispatchEvent(event);
  }

  bool removeDisplayObject(List<DisplayObject> _rootViews, DisplayObject rootView) {
    if (_rootViews == null) {
      return false;
    }
    int idx = _rootViews.indexOf(rootView);
    if (idx > -1) {
      _rootViews.removeAt(idx);
      return true;
    }
    return false;
  }
  void removeRootViewFromStageProcessing(DisplayObject rootView) {
    /*
			if (stageProcessorRegistry != null) {
				List<IStageObjectProcessor> processors = stageProcessorRegistry.getStageProcessorsByRootView(rootView);
				for (IStageObjectProcessor processor in processors) {
					List<IObjectSelector> selectors = stageProcessorRegistry.getObjectSelectorsForStageProcessor(processor);
					for (IObjectSelector selector in selectors) {
						stageProcessorRegistry.unregisterStageObjectProcessor(processor, selector, rootView);
					}
				}
			}
			* */
  }
/*
		  ApplicationDomain resolveRootViewApplicationDomain(List<DisplayObject> views) {
			if ((views != null) && (views.length > 0)) {
				try {
					Class cls = ClassUtils.forName(MXMODULES_MODULE_MANAGER_CLASS_NAME, Type.currentApplicationDomain);
					Object factory = cls[GET_ASSOCIATED_FACTORY_METHOD_NAME](views[0]);
					if (factory != null) {
						LOGGER.finer("Retrieving application domain from associated factory: {0}", [factory]);
						return ApplicationDomain(factory.info().currentDomain);
					}
				} catch (e:Error) {
				}
			}
			return Type.currentApplicationDomain;
		}
		  LoaderInfo resolveRootViewLoaderInfo(List<DisplayObject> views) {
			LoaderInfo loaderInfo;
			if ((views == null) || (views.length == 0)) {
				Stage stage = Environment.getCurrentStage();
				if (stage != null) {
					loaderInfo = stage.loaderInfo;
				}
			} else {
				loaderInfo = views[0].loaderInfo;
			}
			if (loaderInfo == null) {
				waitForLoaderInfo();
			}
			return loaderInfo;
		}

		  void unregisterStageProcessors(IStageObjectProcessorRegistry stageProcessorRegistry) {
			if (stageProcessorRegistry == null) {
				return;
			}
			for (DisplayObject view in _rootViews) {
				List<IStageObjectProcessor> processors = stageProcessorRegistry.getStageProcessorsByRootView(view);
				for (IStageObjectProcessor processor in processors) {
					List<IObjectSelector> selectors = stageProcessorRegistry.getObjectSelectorsForStageProcessor(processor);
					for (IObjectSelector selector in selectors) {
						stageProcessorRegistry.unregisterStageObjectProcessor(processor, selector, view);
						ContextUtils.disposeInstance(processor);
					}
					ContextUtils.disposeInstance(selector);
				}
			}
		}

		  void waitForLoaderInfo() {
			_token = setTimeout(function():void {
				clearTimeout(_token);
				if (_loaderInfo == null) {
					_loaderInfo = resolveRootViewLoaderInfo(_rootViews);
				}
			}, 100);
		}
   */

  @override
  IApplicationContext addDefinitionProvider(IObjectDefinitionsProvider provider) {
    if (definitionProviders.indexOf(provider) < 0) {
      if (provider is IApplicationContextAware) {
        (provider as IApplicationContextAware).applicationContext = this;
      }
      definitionProviders.add(provider);
      LOGGER.finer("Definition provider {0} added", [provider]);
    }
    return this;
  }

  IObjectFactory createDefaultObjectFactory() {
    DefaultObjectFactory defaultObjectFactory = new DefaultObjectFactory();
    defaultObjectFactory.objectDefinitionRegistry = new DefaultObjectDefinitionRegistry();
    defaultObjectFactory.cache = new DefaultInstanceCache();
    return defaultObjectFactory;
  }
}
