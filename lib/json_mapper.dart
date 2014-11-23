library json_mapper;

import 'dart:mirrors' as mirrors;

/**
 * Serializes the provided [obj] into a valid JSON [String].
 * [obj] The object to be serialized. 
 * 
 * Can accept a list, map, or any instance of a class. Will throw
 * a [ArgumentError] if the input is a scalar value, as it will not
 * produce valid JSON.
 */
dynamic serialize(Object obj) {
  if (obj == null) {
    return null;
  }
  if (_isPrimitiveType(obj)) { // entry value can only be object, map, or list.
    throw new ArgumentError('Cannot serialize a scalar value into a JSON representation.');
  }
  return _serialize(obj);
}

/**
 * Recursively serializes the provided [obj].
 * For internal use only.
 */
dynamic _serialize(Object obj) {
  if (obj == null) {
    return null;
  }
  if (_isPrimitiveType(obj)) {
    return obj;
  }
  
  if (obj is List) {
    List<Object> list = new List<Object>();
    for (var e in obj) {
      list.add(_serialize(e));
    }
    return list;
  }
  
  Map<String, Object> data = new Map<String, Object>();
  if (obj is Map) {
    // what if key is not string?
    for (var k in obj.keys) {
      data[k] = _serialize(obj[k]);
    }
    return data;
  }

  // serializes object fields and getters.
  mirrors.InstanceMirror im = mirrors.reflect(obj);
  mirrors.ClassMirror cm = im.type;
  
  while (cm.superclass != null) {
    cm.declarations.forEach((Symbol sym, dynamic dec) {
      if (dec is mirrors.VariableMirror) {
        if (_isSerializableVariable(dec)) {
          data[mirrors.MirrorSystem.getName(sym)] = _serialize(im.getField(dec.simpleName).reflectee);
        }
      } else if (dec is mirrors.MethodMirror) {
        if (_isSerializableGetter(dec)) {
          data[mirrors.MirrorSystem.getName(sym)] = _serialize(im.getField(dec.simpleName).reflectee);
        }
      }
    });
    cm = cm.superclass;
  }
  
  return data;
}

/**
 * Returns true if [obj] is a [num], [String], or [bool].
 */
bool _isPrimitiveType(Object obj) {
  return obj is num || obj is String || obj is bool;
}

/**
 * Returns true if the variable is a public instance variable.
 */
bool _isSerializableVariable(mirrors.VariableMirror vm) {
  return !vm.isStatic && !vm.isFinal && !vm.isPrivate;
}

/**
 * Returns true if the method is a public instance getter.
 */
bool _isSerializableGetter(mirrors.MethodMirror mm) {
  return mm.isGetter && !mm.isStatic && !mm.isPrivate;
}

