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
	 * The <code>Properties</code> class represents a collection of properties
	 * in the form of key-value pairs. All keys and values are of type
	 * <code>String</code>
	 *
	 * @author Christophe Herreman
	 * @author Roland Zwaga
	 */
	 class Properties implements IPropertiesProvider {

		 static final Logger logger = new Logger("Properties");

		/**
		 * Creates a new <code>Properties</code> object.
		 */
	 Properties():super() {
			_content = {};
			_propertyNames = new List<String>();
		}

		 Map _content;
		 List<String> _propertyNames;

		/**
		 * The content of the Properties instance as an object.
		 * @return an object containing the content of the properties
		 */
		 Map get content {
			return _content;
		}

		  int get length {
			return _propertyNames.length;
		}

		/**
		 * Returns an array with the keys of all properties. If no properties
		 * were found, an empty array is returned.
		 *
		 * @return an array with all keys
		 */
		  List<String> get propertyNames {
			return _propertyNames;
		}

		/**
		 * Gets the value of property that corresponds to the given <code>key</code>.
		 * If no property was found, <code>null</code> is returned.
		 *
		 * @param key the name of the property to get
		 * @returns the value of the property with the given key, or null if none was found
		 */
		  dynamic getProperty(String key) {
			return _content[key];
		}

		  bool hasProperty(String key) {
			return _content.containsKey(key);
		}

		/**
		 * Adds all conIPropertiese given properties object to this Properties.
		 */
		  void merge(IPropertiesProvider properties,[bool overrideProperty=false]) {
			if ((properties == null) || (properties == this)) {
				logger.finer("Invalid properties argument: $properties, ignoring merge");
				return;
			}
			logger.finer("Merging properties from {0} with override set to {1}", [properties, overrideProperty]);
			for (String key in properties.content.keys) {
				if (_content[key] == null || (_content[key] != null && overrideProperty)) {
					setProperty(key, properties.content[key]);
					/*addPropertyName(key);
					_content[key] = properties.content[key];*/
				}
			}
		}

		/**
		 * Sets a property. If the property with the given key already exists,
		 * it will be replaced by the new value.
		 *
		 * @param key the key of the property to set
		 * @param value the value of the property to set
		 */
		  void setProperty(String key,String value) {
			addPropertyName(key);
			_content[key] = value;
			//logger.finer("Added property: $key = $value");
		}

		  void addPropertyName(String key) {
			if (_propertyNames.indexOf(key) < 0) {
				_propertyNames.add(key);
			}
		}
	}

