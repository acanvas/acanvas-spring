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
part of rockdot_spring;

/**
	 *
	 */
// [Event(name="instancePrepared", type="org.springextensions.actionscript.ioc.factory.event.InstanceCacheEvent")]
/**
	 *
	 */
// [Event(name="instanceAdded", type="org.springextensions.actionscript.ioc.factory.event.InstanceCacheEvent")]
/**
	 *
	 */
// [Event(name="instanceRemoved", type="org.springextensions.actionscript.ioc.factory.event.InstanceCacheEvent")]
/**
	 *
	 */
// [Event(name="instanceUpdated", type="org.springextensions.actionscript.ioc.factory.event.InstanceCacheEvent")]
/**
	 *
	 */
// [Event(name="cacheCleared", type="org.springextensions.actionscript.ioc.factory.event.InstanceCacheEvent")]
/**
	 *
	 * @author Roland Zwaga
	 */
class DefaultInstanceCache extends EventDispatcher implements IInstanceCache, IDisposable {
  Logger logger;

  /**
		 * Creates a new <code>DefaultInstanceCache</code> instance.
		 */
  DefaultInstanceCache() : super() {
    logger = new Logger("DefaultInstanceCache");
    initialize();
  }

  Map _cache;
  List<String> _cachedNames;
  bool _isDisposed;
  List<String> _managedNames;
  Map _preparedCache;

  bool get isDisposed {
    return _isDisposed;
  }

  @override
  List<String> getCachedNames() {
    return _cachedNames;
  }

  /**
		 * @inheritDoc
		 */
  void clearCache() {
    clearCacheObject(_cache);
    clearCacheObject(_preparedCache);
    initialize();
    logger.finer("Instance {0} has been cleared", [this]);
  }

  /**
		 * @inheritDoc
		 */
  void dispose() {
    if (!isDisposed) {
      clearCacheObject(_cache);
      _cache = null;
      clearCacheObject(_preparedCache);
      _preparedCache = null;
      _cachedNames = null;
      _isDisposed = true;
      logger.finer("Instance {0} has been disposed", [this]);
    }
  }

  /**
		 * @inheritDoc
		 */
  dynamic getInstance(String name) {
    if (hasInstance(name)) {
      return _cache[name];
    } else {
      throw new StateError(name);
    }
  }

  /**
		 * @inheritDoc
		 */
  dynamic getPreparedInstance(String name) {
    if (isPrepared(name)) {
      return _preparedCache[name];
    } else {
      throw new StateError(name);
    }
  }

  List<String> getCachedNamesForType(Type clazz) {
    List<String> result = new List<String>();
    /*
    for (String name in _cachedNames) {
      
      if (reflect(_cache[name]).reflectee.runtimeType == clazz) {
        result.add(name);
      }

    }
    */
    return result;
  }

  /**
		 * @inheritDoc
		 */
  bool hasInstance(String name) {
    return _cache.containsKey(name);
  }

  /**
		 * @inheritDoc
		 */
  bool isManaged(String name) {
    return (_managedNames.indexOf(name) > -1);
  }

  /**
		 * @inheritDoc
		 */
  bool isPrepared(String name) {
    return _preparedCache.containsKey(name);
  }

  /**
		 * @inheritDoc
		 */
  int numInstances() {
    return _cachedNames.length;
  }

  /**
		 * @inheritDoc
		 */
  int numManagedInstances() {
    return _managedNames.length;
  }

  /**
		 * @inheritDoc
		 */
  void prepareInstance(String name, dynamic instance) {
    _preparedCache[name] = instance;
  }

  /**
		 * @inheritDoc
		 */
  void putInstance(String name, dynamic instance, [bool isManaged = true]) {
    if ((instance == null)) {
      throw new StateError("Null or undefined values are not allowed to be added to the instance cache");
    }
    int idx = _managedNames.indexOf(name);
    if (idx > -1) {
      _managedNames.removeAt(idx);
    }
    if (isManaged != null) {
      _managedNames.add(name);
    }
    if (!hasInstance(name)) {
      logger.finer("Adding instance {0} named '{1}'", [instance, name]);
      _cachedNames.add(name);
    }
    if (_cache[name] == null) {
      _cache[name] = instance;
      removePreparedInstance(name);
    } else {
      dynamic prevInstance = _cache[name];
      _cache[name] = instance;
      logger.finer("Replacing instance {0} named '{1}' with new instance {1}", [prevInstance, name, instance]);
    }
  }

  /**
		 * @inheritDoc
		 */
  dynamic removeInstance(String name) {
    if (hasInstance(name)) {
      dynamic instance = _cache[name];
      _cache.remove(name);
      int idx = _managedNames.indexOf(name);
      if (idx > -1) {
        _managedNames.removeAt(idx);
      }
      idx = _cachedNames.indexOf(name);
      if (idx > -1) {
        _cachedNames.removeAt(idx);
        logger.finer("Removed instance {0} named '{1}'", [instance, name]);
      }
      return instance;
    }
    return null;
  }

  void clearCacheObject(Map cacheObject) {
    for (String name in cacheObject) {
      if (isManaged(name)) {
        ContextUtils.disposeInstance(cacheObject[name]);
      }
      cacheObject.remove(name);
    }
  }

  void initialize() {
    _preparedCache = {};
    _cache = {};
    _cachedNames = new List<String>();
    _managedNames = new List<String>();
  }

  void removePreparedInstance(String name) {
    if (isPrepared(name)) {
      _preparedCache.remove(name);
    }
  }
}
