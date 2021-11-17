import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:one_way_hashing/src/repository/hash_repository.dart';

//Model Enkripsi
class Encryption with ChangeNotifier, DiagnosticableTreeMixin {
  String _encrypted = '';
  String _decrypted = '';
  String get encrypted => _encrypted;
  String get decrypted => _decrypted;

  //memanggil fungsi hashing pada hash repository
  crypto.Digest hash(String text) {
    final digest = HashRepository.hash(text);
    _encrypted = digest.toString();
    notifyListeners();
    return digest;
  }

  //Mencoba untuk mendecode hasil enkripsi dari bentuk bytes-nya
  void bytesToString(List<int> bytes) {
    _decrypted = String.fromCharCodes(bytes);
    notifyListeners();
  }
}
