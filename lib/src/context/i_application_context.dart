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
	 *
	 * @author Roland Zwaga
	 */

abstract class IApplicationContext extends IObjectFactory /*, IStageObjectProcessorRegistryAware */ {
  /**
		 * Returns a <code>Vector</code> of <code>IApplicationContexts</code> that have been registered as a child of the current <code>IApplicationContext</code>.
		 */
  //Vector get childContexts.<IApplicationContext>;

  /**
		 * Returns all the <code>IObjectDefinitionsProviders</code> that have been added to the current <code>IApplicationContext</code>.
		 */
  List<IObjectDefinitionsProvider> get definitionProviders;

  /**
		 * Returns all the <code>IObjectFactoryPostProcessors</code> that have been added to the current <code>IApplicationContext</code>.
		 */
  List<IObjectFactoryPostProcessor> get objectFactoryPostProcessors;

  /**
		 *
		 */
  IApplicationContextInitializer get applicationContextInitializer;

  /**
		 * @
		 */
  void set applicationContextInitializer(IApplicationContextInitializer value);

  /**
		 *
		 */
  //Vector get ignoredRootViews.<DisplayObject>;

  /**
		 *
		 */
  //Vector get rootViews.<DisplayObject>;

  /**
		 * @param childContext the childContext.
		 * @param settings determines what data the parent context will share with te specified child context.
		 * @return the current <code>IApplicationContext</code>.
		 */
  // IApplicationContext addChildContext(IApplicationContext childContext,[ContextShareSettings settings=null]);

  /**
		 *
		 * @param provider
		 */
  IApplicationContext addDefinitionProvider(IObjectDefinitionsProvider provider);

  /**
		 *
		 * @param rootView
		 */
  void addIgnoredRootView(DisplayObject rootView);

  /**
		 *
		 * @param objectFactoryPostProcessor
		 */
  IApplicationContext addObjectFactoryPostProcessor(IObjectFactoryPostProcessor objectFactoryPostProcessor);

  /**
		 *
		 * @param rootView
		 */
  void addRootView(DisplayObject rootView);

  /**
		 *
		 * @param configurationPackage
		 */
  // IApplicationContext configure(IConfigurationPackage configurationPackage);

  /**
		 *
		 */
	Future load();

  /**
		 *
		 * @param childContext
		 * @return
		 */
  IApplicationContext removeChildContext(IApplicationContext childContext);

  /**
		 *
		 * @param rootView
		 */
  void removeIgnoredRootView(DisplayObject rootView);

  /**
		 *
		 * @param rootView
		 */
  void removeRootView(DisplayObject rootView);

  dynamic manage(dynamic instance, [String objectName = null]);
}
