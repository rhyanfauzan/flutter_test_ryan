class Barang {
  final String createdAt;
  final String name;
  final String stok;
  final String terjual;
  final String jenis;
  final String id;

  const Barang({
    required this.createdAt,
    required this.name,
    required this.stok,
    required this.terjual,
    required this.jenis,
    required this.id,
  });

  factory Barang.fromJson(Map<String, dynamic> json) {
    return Barang(
      createdAt: json['createdAt'],
      name: json['name'],
      stok: json['stok'],
      terjual: json['terjual'],
      jenis: json['jenis'],
      id: json['id'],
    );
  }
}
