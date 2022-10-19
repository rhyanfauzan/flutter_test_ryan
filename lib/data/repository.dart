import 'dart:convert';

import 'package:flutter_application_crud_mockapi/model/barang.dart';
import 'package:http/http.dart' as http;
import '../model/person.dart';

class Repository {
  // String _baseUrl = 'http://6308255046372013f576f9b5.mockapi.io/person';
  String _baseUrl = 'https://634e8f984af5fdff3a6052b8.mockapi.io/api/barang';

  Future getData() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        print('berhasil get');
        print(response.body);
        Iterable it = jsonDecode(response.body);
        List<Barang> barangs = it.map((e) => Barang.fromJson(e)).toList();
        return barangs;
      }
    } catch (e) {
      print('gagal get');

      print(e.toString());
    }
  }

  Future createData(
    final String name,
    final String stok,
    final String terjual,
    final String jenis,
  ) async {
    try {
      final response = await http.post(Uri.parse(_baseUrl), body: {
        'name': name,
        'stok': stok,
        'terjual': terjual,
        'jenis': jenis,
      });

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future updateData(
    String id,
    final String name,
    final String stok,
    final String terjual,
    final String jenis,
  ) async {
    try {
      final response = await http.put(Uri.parse('${_baseUrl}/${id}'), body: {
        'name': name,
        'stok': stok,
        'terjual': terjual,
        'jenis': jenis,
      });
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future deleteData(String id) async {
    try {
      final response = await http.delete(Uri.parse('${_baseUrl}/${id}'));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
