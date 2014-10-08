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
	 * Defines the most basic service used to implement dependency injection.
	 * @author Martino Piccinato
	 * @author Roland Zwaga
	 */
	 abstract class IDependencyInjector extends /*I*/EventDispatcher {
		/**
		 *
		 * @param instance
		 * @param objectDefinition
		 * @param objectName
		 * @param objectPostProcessors
		 * @param referenceResolvers
		 */
		 Object wire(dynamic instance,IObjectFactory objectFactory,[IObjectDefinition objectDefinition=null, String objectName=null]);
		/**
		 *
		 * @param objectDefinition
		 * @param instance
		 * @param objectFactory
		 */
		 void executeMethodInvocations(IObjectDefinition objectDefinition,dynamic instance,IObjectFactory objectFactory);
		/**
		 *
		 * @param instance
		 * @param objectDefinition
		 */
		 void initializeInstance(dynamic instance,[IObjectDefinition objectDefinition=null]);
		/**
		 *
		 * @param instance
		 * @param objectDefinition
		 * @param objectName
		 * @param objectFactory
		 */
		 void injectProperties(dynamic instance,IObjectDefinition objectDefinition,String objectName,IObjectFactory objectFactory);
	}

