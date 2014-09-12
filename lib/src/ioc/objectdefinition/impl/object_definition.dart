part of spring_dart;

class ObjectDefinition extends IObjectDefinition {
  Type _clazz;
  String name;
  String _className;
  ObjectDefinitionScope scope;
  AutowireMode autoWireMode;
  bool isLazyInit = false;
  
  ObjectDefinition(this._className){
    
  }
  
  @override
  Type get clazz => _clazz;


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

  // TODO: implement isSingleton
  @override
  bool get isSingleton => scope == ObjectDefinitionScope.SINGLETON;

  // TODO: implement properties
  @override
  List<PropertyDefinition> get properties => null;

  @override
  void set clazz(Type value) {
    _clazz = value;
  }
}