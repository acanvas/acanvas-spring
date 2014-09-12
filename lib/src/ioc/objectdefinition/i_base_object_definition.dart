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
 part of spring_dart;

	/**
	 *
	 * @author rolandzwaga
	 */
	 abstract class IBaseObjectDefinition {

		/**
		 *  True if the object does not need to be eagerly pre-instantiated by the container. I.e. the object will be created
		 *  after the first call to the <code>getObject()</code> method.
		 *  @see org.springextensions.actionscript.ioc.factory.IObjectFactory#getObject() IObjectFactory.getObject()
		 */
		 bool get isLazyInit;

		 void set isLazyInit(bool value);


		/**
		 * Defines the scope of the object, the object is either a singleton or a prototype.
		 */
		 ObjectDefinitionScope get scope;

		 void set scope(ObjectDefinitionScope value);


	}

