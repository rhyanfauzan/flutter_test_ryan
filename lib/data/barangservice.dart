import 'package:flutter_application_crud_mockapi/model/barang.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BarangService {
  // Get Token first
  String _baseUrl = 'https://634e8f984af5fdff3a6052b8.mockapi.io/api/barang';

  Future<Barang?> getBarang() async {
    final api = Uri.parse('${_baseUrl}');
    // final data = {"email": email, "password": password};

    http.Response response;
    response = await http.post(
      api,
    );
    if (response.statusCode == 201) {
      final body = json.decode(response.body);

      return Barang.fromJson(body);
      // return Barang(createdAt: createdAt, jenis: jenis, name: name, stok: stok, terjual: terjual, id: id, );
    } else {
      print(response.statusCode);
      print('gagal get barang');

      return null;
    }
  }
}
