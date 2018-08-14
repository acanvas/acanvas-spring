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
part of acanvas_spring;

/**
	 * Describes the the configuration of a single instance property.
	 * @author Roland Zwaga
	 */
class PropertyDefinition implements ICloneable {
  String _name;
  String _namespaceURI;
  dynamic _value;
  bool _isStatic;
  bool _isSimple;
  bool _isLazy;

  bool get isLazy {
    return _isLazy;
  }

  void set isLazy(bool value) {
    _isLazy = value;
  }

  bool get isSimple {
    return _isSimple;
  }

  void set isSimple(bool value) {
    _isSimple = value;
  }

  String _qName;

  String get qName {
    return (_qName != null) ? _qName : _qName = createQName();
  }

  String createQName() {
    String ns = StringUtils.hasText(_namespaceURI) ? _namespaceURI : "";
    String prefix = StringUtils.hasText(ns) ? null : "";
    return prefix + ":" + ns + ":" + _name;
  }

  String get namespaceURI {
    return _namespaceURI;
  }

  String get name {
    return _name;
  }

  void set name(String value) {
    _name = value;
  }

  dynamic get value {
    return _value;
  }

  void set value(dynamic value) {
    _value = value;
  }

  bool get isStatic {
    return _isStatic;
  }

  void set isStatic(bool value) {
    _isStatic = value;
  }

  PropertyDefinition(String propertyName, dynamic propertyValue,
      [String ns = null, bool propertyIsStatic = false, bool lazy = false])
      : super() {
    _name = propertyName;
    _value = propertyValue;
    _namespaceURI = ns;
    _isStatic = propertyIsStatic;
    _isLazy = lazy;
  }

  dynamic clone() {
    PropertyDefinition prop = new PropertyDefinition(
        this.name, this.value, this.namespaceURI, this.isStatic, this.isLazy);
    prop.isSimple = this.isSimple;
    return prop;
  }

  String toString() {
    return "PropertyDefinition{name:\"" +
        _name +
        "\", namespaceURI:\"" +
        _namespaceURI +
        "\", value:" +
        _value.toString() +
        ", isStatic:" +
        _isStatic.toString() +
        ", isSimple:\"" +
        _isSimple.toString() +
        ", isLazy:\"" +
        _isLazy.toString() +
        "}";
  }
}
