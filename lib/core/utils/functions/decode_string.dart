import 'dart:convert';

String decodeString(String encodedString) {
  return utf8.decode(base64Decode(encodedString));
}
