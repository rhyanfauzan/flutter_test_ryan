import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_crud_mockapi/data/barangservice.dart';
import 'package:flutter_application_crud_mockapi/data/repository.dart';
import 'package:flutter_application_crud_mockapi/model/barang.dart';
import 'package:flutter_application_crud_mockapi/pages/create_data_page.dart';
import 'package:flutter_application_crud_mockapi/pages/update_data_page.dart';

void main() {
  runApp(MyApp());
  HttpOverrides.global = MyHttpOverrides();
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      // routes: {
      //   'home': (context) => HomePage(),
      //   'create': (context) => CreateData(),
      //   // 'update': (context) => UpdateData(),
      // },
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Barang> listBarang = [];
  Repository repository = Repository();
  late Future<Barang?> futureBarang;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  getData() async {
    listBarang = await repository.getData();
    print('load from API');
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
    futureBarang = BarangService().getBarang();
  }

  Future<void> _refreshBarang() async {
    final newlistBarang = await repository.getData();
    futureBarang = BarangService().getBarang();

    setState(() {
      listBarang = newlistBarang;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('List Barang'),
      ),
      body: FutureBuilder<Barang?>(
          future: futureBarang,
          builder: (context, snapshot) {
            final futureBarang = snapshot.data;

            if (snapshot.hasData) {
              print('snapshot hasData');
              return RefreshIndicator(
                onRefresh: _refreshBarang,
                child: ListView.builder(
                    itemCount: listBarang.length,
                    itemBuilder: (context, index) {
                      Barang barang = listBarang[index];
                      return InkWell(
                        onLongPress: () {
                          // Navigator.pushNamed(
                          //     context, UpdateData().toString(), arguments: [
                          //   barang.id,
                          //   barang.name,
                          //   barang.stok,
                          //   barang.terjual,
                          //   barang.jenis
                          // ]);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => UpdateData(
                                  barang_id: barang.id,
                                  barang_name: barang.name,
                                  barang_stok: barang.stok,
                                  barang_terjual: barang.terjual,
                                  barang_jenis: barang.jenis),
                            ),
                          );
                        },
                        child: Dismissible(
                          key: Key(barang.id),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Icon(Icons.delete),
                          ),
                          confirmDismiss: (direction) {
                            return showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Delete Data'),
                                    content:
                                        Text('Are you sure to delete data?'),
                                    actions: [
                                      TextButton(
                                          onPressed: () async {
                                            bool response = await repository
                                                .deleteData(barang.id);
                                            if (response) {
                                              Navigator.pop(context, true);
                                            } else {
                                              Navigator.pop(context, false);
                                            }
                                          },
                                          child: Text('Yes')),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context, false);
                                          },
                                          child: Text('No'))
                                    ],
                                  );
                                });
                          },
                          // child: ListTile(
                          //   leading: Container(
                          //     width: 60,
                          //     height: 60,
                          //     decoration: BoxDecoration(
                          //         shape: BoxShape.circle,
                          //         image: DecorationImage(
                          //             image: AssetImage('assets/person1.png'),
                          //             fit: BoxFit.cover)),
                          //   ),
                          //   title: Text('${barang.name} ${barang.stok}'),
                          //   subtitle: Text('Terjual: ${barang.terjual}'),
                          // ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 4),
                            child: Container(
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Image.asset(
                                                'assets/bag.jpg',
                                                width: 60,
                                                height: 60,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${barang.name}',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Text('Stok : ${barang.stok}',
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400))
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text('${barang.jenis}',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700)),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            'Terjual : ${barang.terjual}',
                                            style: TextStyle(
                                                color: Colors.green.shade800,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )),
                          ),
                        ),
                      );
                    }),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      // tanpa future builder
      // body: RefreshIndicator(
      //   onRefresh: _refreshBarang,
      //   child: ListView.builder(
      //       itemCount: listBarang.length,
      //       itemBuilder: (context, index) {
      //         Barang barang = listBarang[index];
      //         return InkWell(
      //           onLongPress: () {
      //             // Navigator.pushNamed(
      //             //     context, UpdateData().toString(), arguments: [
      //             //   barang.id,
      //             //   barang.name,
      //             //   barang.stok,
      //             //   barang.terjual,
      //             //   barang.jenis
      //             // ]);
      //             Navigator.of(context).push(
      //               MaterialPageRoute(
      //                 builder: (context) => UpdateData(
      //                     barang_id: barang.id,
      //                     barang_name: barang.name,
      //                     barang_stok: barang.stok,
      //                     barang_terjual: barang.terjual,
      //                     barang_jenis: barang.jenis),
      //               ),
      //             );
      //           },
      //           child: Dismissible(
      //             key: Key(barang.id),
      //             direction: DismissDirection.endToStart,
      //             background: Container(
      //               alignment: Alignment.centerRight,
      //               padding: EdgeInsets.symmetric(horizontal: 30),
      //               child: Icon(Icons.delete),
      //             ),
      //             confirmDismiss: (direction) {
      //               return showDialog(
      //                   context: context,
      //                   builder: (context) {
      //                     return AlertDialog(
      //                       title: Text('Delete Data'),
      //                       content: Text('Are you sure to delete data?'),
      //                       actions: [
      //                         TextButton(
      //                             onPressed: () async {
      //                               bool response =
      //                                   await repository.deleteData(barang.id);
      //                               if (response) {
      //                                 Navigator.pop(context, true);
      //                               } else {
      //                                 Navigator.pop(context, false);
      //                               }
      //                             },
      //                             child: Text('Yes')),
      //                         TextButton(
      //                             onPressed: () {
      //                               Navigator.pop(context, false);
      //                             },
      //                             child: Text('No'))
      //                       ],
      //                     );
      //                   });
      //             },
      //             // child: ListTile(
      //             //   leading: Container(
      //             //     width: 60,
      //             //     height: 60,
      //             //     decoration: BoxDecoration(
      //             //         shape: BoxShape.circle,
      //             //         image: DecorationImage(
      //             //             image: AssetImage('assets/person1.png'),
      //             //             fit: BoxFit.cover)),
      //             //   ),
      //             //   title: Text('${barang.name} ${barang.stok}'),
      //             //   subtitle: Text('Terjual: ${barang.terjual}'),
      //             // ),
      //             child: Padding(
      //               padding:
      //                   const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      //               child: Container(
      //                   color: Colors.white,
      //                   child: Padding(
      //                     padding: const EdgeInsets.all(8.0),
      //                     child: Row(
      //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                       children: [
      //                         Column(
      //                           children: [
      //                             Row(
      //                               children: [
      //                                 Image.asset(
      //                                   'assets/bag.jpg',
      //                                   width: 60,
      //                                   height: 60,
      //                                 ),
      //                                 SizedBox(
      //                                   width: 10,
      //                                 ),
      //                                 Column(
      //                                   crossAxisAlignment:
      //                                       CrossAxisAlignment.start,
      //                                   children: [
      //                                     Text(
      //                                       '${barang.name}',
      //                                       style: TextStyle(
      //                                           fontSize: 16,
      //                                           fontWeight: FontWeight.w700),
      //                                     ),
      //                                     SizedBox(
      //                                       height: 8,
      //                                     ),
      //                                     Text('Stok : ${barang.stok}',
      //                                         style: TextStyle(
      //                                             color: Colors.grey,
      //                                             fontSize: 12,
      //                                             fontWeight: FontWeight.w400))
      //                                   ],
      //                                 )
      //                               ],
      //                             ),
      //                           ],
      //                         ),
      //                         Column(
      //                           crossAxisAlignment: CrossAxisAlignment.end,
      //                           children: [
      //                             Text('${barang.jenis}',
      //                                 style: TextStyle(
      //                                     color: Colors.grey,
      //                                     fontSize: 14,
      //                                     fontWeight: FontWeight.w700)),
      //                             SizedBox(
      //                               height: 8,
      //                             ),
      //                             Text(
      //                               'Terjual : ${barang.terjual}',
      //                               style: TextStyle(
      //                                   color: Colors.green.shade800,
      //                                   fontSize: 14,
      //                                   fontWeight: FontWeight.w400),
      //                             ),
      //                           ],
      //                         )
      //                       ],
      //                     ),
      //                   )),
      //             ),
      //           ),
      //         );
      //       }),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.pushNamed(context, 'create');
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CreateData(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
