import 'dart:convert';

import 'package:flutter_application_crud_mockapi/model/barang.dart';
import 'package:http/http.dart' as http;
import '../model/person.dart';

class Repository {
  // String _baseUrl = 'http://6308255046372013f576f9b5.mockapi.io/person';
  String _baseUrl = 'https://flutter.apitest.zethansa.com/api';

  Future getData() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        final body = json.decode(response.body);

        print('berhasil get');
        print(response.body);
        Iterable it = jsonDecode(response.body);
        // List<Listbarang> barangs =
        //     it.map((e) => Listbarang.fromJson(e)).toList();
        return body;
      }
    } catch (e) {
      print('gagal get');

      print(e.toString());
    }
  }

  Future<Listbarangdaftar?> createData(
    String nama_barang,
    String stok_barang,
    String terjual_barang,
    String jenis_barang,
  ) async {
    try {
      final api = Uri.parse('${_baseUrl}/create.php');
      final data = {
        'nama_barang': nama_barang,
        'stok_barang': stok_barang,
        'terjual_barang': terjual_barang,
        'jenis_barang': jenis_barang,
      };

      http.Response response;
      response = await http.post(api, body: data);

      if (response.statusCode == 200) {
        print('berhasil menambahkan data');
        // return true;
        return Listbarangdaftar(
          nama_barang: nama_barang,
          jenis_barang: jenis_barang,
          stok_barang: stok_barang,
          terjual_barang: terjual_barang,
        );
      } else {
        print('gagal menambahkan data');
        return null;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<Listbarangdaftar?> updateData(
    String id,
    String nama_barang,
    String stok_barang,
    String terjual_barang,
    String jenis_barang,
  ) async {
    try {
      final response = await http
          .put(Uri.parse('${_baseUrl}/update-product.php?id=${id}'), body: {
        'id': id,
        'nama_barang': nama_barang,
        'stok_barang': stok_barang,
        'terjual_barang': terjual_barang,
        'jenis_barang': jenis_barang,
      });
      if (response.statusCode == 200) {
        print('berhasil merubah data');
        return Listbarangdaftar(
          nama_barang: nama_barang,
          jenis_barang: jenis_barang,
          stok_barang: stok_barang,
          terjual_barang: terjual_barang,
        );
      } else {
        print('gagal merubah data');
        return null;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future deleteData(String id) async {
    try {
      final response = await http
          .delete(Uri.parse('${_baseUrl}/delete-product.php?id=${id}'));
      if (response.statusCode == 200) {
        print('berhasil delete!');
        return true;
      } else {
        print('gagal delete!');
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
