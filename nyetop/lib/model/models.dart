class catatanApi {
  final String iD;
  final String nama;

  catatanApi({
    required this.nama,
    required this.iD,

  });

  factory catatanApi.fromJson(Map<String, dynamic> json, String id) {
    return catatanApi(
      iD: id,
      nama: json['username'],
    );
  }
}



class Gambar {
  final String id;
  final String image;

  Gambar({required this.id, required this.image});

  factory Gambar.fromJson(Map<String, dynamic> json) {
    return Gambar(
      id: json['id'],
      image: json['image'],
    );
  }
}