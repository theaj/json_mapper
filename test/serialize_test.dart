library serialize_test;

import 'dart:convert';

import 'package:unittest/unittest.dart' as unit;
import 'package:json_mapper/json_mapper.dart' as jmap;

class Organization {
  int id;
  String name;
  String motto;
  int yearFounded;
  
  int get companyAge {
    DateTime now = new DateTime.now();
    return now.year - yearFounded;
  }
  
  Organization(int this.id, String this.name, 
      String this.motto, int this.yearFounded);
}

void main() {
  
  unit.test('serialize organization object', () {
    Organization org = new Organization(1, 'Google', "Don't be evil!", 1998);
    Map<String, Object> json = jmap.serialize(org);
    
    unit.expect('${JSON.encode(json)}', '{"id":1,"name":"Google","motto":"Don\'t be evil!","yearFounded":1998,"companyAge":16}');
  });
  
}



