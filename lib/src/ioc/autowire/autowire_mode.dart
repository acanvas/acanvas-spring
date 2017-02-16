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
	 * Enumeration for the autowire types of an object definition.
	 * @author Martino Piccinato
	 * @see org.springextensions.actionscript.ioc.IObjectDefinition
	 * @docref container-documentation.html#autowiring_objects
	 */
class AutowireMode {
  static final Map TYPES = new Map();

  /** No autowire on the object */
  static final AutowireMode NO = new AutowireMode(NO_NAME);

  /** Autowire unclaimed non simple properties with object having the same name of the properties */
  static final AutowireMode BYNAME = new AutowireMode(BYNAME_NAME);

  /** Autowire unclaimed non simple properties with objects having the same type */
  static final AutowireMode BYTYPE = new AutowireMode(BYTYPE_NAME);

  /** Autowire constructor arguments with objects having the same type */
  static final AutowireMode CONSTRUCTOR = new AutowireMode(CONSTRUCTOR_NAME);

  /** Autowire by constructor or by type depending whether there is a constructor with arguments or not */
  static final AutowireMode AUTODETECT = new AutowireMode(AUTODETECT_NAME);

  /** Autowired values */
  static const String NO_NAME = "no";
  static const String BYNAME_NAME = "byName";
  static const String BYTYPE_NAME = "byType";
  static const String CONSTRUCTOR_NAME = "constructor";
  static const String AUTODETECT_NAME = "autodetect";
  static const String ALREADY_CREATED_ERROR = "The AutowireMode enum has already been created.";

  String _name;

  //	{
  //	_enumCreated = true;
  //}

  /**
		 * Creates a new ObjectDefintionAutowire object.
		 * This constructor is only used internally to set up the enum and all
		 * calls will fail.
		 *
		 * @param name the name of the scope
		 */
  AutowireMode(String name) {
    // Assert.state(!_enumCreated, ALREADY_CREATED_ERROR);
    _name = name;
    TYPES[_name.toLowerCase()] = this;
  }

  /**
		 *
		 */
  static AutowireMode fromName(String name) {
    if (!StringUtils.hasText(name)) {
      return NO;
    }
    name = name.toLowerCase();
    return (TYPES[name] != null) ? TYPES[name] : NO;
  }

  /**
		 * Returns the name of the autowire type.
		 */
  String get name {
    return _name;
  }

  /**
		 *
		 */
  String toString() {
    return _name;
  }
}
