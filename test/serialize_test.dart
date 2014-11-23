library serialize_test;

import 'dart:convert';

import 'package:unittest/unittest.dart' as unit;
import 'package:json_mapper/json_mapper.dart' as jmap;

class Entity {
  int id;
}

class Organization extends Entity {
  String name;
  String motto;
  int yearFounded;
  List<String> founders = ['Larry Page', 'Sergey Brin'];
  Map<String, String> headquarters = {
    'city': 'Mountain View',
    'state': 'California',
    'country': 'USA'
  };
  
  int get companyAge {
    DateTime now = new DateTime.now();
    return now.year - yearFounded;
  }
  
  Organization(int id, String this.name, 
      String this.motto, int this.yearFounded) {
    super.id = id;
  }
}

const String jsonString = '{"name":"Google","motto":"Don\'t be evil!","yearFounded":1998,"founders":["Larry Page","Sergey Brin"],"headquarters":{"city":"Mountain View","state":"California","country":"USA"},"companyAge":16,"id":1}';

void main() {
  
  unit.test('serialize organization object', () {
    Organization org = new Organization(1, 'Google', "Don't be evil!", 1998);
    Map<String, Object> data = jmap.serialize(org);

    unit.expect(data.length, 7);
    unit.expect(data['id'], 1);
    unit.expect(data['name'], 'Google');
    unit.expect(data['motto'], "Don't be evil!");
    unit.expect(data['yearFounded'], 1998);
    unit.expect(data['founders'], unit.isList);
    unit.expect(data['headquarters'], unit.isMap);
    unit.expect(data['companyAge'], 16);
    unit.expect('${JSON.encode(data)}', jsonString);
  });
  
  unit.test('scalar value should fail', () {
    unit.expect(() => jmap.serialize("scalar value"), unit.throwsArgumentError);
  });
  
}



