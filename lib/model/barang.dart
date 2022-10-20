class BarangModel {
  BarangModel({
    required this.status,
    required this.listbarang,
  });

  bool status;
  List<Listbarang> listbarang;

  factory BarangModel.fromJson(Map<String, dynamic> json) => BarangModel(
        status: json["status"],
        listbarang: List<Listbarang>.from(
            json["listbarang"].map((x) => Listbarang.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "listbarang": List<dynamic>.from(listbarang.map((x) => x.toJson())),
      };
}

class Listbarang {
  Listbarang({
    required this.id,
    required this.nama_barang,
    required this.stok_barang,
    required this.terjual_barang,
    required this.jenis_barang,
    required this.published,
    required this.tanggal_barang,
  });

  String id;
  String nama_barang;
  String stok_barang;
  String terjual_barang;
  String jenis_barang;
  String published;
  DateTime? tanggal_barang;

  factory Listbarang.fromJson(Map<String, dynamic> json) => Listbarang(
        id: json["id"],
        nama_barang: json["nama_barang"],
        stok_barang: json["stok_barang"],
        terjual_barang: json["terjual_barang"],
        jenis_barang: json["jenis_barang"],
        published: json["published"],
        tanggal_barang: DateTime.parse(json["tanggal_barang"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_barang": nama_barang,
        "stok_barang": stok_barang,
        "terjual_barang": terjual_barang,
        "jenis_barang": jenis_barang,
        "published": published,
        "tanggal_barang": tanggal_barang?.toIso8601String(),
      };
}

class Listbarangdaftar {
  Listbarangdaftar({
    required this.nama_barang,
    required this.stok_barang,
    required this.terjual_barang,
    required this.jenis_barang,
  });

  String nama_barang;
  String stok_barang;
  String terjual_barang;
  String jenis_barang;
}
