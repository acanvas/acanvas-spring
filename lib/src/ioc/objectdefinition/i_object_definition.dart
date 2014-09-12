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


	// [Event(name="instancesDependenciesUpdated", type="org.springextensions.actionscript.ioc.objectdefinition.event.ObjectDefinitionEvent")]
	/**
	 * Represents an object definition.
	 *
	 * @author Christophe Herreman
	 * @author Damir Murat
	 * @author Roland Zwaga
	 */
	 abstract class IObjectDefinition extends IBaseObjectDefinition with /*, I*/EventDispatcher {

		/**
		 * The fully qualified classname of the object that the current <code>IObjectDefinition</code> describes.
		 */
		 String get className;
		/**
		 * @
		 */
		 void set className(String value);

		 String get name;
		/**
		 * @
		 */
		 void set name(String value);

		 /**
		 * The <code>Class</code> of the object that the current <code>IObjectDefinition</code> describes.
		 */
		 Type get clazz;
		/**
		 * @
		 */
		 void set clazz(Type value);

		/**
		 * An array of arguments that will be passed to the constructor of the object.
		 */
		 List get constructorArguments;
		/**
		 * @
		 */
		 void set constructorArguments(List value);


		/**
		 *
		 */
		 bool get isAbstract;

		/**
		 * @
		 */
		 void set isAbstract(bool value);

		/**
		 * Determines if the class whose configuration is described by the current <code>IObjectDefinition</code> is an abstract class;
		 */
		 bool get isInterface;

		/**
		 * @
		 */
		 void set isInterface(bool value);

		/**
		 * True if only one instance of this object needs to be created by the container, i.e. every subsequent call to the <code>getObject()</code>
		 * method will return the same instance.
		 * @see org.springextensions.actionscript.ioc.factory.IObjectFactory#getObject() IObjectFactory.getObject()
		 */
		 bool get isSingleton;
	}

