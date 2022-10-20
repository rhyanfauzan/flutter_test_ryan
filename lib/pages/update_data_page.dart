import 'package:d_info/d_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_crud_mockapi/main.dart';

import '../data/barangservice.dart';
import '../model/create_barang_model.dart';
import '../model/update_barang_model.dart';

class UpdateData extends StatefulWidget {
  UpdateData(
      {Key? key,
      required this.barang_id,
      required this.barang_name,
      required this.barang_stok,
      required this.barang_terjual,
      required this.barang_jenis})
      : super(key: key);
  String barang_id;
  String barang_name;
  String barang_stok;
  String barang_terjual;
  String barang_jenis;

  @override
  State<UpdateData> createState() => _UpdateDataState(
      barang_id, barang_name, barang_stok, barang_terjual, barang_jenis);
}

class _UpdateDataState extends State<UpdateData> {
  _UpdateDataState(this.barang_id, this.barang_name, this.barang_stok,
      this.barang_terjual, this.barang_jenis);
  BarangService _createBarang = BarangService();

  String barang_id;
  String barang_name;
  String barang_stok;
  String barang_terjual;
  String barang_jenis;

  final nameController = TextEditingController();
  final stokController = TextEditingController();
  final terjualController = TextEditingController();
  final jenisController = TextEditingController();

  updateDataBarang() async {
    updateBarangModel? user = await _createBarang.updateDataBarang(
      barang_id,
      barang_name,
      barang_stok,
      barang_terjual,
      barang_jenis,
    );
    print('user: ${user}');
    if (user != null) {
      Future.delayed(const Duration(milliseconds: 500), () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => MyApp(),
            ),
          );
      });
    } else {
      DInfo.dialogError(context, 'Gagal mengubah data barang!');
      DInfo.closeDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Edit data'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Nama'),
                  controller: nameController,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Stok'),
                  controller: stokController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Terjual'),
                  controller: terjualController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Jenis'),
                  controller: jenisController,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          // Navigator.popAndPushNamed(context, 'home');
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => MyApp(),
                            ),
                          );
                        },
                        child: Text('Cancel')),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          barang_name = nameController.text;
                          barang_stok = stokController.text;
                          barang_terjual = terjualController.text;
                          barang_jenis = jenisController.text;
                          updateDataBarang();
                        },
                        child: Text('Submit'))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
