part of acanvas_spring;

abstract class IApplicationContextAware {
  IApplicationContext get applicationContext;
  void set applicationContext(IApplicationContext ctx);
}
