part of rockdot_spring;

class ObjectDefinition extends IObjectDefinition {
  Type _clazz;
  Function _func;
  String name;
  String _className;
  ObjectDefinitionScope scope;
  AutowireMode autoWireMode;
  bool isLazyInit = false;

  ObjectDefinition(this._className) {}

  @override
  Type get clazz => _clazz;

  @override
  Function get func => _func;

  @override
  String get className => _className;

  @override
  void set className(String value) {
    _className = value;
  }

  @override
  void set constructorArguments(List value) {
    // TODO: implement constructorArguments
  }

  // TODO: implement constructorArguments
  @override
  List get constructorArguments => [];

  // TODO: implement isAbstract
  @override
  bool get isAbstract => false;

  @override
  void set isAbstract(bool value) {
    // TODO: implement isAbstract
  }

  @override
  void set isInterface(bool value) {
    // TODO: implement isInterface
  }

  // TODO: implement isInterface
  @override
  bool get isInterface => false;

  @override
  bool get isSingleton => scope == ObjectDefinitionScope.SINGLETON;

  List<PropertyDefinition> get properties => null;

  @override
  void set clazz(Type value) {
    _clazz = value;
  }

  @override
  void set func(Function value) {
    _func = value;
  }
}
