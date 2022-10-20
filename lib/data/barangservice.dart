import 'package:flutter_application_crud_mockapi/model/barang.dart';
import 'package:flutter_application_crud_mockapi/model/create_barang_model.dart';
import 'package:flutter_application_crud_mockapi/model/update_barang_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BarangService {
  // Get Token first
  String _baseUrl = 'https://flutter.apitest.zethansa.com/api';

  Future<BarangModel?> getBarang() async {
    final api = Uri.parse('${_baseUrl}/get-all-products.php');
    // final data = {"email": email, "password": password};

    http.Response response;
    response = await http.get(
      api,
    );
    if (response.statusCode == 200) {
      final resultbody = json.decode(response.body);
      print(response.statusCode);
      print('berhail get barang service');
      print(resultbody);

      // return body;
      return BarangModel.fromJson(resultbody);
    } else {
      print(response.statusCode);
      print('gagal get barang service');

      return null;
    }
  }

  // Create Barang
  Future<createBarangModel?> createDataBarang(
    String? nama_barang,
    String? stok_barang,
    String? terjual_barang,
    String? jenis_barang,
  ) async {
    final api = Uri.parse('${_baseUrl}/create.php');
    final data = {
      "nama_barang": nama_barang,
      "stok_barang": stok_barang,
      "terjual_barang": terjual_barang,
      "jenis_barang": jenis_barang
    };

    http.Response response;
    response = await http.post(
      api,
      body: data,
    );

    try {
      if (response.statusCode == 200) {
        final responseJson = jsonDecode(response.body);

        print('status code : ${response.statusCode}');
        print('responseJson: ${responseJson}');
        print('Berhasil create barang');
        print('nama_barang: ${nama_barang}');
        print('stok_barang: ${stok_barang}');
        print('terjual_barang: ${terjual_barang}');
        print('jenis_barang: ${jenis_barang}');
        print('responseJson : ${responseJson}');

        // return SetorSampah.fromJson(responseJson);
        return createBarangModel(
            nama_barang: nama_barang,
            stok_barang: stok_barang,
            terjual_barang: terjual_barang,
            jenis_barang: jenis_barang);
      } else {
        print('status code : ${response.statusCode}');
        print('nama_barang: ${nama_barang}');
        print('stok_barang: ${stok_barang}');
        print('terjual_barang: ${terjual_barang}');
        print('jenis_barang: ${jenis_barang}');
        print('gagal create barang');

        print(jenis_barang);
        print('responseJson : ${response.body}');

        return null;
      }
    } catch (e) {
      print(e.toString());
      // throw Exception('Some arbitrary error');
      return null;
    }
  }

  // Update Barang
  Future<updateBarangModel?> updateDataBarang(
    String? id_barang,
    String? nama_barang,
    String? stok_barang,
    String? terjual_barang,
    String? jenis_barang,
  ) async {
    final api = Uri.parse('${_baseUrl}/update-product.php?id=${id_barang}');
    final data = {
      "nama_barang": nama_barang,
      "stok_barang": stok_barang,
      "terjual_barang": terjual_barang,
      "jenis_barang": jenis_barang
    };

    http.Response response;
    response = await http.put(
      api,
      body: data,
    );

    try {
      if (response.statusCode == 200) {
        final responseJson = jsonDecode(response.body);

        print('status code : ${response.statusCode}');
        print('responseJson: ${responseJson}');
        print('Berhasil update barang');
        print('id_barang: ${id_barang}');
        print('nama_barang: ${nama_barang}');
        print('stok_barang: ${stok_barang}');
        print('terjual_barang: ${terjual_barang}');
        print('jenis_barang: ${jenis_barang}');
        print('responseJson : ${responseJson}');

        // return SetorSampah.fromJson(responseJson);
        return updateBarangModel(
            nama_barang: nama_barang,
            stok_barang: stok_barang,
            terjual_barang: terjual_barang,
            jenis_barang: jenis_barang);
      } else {
        print('status code : ${response.statusCode}');
        print('nama_barang: ${nama_barang}');
        print('stok_barang: ${stok_barang}');
        print('terjual_barang: ${terjual_barang}');
        print('jenis_barang: ${jenis_barang}');
        print('gagal update barang');
        print('responseJson : ${response.body}');

        return null;
      }
    } catch (e) {
      print(e.toString());
      // throw Exception('Some arbitrary error');
      return null;
    }
  }
}
