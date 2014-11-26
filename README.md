# JSON Mapper
A Simple lightweight JSON mapping utility.

[![Build Status](https://drone.io/github.com/TheAJ/json_mapper/status.png)](https://drone.io/github.com/TheAJ/json_mapper/latest)

#### How do I use it?

Download the dependency through Dart Pub Package manager.
Add the following line to your pubspec.yaml dependencies:

```
json_mapper: "any"
```

Once you're done, get the package using `pub get`, then import it:

```
import 'package:json_mapper/json_mapper.dart' as jmap;
```



**To serialize an object:**

Use the `serialize(Object obj)` function. It takes any Dart object.

```dart
import 'package:json_mapper/json_mapper.dart' as jmap;

class Contact {
  int name;
  int mobile;
  int email;
}

void main() {
  Contact bob = new Contact()
    ..name = 'Bob Smith'
    ..mobile = '4161234567'
    ..email = 'bob.smith@example.com'
    
  String json = jmap.serialize(bob);
  print(json);
}
```

The output should be similar to:

Use the `deserialize(String json, Type type)` function. It takes a string, and any Dart Type, even your own.

```text
{"name":"Bob Smith","mobile":"4161234567","email":"bob.smith@example.com"}
```

**To deserialize a string back to an object**
```dart
...

void main() {
  String json = '{"name":"Bob Smith","mobile":"4161234567","email":"bob.smith@example.com"}';
  Contact bobFromJson = jmap.deserialize(json, Contact);
}
```

