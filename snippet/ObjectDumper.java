package org.example.utils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.lang.reflect.Array;
import java.lang.reflect.Field;
import java.util.Collection;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

public class ObjectDumper {
  private static final Logger LOGGER = LoggerFactory.getLogger(ObjectDumper.class.getName());
  private static final Set<Object> VISITED_OBJECTS = new HashSet<>();
  private static final int MAX_DEPTH = 10; // Prevent infinite recursion

  public static void dumpObject(Object obj) {
    StringBuilder output = new StringBuilder();
    dumpObject(obj, 0, output, 0);
    VISITED_OBJECTS.clear();
    LOGGER.info("Object Dump:\n{}", output.toString());
  }

  private static void dumpObject(Object obj, int indent, StringBuilder output, int depth) {
    if (obj == null || VISITED_OBJECTS.contains(obj) || depth > MAX_DEPTH) {
      return;
    }

    VISITED_OBJECTS.add(obj);

    if (obj.getClass().isArray()) {
      dumpArray(obj, indent, output, depth);
    }
    else if (obj instanceof Collection) {
      dumpCollection((Collection<?>) obj, indent, output, depth);
    }
    else if (obj instanceof Map) {
      dumpMap((Map<?, ?>) obj, indent, output, depth);
    }
    else {
      dumpRegularObject(obj, indent, output, depth);
    }
  }

  private static void dumpRegularObject(Object obj, int indent, StringBuilder output, int depth) {
    Class<?> clazz = obj.getClass();
    String indentation = createIndentation(indent);

    output.append(String.format("%sClass: %s\n", indentation, clazz.getName()));

    for (Field field : clazz.getDeclaredFields()) {
      field.setAccessible(true);
      String fieldName = field.getName();
      Object fieldValue;

      try {
        fieldValue = field.get(obj);
      }
      catch (IllegalAccessException e) {
        output.append(String.format("%sUnable to access field: %s\n", indentation, fieldName));
        continue;
      }

      output.append(String.format("%sField: %s = %s\n", indentation, fieldName, fieldValue));

      if (fieldValue != null && !field.getType().isPrimitive() && !field.getType().getName().startsWith("java.lang")) {
        dumpObject(fieldValue, indent + 2, output, depth + 1);
      }
    }
  }

  private static void dumpArray(Object array, int indent, StringBuilder output, int depth) {
    String indentation = createIndentation(indent);
    int length = Array.getLength(array);
    output.append(
        String.format("%sArray of %s (length: %d)\n", indentation, array.getClass().getComponentType().getSimpleName(),
            length));

    for (int i = 0; i < length; i++) {
      Object element = Array.get(array, i);
      output.append(String.format("%s  [%d] = %s\n", indentation, i, element));
      if (element != null && !element.getClass().isPrimitive() && !element.getClass().getName()
          .startsWith("java.lang")) {
        dumpObject(element, indent + 4, output, depth + 1);
      }
    }
  }

  private static void dumpCollection(Collection<?> collection, int indent, StringBuilder output, int depth) {
    String indentation = createIndentation(indent);
    output.append(
        String.format("%sCollection of type %s (size: %d)\n", indentation, collection.getClass().getSimpleName(),
            collection.size()));

    int index = 0;
    for (Object element : collection) {
      output.append(String.format("%s  [%d] = %s\n", indentation, index++, element));
      if (element != null && !element.getClass().isPrimitive() && !element.getClass().getName()
          .startsWith("java.lang")) {
        dumpObject(element, indent + 4, output, depth + 1);
      }
    }
  }

  private static void dumpMap(Map<?, ?> map, int indent, StringBuilder output, int depth) {
    String indentation = createIndentation(indent);
    output.append(
        String.format("%sMap of type %s (size: %d)\n", indentation, map.getClass().getSimpleName(), map.size()));

    for (Map.Entry<?, ?> entry : map.entrySet()) {
      output.append(String.format("%s  Key: %s\n", indentation, entry.getKey()));
      output.append(String.format("%s  Value: %s\n", indentation, entry.getValue()));
      if (entry.getValue() != null && !entry.getValue().getClass().isPrimitive() && !entry.getValue().getClass()
          .getName().startsWith("java.lang")) {
        dumpObject(entry.getValue(), indent + 4, output, depth + 1);
      }
    }
  }

  private static String createIndentation(int indent) {
    StringBuilder sb = new StringBuilder(indent);
    for (int i = 0; i < indent; i++) {
      sb.append(' ');
    }
    return sb.toString();
  }
}
