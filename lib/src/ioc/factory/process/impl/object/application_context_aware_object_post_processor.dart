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
	 * <code>IObjectPostProcessor</code> implementation that checks for objects that implement the <code>IApplicationContextAware</code>
	 * abstract class and injects them with the provided <code>IApplicationContext</code> instance.
	 * @author Christophe Herreman
	 * @inheritDoc
	 */
class ApplicationContextAwareObjectPostProcessor implements IObjectPostProcessor {
  static final Logger logger = new Logger("ApplicationContextAwareObjectPostProcessor");

  IApplicationContext _applicationContext;

  /**
		 * Creates a new <code>ApplicationContextAwareProcessor</code> instance.
		 * @param applicationContext The <code>IApplicationContext</code> instance that will be injected.
		 */
  ApplicationContextAwareObjectPostProcessor(IApplicationContext applicationContext) {
    //Assert.notNull(applicationContext, "applicationContext argument must not be null");
    _applicationContext = applicationContext;
  }

  /**
		 * <p>If the specified object implements the <code>IApplicationContextAware</code> abstract class
		 * the <code>IApplicationContext</code> instance is injected.</p>
		 * @inheritDoc
		 */
  dynamic postProcessBeforeInitialization(dynamic object, String objectName) {
    if ((object is IApplicationContextAware)) {
      IApplicationContextAware applicationContextAware = (object as IApplicationContextAware);
      if ((applicationContextAware != null) && (applicationContextAware.applicationContext == null)) {
        logger.finer(
            "Instance {0} implements IApplicationContextAware, injecting it with {1}", [object, _applicationContext]);
        applicationContextAware.applicationContext = _applicationContext;
      }
    }
    return object;
  }

  /**
		 * @inheritDoc
		 */
  dynamic postProcessAfterInitialization(dynamic object, String objectName) {
    return object;
  }
}
