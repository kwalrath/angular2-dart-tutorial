// Angular 2.0 supports 3 basic types of directives:
// - Component - the basic building blocks of Angular 2.0 apps. Backed by
//   ShadowDom.(http://www.html5rocks.com/en/tutorials/webcomponents/shadowdom/)
// - Decorator - add behavior to existing elements.
// - Template - allow for stamping out of a html template (not in this demo).

import 'package:core/core.dart'; // will become angular[2]

// for demos. remove for production, which should use a transformer.
import 'package:reflection/reflection.dart' show reflector;
import 'package:reflection/reflection_capabilities.dart' show ReflectionCapabilities;

// @Component annotates the HelloCmp class as an Angular 2.0 component.
@Component(
    // The Selector prop tells Angular on which elements to instantiate this
    // class. The syntax supported is a basic subset of CSS selectors, for example
    // 'element', '[attr]', [attr=foo]', etc.
    selector: 'hello-app',
    
    // These are services that would be created if a class in the component's
    // template tries to inject them.
    componentServices: const [GreetingService],
    
    // The template for the component.
    // Expressions in the template (like {{greeting}}) are evaluated in the
    // context of the HelloCmp class below.
    template: const TemplateConfig(
        inline:
'''<div class=\"greeting\">{{greeting}} <span red>world</span>!</div>
<button class=\"changeButton\" (click)=\"changeGreeting()\">change greeting</button>''',

        // All directives used in the template need to be specified. This allows for
        // modularity (RedDec can only be used in this template)
        // and better tooling (the template can be invalidated if the attribute is
        // misspelled).
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

// Decorators are light-weight. They don't allow for templates, or new
// expression contexts (use @Component or @Template for those needs).
@Decorator(selector: '[red]')
class RedDec {
  RedDec(NgElement el) {
    el.domElement.style.color = 'red';
  }
}

// A service used by the HelloCmp component.
class GreetingService {
  String greeting;
  GreetingService() {
    this.greeting = 'hello';
  }
}

main() {
  reflector.reflectionCapabilities = new ReflectionCapabilities();
  
  // Bootstrapping only requires specifying a root component.
  // The boundary between the Angular application and the rest of the page is
  // the shadowDom of this root component.
  // The selector of the component passed in is used to find where to insert the
  // application.
  // You can use the light dom of the <hello-app> tag as temporary content (for
  // example 'Loading...') before the application is ready.
  bootstrap(HelloCmp);
}