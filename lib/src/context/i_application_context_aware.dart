part of spring_dart;

abstract class IApplicationContextAware{

  IApplicationContext get applicationContext;
  void set applicationContext(IApplicationContext ctx);
  
}
