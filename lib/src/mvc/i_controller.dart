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
	 * Describes an object that acts as a registry for command classes that need to be
	 * instantiated and executed in response to the dispatching of an event.
	 * @author Roland Zwaga
	 */
abstract class IController extends /*I*/ EventDispatcher {
  /**
		 * Registers the specified command name for the specified event type.
		 * @param eventType The specified event type.
		 * @param commandName The specified command name.
		 */
  void registerCommandForEventType(String eventType, String commandName, String executeMethodName,
      [List<String> properties = null, int priority = 0]);
  /**
		 * Registers the specified command name for the specified event <code>Class</code>.
		 * @param eventClass The specified event <code>Class</code>.
		 * @param commandName The specified command name.
		 */
  // void registerCommandForEventClass(Type eventClass,String commandName,String executeMethodName,[List<String> properties=null, int priority=0]);

  /**
		 * If the <code>true</code> the current <code>IController</code> will throw an error if no commands were
		 * registered for a dispatched <code>Event</code>.
		 * @default true
		 */
  bool get failOnCommandNotFound;
  /**
		 * @
		 */
  void set failOnCommandNotFound(bool value);

  /**
		 * Clears all event/command mappings
		 */
  void clear();
}
