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
	 class ContextEvent extends Event {

		 static const String AFTER_DISPOSE = "afterApplicationContextDispose";
		 static const String AFTER_INITIALIZED = "afterApplicationContextInitialized";
		 IApplicationContext _applicationContext;

		/**
		 * Creates a new <code>ContextEvent</code> instance.
		 */
	 ContextEvent(String type,IApplicationContext context,[bool bubbles=false, bool cancelable=false]):super(type, bubbles) {
			_applicationContext = context;
		}


		  IApplicationContext get applicationContext {
			return _applicationContext;
		}

		  Event clone() {
			return new ContextEvent(type, _applicationContext, bubbles);
		}
	}

