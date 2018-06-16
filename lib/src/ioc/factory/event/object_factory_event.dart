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
	 * Event that is dispatched at various stages of object creation by an object factory.
	 * @author Roland Zwaga
	 */
class ObjectFactoryEvent extends Event {
  /**
		 *
		 */
  static const String OBJECT_CREATED = "objectCreated";
  /**
		 *
		 */
  static const String OBJECT_RETRIEVED = "objectRetrieved";
  /**
		 *
		 */
  static const String OBJECT_WIRED = "objectWired";

  dynamic _objectInstance;
  String _objectName;
  List _constructorArguments;

  /**
		 * Creates a new <code>ObjectFactoryEvent</code> instance.
		 * @param instance The managed instance that this event refers to.
		 * @param name The name of the object as its known by the object factory.
		 * @param constructorArgs The constructor arguments passed to the object factory for the specified instance.
		 */
  ObjectFactoryEvent(String type, dynamic instance, String name,
      [List constructorArgs = null, bool bubbles = false, bool cancelable = false])
      : super(type, bubbles) {
    _objectInstance = instance;
    _objectName = name;
    _constructorArguments = constructorArgs;
  }

  /**
		 * The constructor arguments passed to the object factory for the specified instance.
		 */
  List get constructorArguments {
    return _constructorArguments;
  }

  /**
		 * The managed instance that this event refers to.
		 */
  dynamic get objectInstance {
    return _objectInstance;
  }

  /**
		 * The name of the object as its known by the object factory.
		 */
  String get objectName {
    return _objectName;
  }

  /**
		 * Returns an exact copy of the current <code>ObjectFactoryEvent</code>.
		 * @return An exact copy of the current <code>ObjectFactoryEvent</code>.
		 */
  Event clone() {
    return new ObjectFactoryEvent(type, _objectInstance, _objectName, _constructorArguments, bubbles);
  }
}
