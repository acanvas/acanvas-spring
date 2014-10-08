/*
* Copyright 2007-2012 the original author or authors.
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
	 * @author Roland Zwaga
	 */
	 class AbstractObjectDefinitionsProvider implements IObjectDefinitionsProvider, IDisposable {

		 Object _objectDefinitions;
		 IBaseObjectDefinition _defaultObjectDefinition;
		 List<TextFileURI> _propertyURIs;
		 IPropertiesProvider _propertiesProvider;
		 bool _isDisposed = false;

		/**
		 * Creates a new <code>AbstractObjectDefinitionsProvider</code> instance.
		 */
	 AbstractObjectDefinitionsProvider() : super(){
			_propertyURIs = new List<TextFileURI>();
			_objectDefinitions = {};
			_propertiesProvider = new Properties();
			_propertyURIs = new List<TextFileURI>();
		}

		  IOperation createDefinitions() {
			throw new StateError("Not implemented in abstract base class");
		}

		  Object get objectDefinitions {
			return _objectDefinitions;
		}

		  List<TextFileURI> get propertyURIs {
			return _propertyURIs;
		}

		  IPropertiesProvider get propertiesProvider {
			return _propertiesProvider;
		}

		  IBaseObjectDefinition get defaultObjectDefinition {
			return _defaultObjectDefinition;
		}

		  void set defaultObjectDefinition(IBaseObjectDefinition value) {
			_defaultObjectDefinition = value;
		}

		  void set objectDefinitions(Object value) {
			_objectDefinitions = value;
		}

		  bool get isDisposed {
			return _isDisposed;
		}

		  void dispose() {
			if (!_isDisposed) {
				_isDisposed = true;
				_propertyURIs = null;
				_objectDefinitions = null;
				_propertiesProvider = null;
				_propertyURIs = null;
			}
		}
	}

