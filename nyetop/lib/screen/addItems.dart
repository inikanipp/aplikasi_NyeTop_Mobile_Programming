import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nyetop/widget/addFile.dart';
import 'package:nyetop/widget/field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class addItems extends StatefulWidget {
  final String idUser;
  const addItems({super.key,
  required this.idUser
  });

  @override
  State<addItems> createState() => _addItemsState();
}

class _addItemsState extends State<addItems> {
  final _formKey = GlobalKey<FormState>();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  String? namaItem;
  String? hargaItem;
  String? deskripsiItem;

  void _resetForm() {
    _formKey.currentState?.reset();
    setState(() {
      namaItem = null;
      hargaItem = null;
      deskripsiItem = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addFile(
                navigation: (context) =>
                    Navigator.push(context, MaterialPageRoute(builder: (context) => addItems(idUser: widget.idUser,))),
              ),
              SizedBox(height: 16),
              field(
                line: 1,
                name: "Nama Item",
                onSaved: (value) => namaItem = value,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Nama item wajib diisi' : null,
              ),
              SizedBox(height: 16),
              field(
                line: 1,
                name: "Harga",
                onSaved: (value) => hargaItem = value,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Harga wajib diisi' : null,
              ),
              SizedBox(height: 16),
              field(
                line: 4,
                name: "Deskripsi",
                onSaved: (value) => deskripsiItem = value,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Deskripsi wajib diisi' : null,
              ),
              Spacer(),
              SizedBox(
                width: double.maxFinite,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF060A56),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      await firestore.collection('laptops').doc(widget.idUser).set({
                        'nama': namaItem,
                        'jenis': deskripsiItem,
                        'harga': deskripsiItem,
                        'lokasi': deskripsiItem,
                        'deskripsi': deskripsiItem,
                      });

                      print("Nama Item: $namaItem");
                      print("Harga: $hargaItem");
                      print("Deskripsi: $deskripsiItem");

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Data berhasil disubmit!")),
                      );
                    }
                  },
                  child: Text(
                    "Submit",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: double.maxFinite,
                height: 60,
                child: Center(
                  child: InkWell(
                    onTap: _resetForm,
                    child: Text(
                      "Reset",
                      style: GoogleFonts.poppins(
                        color: Color(0xFF060A56),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
