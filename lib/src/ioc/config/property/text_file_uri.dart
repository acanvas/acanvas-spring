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
	 *
	 * @author Roland Zwaga
	 */
class TextFileURI {
  /**
		 * Creates a new <code>TextFileURI</code> instance.
		 * @param URI
		 * @param prevent
		 */
  TextFileURI(String URI, bool required, [bool prevent = true]) : super() {
    _textFileURI = URI;
    _isRequired = required;
    _preventCache = prevent;
  }

  bool _preventCache;
  bool _isRequired;
  String _textFileURI;

  bool get isRequired {
    return _isRequired;
  }

  bool get preventCache {
    return _preventCache;
  }

  String get textFileURI {
    return _textFileURI;
  }

  String toString() {
    return "TextFileURI{preventCache:" +
        _preventCache.toString() +
        ", isRequired:" +
        _isRequired.toString() +
        ", textFileURI:\"" +
        _textFileURI +
        "\"}";
  }
}
