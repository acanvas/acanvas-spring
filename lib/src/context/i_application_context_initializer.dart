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
	 * Describes an object that can handle the loading and initialization logic of an <code>IApplicationContext</code> implementation.
	 * @author Roland Zwaga
	 */
	 abstract class IApplicationContextInitializer extends /*I*/EventDispatcher {

		/**
		 *
		 * @param context
		 */
		 void initialize(IApplicationContext context);

		/**
		 * An <code>IPropertiesParser</code> instance that is used to turn textfiles into property key/value pairs.
		 */
		 IPropertiesParser get propertiesParser;

		/**
		 * @
		 */
		 void set propertiesParser(IPropertiesParser value);

		/**
		 *
		 */
		 ITextFilesLoader get textFilesLoader;

		/**
		 * @
		 */
		 void set textFilesLoader(ITextFilesLoader value);
	}

