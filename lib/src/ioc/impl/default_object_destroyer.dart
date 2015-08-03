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
	 * @author Roland Zwaga
	 */
	 class DefaultObjectDestroyer implements IObjectDestroyer, IApplicationContextAware, IDisposable {

		 Map _managedObjects;
		 bool _isDisposed;
		 IApplicationContext _applicationContext;
		 static const String NAMELESS = "nameless_object";

		 Logger logger;

		/**
		 * Creates a new <code>DefaultObjectDestroyer</code> instance.
		 */
	 DefaultObjectDestroyer(IApplicationContext context):super() {
			logger = new Logger("DefaultObjectDestroyer");
			_managedObjects = new Map();
			_applicationContext = context;
		}


		  @override void destroy(Object instance) {
			if (_managedObjects[instance] == null) {
				logger.info("Unregistered instance {0}, ignoring it.", [instance]);
				return;
			}
			ContextUtils.disposeInstance(instance);
			String objectName = _managedObjects[instance];
			_managedObjects.remove(instance);
			objectName = (objectName == NAMELESS) ? null : objectName;


			logger.info("Destroyed instance {0}", [instance]);
		}

		  void registerInstance(Object instance,[String objectName=null]) {
			if (instance != null) {
				(objectName != null) ? objectName :objectName =  NAMELESS;
				logger.info("Registered instance {0} with name {1}", [instance, objectName]);
				_managedObjects[instance] = objectName;
			}
		}

		  bool get isDisposed {
			return _isDisposed;
		}

		  @override void dispose() {
			if (!_isDisposed) {
				_isDisposed = true;
				_managedObjects = null;
				_applicationContext = null;
				logger.info("{0} has been disposed...", [this]);
			}
		}

		  IApplicationContext get applicationContext {
			return _applicationContext;
		}

		  void set applicationContext(IApplicationContext value) {
			_applicationContext = value;
		}
	}

