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
	 * Defines the abstract class for an object definition registry. This abstract class contains add methods
	 * needed to work with object definitions.
	 *
	 * @author Christophe Herreman
	 */
abstract class IObjectDefinitionRegistry {
  String get id;

  // --------------------------------------------------------------------
  //
  // Properties
  //
  // --------------------------------------------------------------------

  /**
		 * The number of object definitions in this registry.
		 *
		 * @return the number of object definitions in this registry
		 */
  int get numObjectDefinitions;

  /**
		 * The names of the registered object definitions.
		 *
		 * @return an array with all registered object definition names, or an empty array if no definitions are
		 * registered
		 */
  List<String> get objectDefinitionNames;

  // --------------------------------------------------------------------
  //
  // Methods
  //
  // --------------------------------------------------------------------

  /**
		 * Determines if the object factory contains a definition with the given name.
		 *
		 * @param objectName  The name/id  of the object definition
		 *
		 * @return true if a definition with that name exists
		 *
		 * @see org.springextensions.actionscript.ioc.IObjectDefinition
		 */
  bool containsObjectDefinition(String objectName);

  /**
		 *
		 * @param objectName
		 * @return
		 */
  //dynamic getCustomConfiguration(String objectName);

  /**
		 * Returns the names of the <code>IObjectDefinitions</code> that have the specified property set to the specified value.<br/>
		 * Optionally the selection may be reversed by setting the <code>returnMatching</code> argument to <code>false</code>.
		 * @param propertyName The specified property name.
		 * @param propertyValue The specified property value.
		 * @param returnMatching Determines if the <code>IObjectdefinition</code> needs to match or not the specified property and value to be added to the result.
		 * @return A vector of object names.
		 */
  //List<String> getDefinitionNamesWithPropertyValue(String propertyName,dynamic propertyValue,[bool returnMatching=true]);

  /**
		 * Returns the object definition registered with the given name. If the object
		 * definition does not exist <code>undefined</code> will be returned.
		 *
		 * @throws org.springextensions.actionscript.ioc.factory.NoSuchObjectDefinitionError if the object definition was not found in the registry
		 *
		 * @param objectName the name/id of the definition to retrieve
		 *
		 * @return the registered object definition
		 */
  IObjectDefinition getObjectDefinition(String objectName);

  /**
		 *
		 * @param objectDefinition
		 * @return
		 *
		 */
  String getObjectDefinitionName(IObjectDefinition objectDefinition);

  /**
		 * Returns the object definitions in this registry that are of
		 * the specified <code>Class</code>.
		 * @param type The specified <code>Class</code> that is searched for.
		 * @return an array containing definitions that implement the specified <code>Class</code>.
		 */
  List<IObjectDefinition> getObjectDefinitionsForType(Type type);

  /**
		 *
		 * @param metadataNames
		 * @return
		 */
  List<IObjectDefinition> getObjectDefinitionsWithMetadata(List<String> metadataNames);

  /**
		 * @param type
		 * @return
		 */
  List<String> getObjectDefinitionNamesForType(Type type);
  /**
		 *
		 * @return
		 */
  // List<String> getPrototypes();

  /**
		 *
		 * @return
		 */
  // List<String> getSingletons([bool lazyInit=false]);

  /**
		 * Returns the type that is defined on the object definition.
		 *
		 * @param objectName  The name/id  of the object definition
		 *
		 * @return the class that is used to construct the object
		 *
		 * @see org.springextensions.actionscript.ioc.IObjectDefinition
		 */
  // Class getType(String objectName);

  /**
		 * Returns a unique list of all <code>Classes</code> that are used by the <code>IObjectDefinitions</code>
		 * in the current <code>IObjectDefinitionRegistry</code>.
		 * @return A unique list of all <code>Classes</code>.
		 */
  List<Type> getUsedTypes();

  /**
		 * Determines if the definition with the given name is a prototype.
		 *
		 * @param objectName  The name/id  of the object definition
		 *
		 * @return true if the definitions is defined as a prototype
		 *
		 * @see org.springextensions.actionscript.ioc.IObjectDefinition
		 */
  bool isPrototype(String objectName);

  /**
		 * Determines if the definition with the given name is a singleton.
		 *
		 * @param objectName  The name/id  of the object definition
		 *
		 * @return true if the definitions is defined as a singleton
		 *
		 * @see org.springextensions.actionscript.ioc.IObjectDefinition
		 */
  bool isSingleton(String objectName);

  /**
		 *
		 * @param objectName
		 * @param configurator
		 */
  //void registerCustomConfiguration(String objectName,dynamic configurator);

  /**
		 * Registers the given objectDefinition under the given name.
		 *
		 * @param objectName the name under which the object definition should be stored
		 * @param objectDefinition the object definition to store
		 */
  void registerObjectDefinition(String objectName, IObjectDefinition objectDefinition, [bool allowOverride = true]);

  /**
		 * Removes the definition with the given name from the registry
		 *
		 * @param objectName  The name/id of the definition to remove
		 */
  IObjectDefinition removeObjectDefinition(String objectName);

  List<String> getSingletons();
}
