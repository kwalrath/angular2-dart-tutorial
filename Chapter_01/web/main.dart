// will become angular2.
import 'package:core/core.dart' show bootstrap, Component, Decorator, TemplateConfig, NgElement;

// for demos. remove for produciton, use transformer.
import 'package:reflection/reflection.dart' show reflector;
import 'package:reflection/reflection_capabilities.dart' show ReflectionCapabilities;

@Component(selector: 'hello-app', componentServices: const [
  GreetingService
], template: const TemplateConfig(
    inline: '''<div class=\"greeting\">{{greeting}} <span red>world</span>!</div>
             <button class=\"changeButton\" (click)=\"changeGreeting()\">change greeting</button>''',
    directives: const [RedDec]))
class HelloCmp {
  String greeting;
  HelloCmp(GreetingService service) {
    this.greeting = service.greeting;
  }
  changeGreeting() {
    this.greeting = 'howdy';
  }
}
@Decorator(selector: '[red]')
class RedDec {
  RedDec(NgElement el) {
    el.domElement.style.color = 'red';
  }
}
class GreetingService {
  String greeting;
  GreetingService() {
    this.greeting = 'hello';
  }
}
main() {
  reflector.reflectionCapabilities = new ReflectionCapabilities();
  bootstrap(HelloCmp);
}
