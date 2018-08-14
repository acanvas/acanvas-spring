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
	 * Enumeration for the scopes of an object definition.
	 * @author Christophe Herreman
	 */
class ObjectDefinitionScope {
  static final Map<String, ObjectDefinitionScope> TYPES = new Map();

  /**
		 * Multiple instances of the specified object can exist
		 */
  static final ObjectDefinitionScope PROTOTYPE =
      new ObjectDefinitionScope(PROTOTYPE_NAME);
  /**
		 * Only one instance of the specified object can exist
		 */
  static final ObjectDefinitionScope SINGLETON =
      new ObjectDefinitionScope(SINGLETON_NAME);
  /**
		 * The specified object is a stage component
		 */
  static final ObjectDefinitionScope STAGE =
      new ObjectDefinitionScope(STAGE_NAME);
  /**
		 * The specified object is created remotely
		 */
  static final ObjectDefinitionScope REMOTE =
      new ObjectDefinitionScope(REMOTE_NAME);

  static const String PROTOTYPE_NAME = "prototype";
  static const String SINGLETON_NAME = "singleton";
  static const String STAGE_NAME = "stage";
  static const String REMOTE_NAME = "remote";

  String _name;
  //{
  //_enumCreated = true;
  //}

  /**
		 * Creates a new ObjectDefintionScope object.
		 * This constructor is only used internally to set up the enum and all
		 * calls will fail.
		 * @param name the name of the scope
		 */
  ObjectDefinitionScope(String name) {
    //Assert.state(!_enumCreated, "The ObjectDefinitionScope enum has already been created.");
    _name = name;
    TYPES[_name] = this;
  }

  /**
		 *
		 */
  static ObjectDefinitionScope fromName(String name) {
    return TYPES[StringUtils.trim(name.toLowerCase())];
  }

  /**
		 * Returns the name of the scope.
		 */
  String get name {
    return _name;
  }

  String toString() {
    return _name;
  }
}
