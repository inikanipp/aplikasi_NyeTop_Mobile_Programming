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