import 'package:d_info/d_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_crud_mockapi/data/barangservice.dart';
import 'package:flutter_application_crud_mockapi/data/repository.dart';
import 'package:flutter_application_crud_mockapi/main.dart';
import 'package:flutter_application_crud_mockapi/model/create_barang_model.dart';

class CreateData extends StatefulWidget {
  const CreateData({Key? key}) : super(key: key);

  @override
  State<CreateData> createState() => _CreateDataState();
}

class _CreateDataState extends State<CreateData> {
  final nameController = TextEditingController();
  final stokController = TextEditingController();
  final terjualController = TextEditingController();
  final jenisController = TextEditingController();
  Repository repository = Repository();
  BarangService _createBarang = BarangService();

  createDataBarang() async {
    createBarangModel? user = await _createBarang.createDataBarang(
      nameController.text,
      stokController.text,
      terjualController.text,
      jenisController.text,
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
      DInfo.dialogError(context, 'Gagal membuat data barang!');
      DInfo.closeDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Tambah data'),
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
                        onPressed: () => createDataBarang(),
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
