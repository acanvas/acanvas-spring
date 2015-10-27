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
// [Event(name="complete", type="flash.events.Event")]
/**
	 *
	 * @author Roland Zwaga
	 */
class DefaultApplicationContextInitializer extends EventDispatcher
    implements IApplicationContextInitializer, IDisposable {
  static const String APPLICATION_CONTEXT_PROPERTIES_LOADER_NAME = "applicationContextTextFilesLoader";
  static const String DEFINITION_PROVIDER_QUEUE_NAME = "definitionProviderQueue";
  Logger LOGGER;
  static const String NEWLINE_CHAR = "\n";
  static const String OBJECT_FACTORY_POST_PROCESSOR_QUEUE_NAME = "objectFactoryPostProcessorQueue";

  /**
		 * Creates a new <code>DefaultApplicationContextInitializer</code> instance.
		 */
  DefaultApplicationContextInitializer([/*I*/ EventDispatcher target = null]) : super(/*target*/) {
    LOGGER = new Logger("DefaultApplicationContextInitializer");
  }

  IApplicationContext _applicationContext;
  bool _isDisposed = false;
  IOperationQueue _operationQueue;
  IPropertiesParser _propertiesParser;
  ITextFilesLoader _textFilesLoader;

  bool get isDisposed {
    return _isDisposed;
  }

  /**
		 * @inheritDoc
		 */
  IPropertiesParser get propertiesParser {
    return _propertiesParser;
  }

  /**
		 * @
		 */
  void set propertiesParser(IPropertiesParser value) {
    _propertiesParser = value;
  }

  /**
		 * @inheritDoc
		 */
  ITextFilesLoader get textFilesLoader {
    return _textFilesLoader;
  }

  /**
		 * @
		 */
  void set textFilesLoader(ITextFilesLoader value) {
    _textFilesLoader = value;
  }

  void dispose() {
    if (!_isDisposed) {
      _isDisposed = true;
      ContextUtils.disposeInstance(_propertiesParser);
      _propertiesParser = null;
      ContextUtils.disposeInstance(_operationQueue);
      _operationQueue = null;
      ContextUtils.disposeInstance(_textFilesLoader);
      _textFilesLoader = null;
      _applicationContext = null;
      LOGGER.finer("Instance {0} has been disposed", [this]);
    }
  }

  void initialize(IApplicationContext context) {
    _applicationContext = context;
    if (!_applicationContext.isReady) {
      _operationQueue = new OperationQueue(DEFINITION_PROVIDER_QUEUE_NAME);

      for (IObjectDefinitionsProvider provider in _applicationContext.definitionProviders) {
        LOGGER.finer("Executing object definitions provider {0}", [provider]);
        IOperation operation = provider.createDefinitions();
        if (operation != null) {
          LOGGER.finer("Object definitions provider {0} is asynchronous...", [provider]);
          operation.addCompleteListener(providerCompleteHandler, false, 0, true);
          _operationQueue.addOperation(operation);
        } else {
          handleObjectDefinitionResult(provider);
        }
      }
      if (_operationQueue.total > 0) {
        _operationQueue.addCompleteListener(providersLoadedHandler);
        _operationQueue.addErrorListener(providersLoadErrorHandler);
      } else {
        _operationQueue = null;
        cleanUpObjectDefinitionCreation();
      }
    }
  }

  void providerCompleteHandler(OperationEvent event) {
    //handleObjectDefinitionResult(AsyncObjectDefinitionProviderResultOperation(event.operation).objectDefinitionsProvider);
  }

  void cleanUpObjectDefinitionCreation() {
    ContextUtils.disposeInstance(_propertiesParser);
    _propertiesParser = null;
    for (IObjectDefinitionsProvider definitionProvider in _applicationContext.definitionProviders) {
      ContextUtils.disposeInstance(definitionProvider);
    }
    _applicationContext.definitionProviders.length = 0;
    _operationQueue = null;
    ContextUtils.disposeInstance(_textFilesLoader);
    _textFilesLoader = null;
    _applicationContext.isReady = true;
    injectContextParts();
    _applicationContext.dispatchEvent(new ContextEvent(ContextEvent.AFTER_INITIALIZED, _applicationContext));
    executeObjectFactoryPostProcessors();
  }

  void injectContextParts() {
    injectEventBus();
    injectObjectDestroyer();
  }

  void injectObjectDestroyer() {
    if (_applicationContext.objectDestroyer != null) {
      return;
    }
    List<String> names = _applicationContext.objectDefinitionRegistry.getObjectDefinitionNamesForType(IObjectDestroyer);
    if (names == null) {
      _applicationContext.objectDestroyer = new DefaultObjectDestroyer(_applicationContext);
    } else if (names.length == 1) {
      _applicationContext.objectDestroyer = _applicationContext.getObject(names[0]);
    } else {
      throw new StateError("Multiple IObjectDestroyer implementations found in context: " + names.join(','));
    }
  }

  void injectEventBus() {
    if (_applicationContext is IEventBusAware) {
      if ((_applicationContext as IEventBusAware).eventBus != null) {
        return;
      }
      List<String> names = _applicationContext.objectDefinitionRegistry.getObjectDefinitionNamesForType(IEventBus);
      if (names == null) {
        (_applicationContext as IEventBusAware).eventBus = new XLEventBus();
      } else if (names.length == 1) {
        (_applicationContext as IEventBusAware).eventBus = _applicationContext.getObject(names[0]);
      } else {
        throw new StateError("Multiple IEventBus implementations found in context: " + names.join(','));
      }
    }
  }

  void completeContextInitialization() {
    dispatchEvent(new Event(Event.COMPLETE));
  }

  void executeObjectFactoryPostProcessors() {
    _operationQueue = new OperationQueue(OBJECT_FACTORY_POST_PROCESSOR_QUEUE_NAME);
    for (IObjectFactoryPostProcessor postprocessor in _applicationContext.objectFactoryPostProcessors) {
      LOGGER.finer("Executing object factory postprocessor {0}", [postprocessor]);
      IOperation operation = postprocessor.postProcessObjectFactory(_applicationContext);
      if (operation != null) {
        LOGGER.finer("Objectfactory postprocessor {0} is asynchronous...", [postprocessor]);
        _operationQueue.addOperation(operation);
      }
    }
    if (_operationQueue.total > 0) {
      _operationQueue.addCompleteListener(handleObjectFactoryPostProcessorsComplete, false, 0, true);
      _operationQueue.addErrorListener(handleObjectFactoryPostProcessorsError, false, 0, true);
    } else {
      finalizeObjectFactoryProcessorExecution();
    }
  }

  void finalizeObjectFactoryProcessorExecution() {
    for (IObjectFactoryPostProcessor postprocessor in _applicationContext.objectFactoryPostProcessors) {
      ContextUtils.disposeInstance(postprocessor);
    }
    if (_applicationContext.objectFactoryPostProcessors != null) {
      _applicationContext.objectFactoryPostProcessors.length = 0;
    }
    List<String> names;
    if (_applicationContext.cache != null) {
      names = _applicationContext.cache.getCachedNames();
    }
    instantiateSingletons();
    wireExplicitSingletons(names);
    completeContextInitialization();
  }

  void handleObjectDefinitionResult(IObjectDefinitionsProvider objectDefinitionsProvider) {
    if (objectDefinitionsProvider == null) {
      return;
    }
    registerObjectDefinitions(objectDefinitionsProvider.objectDefinitions);

    List<TextFileURI> propertyURIs = objectDefinitionsProvider.propertyURIs;
    bool objectDefinitionsProviderHasPropertyURIs = (propertyURIs != null) && (propertyURIs.length > 0);

    if (objectDefinitionsProviderHasPropertyURIs != null) {
      loadPropertyURIs(propertyURIs);
    }
    if ((objectDefinitionsProvider.propertiesProvider != null) &&
        (objectDefinitionsProvider.propertiesProvider.length > 0)) {
      LOGGER.finer("Object definitions provider returned a set of properties, adding it to the context");
      _applicationContext.propertiesProvider.merge(objectDefinitionsProvider.propertiesProvider);
    }
  }

  void handleObjectFactoryPostProcessorsComplete(dynamic result) {
    finalizeObjectFactoryProcessorExecution();
  }

  void handleObjectFactoryPostProcessorsError(dynamic error) {
    LOGGER.severe("Objectfactory post processing encountered an error: ", [error]);
  }

  void instantiateSingletons() {
    if ((_applicationContext.cache == null) || (_applicationContext.objectDefinitionRegistry == null)) {
      return;
    }
    List<String> names = _applicationContext.objectDefinitionRegistry.getSingletons();
    for (String name in names) {
      if (!_applicationContext.cache.hasInstance(name)) {
        LOGGER.finer("Instantiating singleton named '{0}'", [name]);
        _applicationContext.getObject(name);
      }
    }
  }

  void loadPropertyURIs(List<TextFileURI> propertyURIs) {
    LOGGER.finer("Loading property URI's");
    (_textFilesLoader != null) ? _textFilesLoader : _textFilesLoader = createTextFilesLoader();
    _textFilesLoader.addURIs(propertyURIs);
  }

  ITextFilesLoader createTextFilesLoader() {
    ITextFilesLoader textFilesLoader = new TextFilesLoader(APPLICATION_CONTEXT_PROPERTIES_LOADER_NAME);
    textFilesLoader.addCompleteListener(propertyTextFilesLoadComplete, false, 0, true);
    _operationQueue.addOperation(textFilesLoader);
    return textFilesLoader;
  }

  void propertyTextFilesLoadComplete(OperationEvent operationEvent) {
    List<String> propertySources = operationEvent.result;
    if (propertySources != null) {
      Properties properties = new Properties();
      String source = propertySources.join(NEWLINE_CHAR);
      (propertiesParser != null) ? propertiesParser : propertiesParser = new KeyValuePropertiesParser();
      LOGGER.finer("External properties files loaded, starting to parse it using {0}", [propertiesParser]);
      propertiesParser.parseProperties(source, properties);
      _applicationContext.propertiesProvider.merge(properties);
    }
  }

  void registerObjectDefinitions(Map newObjectDefinitions) {
    if (_applicationContext.objectDefinitionRegistry != null) {
      for (String name in newObjectDefinitions.keys) {
        _applicationContext.objectDefinitionRegistry.registerObjectDefinition(name, newObjectDefinitions[name]);
      }
    }
  }

  void wireExplicitSingletons(List<String> names) {
    if (_applicationContext.dependencyInjector != null) {
      for (String name in names) {
        if (!_applicationContext.objectDefinitionRegistry.containsObjectDefinition(name)) {
          LOGGER.finer(
              "Wiring explicit singleton named '{0}' (a cached object without a corresponding object definition)",
              [name]);
          _applicationContext.manage(_applicationContext.cache.getInstance(name), name);
        }
      }
    }
  }

  void providersLoadErrorHandler(dynamic error) {
    cleanQueueAfterDefinitionProviders(_operationQueue);
    LOGGER.severe("Object definitions provider encountered an error: ", [error]);
  }

  void providersLoadedHandler(OperationEvent operationEvent) {
    cleanQueueAfterDefinitionProviders(_operationQueue);
    cleanUpObjectDefinitionCreation();
  }

  void cleanQueueAfterDefinitionProviders(IOperationQueue queue) {
    queue.removeCompleteListener(providersLoadedHandler);
    queue.removeErrorListener(providersLoadErrorHandler);
  }
}
