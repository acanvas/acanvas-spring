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
   * Describes an object that acts as a cache for object instances.
   * @author Roland Zwaga
   */
   abstract class IInstanceCache extends /*I*/EventDispatcher {

    /**
     * Removes all the instances from the cache.
     */
     void clearCache();

    /**
     * Returns a <code>List&lt;String&gt;</code> of all the names of the cached objects in the current <code>IInstanceCache</code>.
     */
    List<String> getCachedNames();

    /**
     * Returns the instance that was associated with the specified name.
     * @param name The specified name
     * @return The instance associated with the specified name
     * @throws org.springextensions.actionscript.ioc.objectdefinition.error.ObjectDefinitionNotFoundError Thrown when an object with the specified name does not exist
     */
     dynamic getInstance(String name);

    /**
     * Returns the names of the instances that are of the specified type.
     * @param clazz The specified type.
     * @return The names of the instances that are of the specified type.
     */
     List<String> getCachedNamesForType(Type clazz);

    /**
     * Returns the prepared instance that was associated with the specified name.
     * @param name The specified name
     * @return The prepared instance associated with the specified name
     * @throws org.springextensions.actionscript.ioc.objectdefinition.error.ObjectDefinitionNotFoundError Thrown when a prepared object with the specified name does not exist
     */
     dynamic getPreparedInstance(String name);

    /**
     * Returns <code>true</code> if an instance has been associated with the specified name
     * @param name The specified name
     * @return <code>true</code> if an instance has been associated with the specified name
     */
     bool hasInstance(String name);

    /**
     *
     * @param name
     * @return
     */
     bool isPrepared(String name);

    /**
     * Returns <code>true</code> if the object for the specified name will be disposed by the current <code>IInstanceCache</code> after clearing.
     * @param name The name of the specified object.
     * @return <code>True</code> if the object for the specified name will be disposed by the current <code>IInstanceCache</code> after clearing.
     */
     bool isManaged(String name);

    /**
     * Returns the number of instances that have been added to the cache.
     * @return The number of instances that have been added to the cache.
     */
     int numInstances();

    /**
     * Returns the number of instances that have been added to the cache and that will be disposed after clearing of the current <code>IInstanceCache</code>.
     * @return The number of instances that have been added to the cache and that will be disposed after clearing of the current <code>IInstanceCache</code>.
     */
     int numManagedInstances();

    /**
     * Pre-caches an instance, instances in the prepared cache are not ready to be used yet, but usually in the process of being configured.
     * @param name
     * @param instance
     */
     void prepareInstance(String name,dynamic instance);

    /**
     * Adds the specified instance using the specified name.
     * @param name The specified name.
     * @param instance The specified instance.
     * @param isManaged Determines whether the cache will dispose the specified instance when it gets cleared.
     * @see #hasInstance()
     * @see #getInstance()
     */
     void putInstance(String name,dynamic instance,[bool isManaged=true]);

    /**
     * Removes the instance that was associated with the specified name.
     * @param name The specified name
     */
     dynamic removeInstance(String name);
  }

