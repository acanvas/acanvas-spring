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
part of spring_dart;


/**
	 *
	 * @author Roland Zwaga
	 */
class DefaultObjectDefinitionRegistry implements IObjectDefinitionRegistry, IDisposable /*, IApplicationDomainAware */{
  static const String CHARACTERS = "abcdefghijklmnopqrstuvwxyz";
  static const String FACTORY_OBJECT_PREFIX = '&';
  static const String IS_SINGLETON_FIELD_NAME = "isSingleton";
  static const String METADATA_KEY_SUFFIX = '____';
  static const String OBJECT_DEFINITION_NAME_EXISTS_ERROR = "Object definition with name '{0}' has already been registered and no overrides are allowed.";

  //static ILogger logger = getClassLogger(DefaultObjectDefinitionRegistry);
  RockdotLogger logger;

  static String generateRegistryId() {
    int len = 20;
    List result = new List(20);
    while (len > 0) {
     var ran = (new Random().nextDouble()* 26).floor(); 
      result[--len] = CHARACTERS[ran];
    }
    return result.join('');
  }

  /**
		 * Creates a new <code>DefaultObjectDefinitionRegistry</code> instance.
		 *
		 */
  DefaultObjectDefinitionRegistry() : super() {
    logger = new RockdotLogger("DefaultObjectDefinitionRegistry");
    _objectDefinitions = {};
    _objectDefinitionList = new List<IObjectDefinition>();
    _objectDefinitionNames = new List<String>();
    _objectDefinitionClasses = new List<Type>();
    _objectDefinitionMetadataLookup = new Map();
    _objectDefinitionNameLookup = new Map();
    _id = generateRegistryId();
    logger.finer("Created new DefaultObjectDefinitionRegistry with id {0}", [_id]);
  }

  Map _customConfigurations;
  String _id;
  bool _isDisposed;
  List<Type> _objectDefinitionClasses;
  List<IObjectDefinition> _objectDefinitionList;
  Map _objectDefinitionMetadataLookup;
  Map _objectDefinitionNameLookup;
  List<String> _objectDefinitionNames;
  Map _objectDefinitions;


  /**
		 * @inheritDoc
		 */
  String get id {
    return _id;
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
  int get numObjectDefinitions {
    return _objectDefinitionNames.length;
  }

  /**
		 * @inheritDoc
		 */
  List<String> get objectDefinitionNames {
    return _objectDefinitionNames;
  }

  /**
		 * @inheritDoc
		 */
  bool containsObjectDefinition(String objectName) {
    bool result = _objectDefinitions[objectName] != null;
    if (!result) {
      result = _objectDefinitions[FACTORY_OBJECT_PREFIX + objectName] != null;
    }
    return result;
  }

  /**
		 * @inheritDoc
		 */
  void dispose() {
    if (!_isDisposed) {
      for (String name in _objectDefinitionNames) {
        IObjectDefinition objectDefinition = (_objectDefinitions[name] as IObjectDefinition);
        ContextUtils.disposeInstance(objectDefinition);
      }
      _objectDefinitions = null;
      _objectDefinitionNames = null;
      _objectDefinitionClasses = null;
      _objectDefinitionMetadataLookup = null;
      _objectDefinitionList = null;
      _objectDefinitionNames = null;
      _customConfigurations = null;
      _isDisposed = true;
      logger.finer("Instance {0} has been disposed...", [this]);
    }
  }


  /**
		 * @inheritDoc
		 */
  IObjectDefinition getObjectDefinition(String objectName) {
    return _objectDefinitions[objectName] as IObjectDefinition;
  }

  /**
		 * @inheritDoc
		 */
  String getObjectDefinitionName(IObjectDefinition objectDefinition) {
    return _objectDefinitionNameLookup[objectDefinition] as String;
  }

  /**
		 * @inheritDoc
		 */
  List<String> getObjectDefinitionNamesForType(Type type) {
    List<String> result;
    for (String name in _objectDefinitionNames) {
      IObjectDefinition definition = getObjectDefinition(name);
      if (definition.clazz != null) {
        if (ClassUtils.isAssignableFrom(type, definition.clazz)) {
          ((result != null) ? result : result = new List<String>())[result.length] = name;
        }
      }
    }
    return result;
  }

  /**
		 * @inheritDoc
		 */
  List<IObjectDefinition> getObjectDefinitionsForType(Type type) {
    List<IObjectDefinition> result;
    for (IObjectDefinition definition in _objectDefinitionList) {
      if (ClassUtils.isAssignableFrom(type, definition.clazz)) {
        ((result != null) ? result : result = new List<IObjectDefinition>())[result.length] = definition;
      }
    }
    return result;
  }

  /**
		 * @inheritDoc
		 */
  List<IObjectDefinition> getObjectDefinitionsWithMetadata(List<String> metadataNames) {
    List<IObjectDefinition> result;
    for (String name in metadataNames) {
      name = name.toLowerCase() + METADATA_KEY_SUFFIX;
      List<IObjectDefinition> list = _objectDefinitionMetadataLookup[name];
      if (list != null) {
        result = ((result != null) ? result : result = new List<IObjectDefinition>())..addAll(list);
      }
    }
    return result;
  }


  /**
		 * @inheritDoc
		 */
  List<Type> getUsedTypes() {
    return _objectDefinitionClasses;
  }

  /**
		 * @inheritDoc
		 */
  bool isPrototype(String objectName) {
    IObjectDefinition objectDefinition = getObjectDefinition(objectName);
    return (objectDefinition != null) ? (objectDefinition.scope == ObjectDefinitionScope.PROTOTYPE) : false;
  }

  /**
		 * @inheritDoc
		 */
  bool isSingleton(String objectName) {
    return !(isPrototype(objectName));
  }


  /**
		 * @inheritDoc
		 */
  void registerObjectDefinition(String objectName, IObjectDefinition objectDefinition, [bool allowOverride = true]) {
    bool contains = containsObjectDefinition(objectName);
    if (contains && allowOverride) {
      removeObjectDefinition(objectName);
    } else if (contains && !allowOverride) {
      throw new StateError(StringUtils.substitute(OBJECT_DEFINITION_NAME_EXISTS_ERROR, [objectName]));
    }

    _objectDefinitions[objectName] = objectDefinition;
    _objectDefinitionNames.add(objectName);

    if ((StringUtils.hasText(objectDefinition.className))) {
      Type cls = objectDefinition.clazz;

      //addToMetadataLookup(objectDefinition, cls);

      if (_objectDefinitionClasses.indexOf(cls) < 0) {
        _objectDefinitionClasses.add(cls);
      }
     /*
      if (ClassUtils.isImplementationOf(cls, IFactoryObject)) {
        objectName = FACTORY_OBJECT_PREFIX + objectName;
      }
       */
      objectDefinition.clazz = cls;
      objectDefinition.isInterface = false;
    }


    _objectDefinitionNameLookup[objectDefinition] = objectName;
    _objectDefinitionList.add(objectDefinition);
    //logger.finer("Registered definition '{0}': {1}", [objectName, objectDefinition]);
  }

  /**
		 * @inheritDoc
		 */
  IObjectDefinition removeObjectDefinition(String objectName) {
    IObjectDefinition definition;
    if (containsObjectDefinition(objectName)) {
      definition = getObjectDefinition(objectName);
      int idx;
      List<String> list = getObjectDefinitionNamesForType(definition.clazz);
      bool deleteClass = ((list != null) && (list.length == 1));
      if (deleteClass != null) {
        idx = _objectDefinitionClasses.indexOf(definition.clazz);
        if (idx > -1) {
          _objectDefinitionClasses.removeAt(idx);
        }
      }

      _objectDefinitionNameLookup.remove(definition);
      idx = _objectDefinitionList.indexOf(definition);
      if (idx > -1) {
        _objectDefinitionList.removeAt(idx);
      }
      _objectDefinitions.remove(objectName);
      idx = _objectDefinitionNames.indexOf(objectName);
      if (idx > -1) {
        _objectDefinitionNames.removeAt(idx);
      }
    }
    logger.finer("Removed definition {0}", [objectName]);
    return definition;
  }

  @override
  List<String> getSingletons() {
    List<String> names = [];
    _objectDefinitionList.where((IObjectDefinition o){return o.isSingleton;}).forEach((IObjectDefinition o){names.add(o.name);});
    return names;
  }
}
