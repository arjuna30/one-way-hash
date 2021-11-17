import 'dart:convert';

import 'package:crypto/crypto.dart' as crypto;

//Repository Hash
class HashRepository {
  //fungsi hashing ke SHA256
  static crypto.Digest hash(String text) {
    final bytes = utf8.encode(text);
    return crypto.sha256.convert(bytes);
  }
}
