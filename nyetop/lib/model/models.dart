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



class Image {
  final String id;
  final String image;


  Image({required this.id, required this.image});

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      id: json['nim'],
      image: json['nama'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'id' : id,
      'image' : image,
    };
  }
}