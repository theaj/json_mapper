library serialize_test;

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
  
  Organization.from(int id, String this.name, 
      String this.motto, int this.yearFounded) {
    super.id = id;
  }
  
  Organization();
}

const String jsonString = '{"name":"Google","motto":"Don\'t be evil!","yearFounded":1998,"founders":["Larry Page","Sergey Brin"],"headquarters":{"city":"Mountain View","state":"California","country":"USA"},"id":1}';

void main() {
  
  unit.test('serialize organization object', () {
    Organization org = new Organization.from(1, 'Google', "Don't be evil!", 1998);
    unit.expect(jmap.serialize(org), jsonString);
  });
  
  unit.test('serialize scalar value should fail', () {
    unit.expect(() => jmap.serialize("scalar value"), unit.throwsArgumentError);
  });
  
  unit.test('deserialize json to object', () {
    Organization org = jmap.deserialize(jsonString, Organization);
    unit.expect(org.id, 1);
    unit.expect(org.name, 'Google');
    unit.expect(org.yearFounded, 1998);
    unit.expect(org.founders, ['Larry Page', 'Sergey Brin']);
    unit.expect(org.headquarters, {
      'city': 'Mountain View',
      'state': 'California',
      'country': 'USA'
    });
  });
}



