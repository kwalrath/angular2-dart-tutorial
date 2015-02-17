import 'package:angular2/angular2.dart'; // will become angular[2]

// for demos. remove for production, which should use a transformer.
import 'package:angular2/src/reflection/reflection.dart' show reflector;
import 'package:angular2/src/reflection/reflection_capabilities.dart' show ReflectionCapabilities;

// @Component annotates the HelloCmp class as an Angular 2.0 component.
@Component(
    selector: 'hello-app'
)
@Template(
    inline: // in future, can use url: (with separate file) or put a template in the HTML file
'''
<h3>Hello {{name}}!</h3>
Name: <input type="text" on-change="nameChanged(\$event)">
<!-- on-change could instead be (change). -->
<!-- If this example were more complex, you'd use the impending form module/package. -->
''')
class HelloCmp {
  String name = "whoever";
  void nameChanged(event) { //XXX: would you ever want to use a type for event?
    name = event.target.value;
  }
}

main() {
  reflector.reflectionCapabilities = new ReflectionCapabilities();
  bootstrap(HelloCmp);
}