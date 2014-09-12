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
	 *
	 * @author Roland Zwaga
	 */
	 class ContextUtils {

		 static const String COMMA = ',';

		 static  void disposeInstance(Object instance) {
			if (instance is IDisposable) {
				(instance as IDisposable).dispose();
			}
		}


		 static List<String> commaSeparatedPropertyValueToStringVector(String propertyValue) {
			if (StringUtils.hasText(propertyValue)) {
				List parts = propertyValue.split(COMMA);
				List<String> result = new List<String>();
				for (String name in parts) {
					result[result.length] = StringUtils.trim(name);
				}
				return result;
			}
			return null;
		}
/*
		 static  String getMetadataArgument(Metadata metadata,String key) {
			if (metadata.hasArgumentWithKey(key)) {
				return metadata.getArgument(key).value;
			}
			return null;
		}

		 static  List<String> getCommaSeparatedArgument(Metadata metadata,String key) {
			if (metadata.hasArgumentWithKey(key)) {
				commaSeparatedPropertyValueToStringListmetadata.getArgument(key).value);
			}
			return null;
		}
*/
		 static  String arrayToString(List arr) {
			if (arr == null) {
				return "null";
			} else {
				List result = [];
				for (dynamic item in arr) {
					result[result.length] = (item != null) ? item.toString() : "null";
				}
				return result.join(', ');
			}
		}
	}

