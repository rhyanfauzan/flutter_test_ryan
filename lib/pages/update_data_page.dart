import 'package:flutter/material.dart';
import 'package:flutter_application_crud_mockapi/data/repository.dart';
import 'package:flutter_application_crud_mockapi/main.dart';

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

  final nameController = TextEditingController();
  final stokController = TextEditingController();
  final terjualController = TextEditingController();
  final jenisController = TextEditingController();
  Repository repository = Repository();
  String barang_id;
  String barang_name;
  String barang_stok;
  String barang_terjual;
  String barang_jenis;

  @override
  Widget build(BuildContext context) {
    // final args = ModalRoute.of(context)?.settings.arguments as List<String>;
    if (barang_name.isNotEmpty) {
      nameController.text = barang_name;
    }
    if (barang_stok.isNotEmpty) {
      stokController.text = barang_stok;
    }
    if (barang_terjual.isNotEmpty) {
      terjualController.text = barang_terjual;
    }
    if (barang_jenis.isNotEmpty) {
      jenisController.text = barang_jenis;
    }

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
                TextField(
                  decoration: InputDecoration(hintText: 'Nama'),
                  controller: nameController,
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: InputDecoration(hintText: 'Stok'),
                  controller: stokController,
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: InputDecoration(hintText: 'Terjual'),
                  controller: terjualController,
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
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
                        onPressed: () async {
                          bool response = await repository.updateData(
                              barang_id,
                              nameController.text,
                              stokController.text,
                              terjualController.text,
                              jenisController.text);

                          if (response) {
                            // Navigator.popAndPushNamed(context, 'home');
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => MyApp(),
                              ),
                            );
                            print('berhasil update');
                          } else {
                            throw Exception('Gagal update data');
                          }
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
