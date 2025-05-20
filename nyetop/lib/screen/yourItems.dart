import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nyetop/widget/addFile.dart';
import 'package:nyetop/widget/cardHorizontal.dart';
import 'addItems.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class yourItems extends StatefulWidget {
  final String idUser;
  const yourItems({super.key,
    required this.idUser
  
  });

  @override
  State<yourItems> createState() => _yourItemsState();
}

class _yourItemsState extends State<yourItems> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;



  Future<List<DocumentSnapshot>> getLaptopData() async {
    QuerySnapshot snapshot = await _firestore
        .collection('laptops') // ganti dengan nama koleksimu
        .where('user', isEqualTo: widget.idUser)
        .get();

    return snapshot.docs;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Container(
        // color: Colors.red,
        height: double.maxFinite,
        width: double.maxFinite,
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addFile( navigation: (context) => Navigator.push(context, MaterialPageRoute(builder: (context)=> addItems(idUser: widget.idUser,) )),

            ),
            SizedBox(height: 16),
            Text("Your Items",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: Container(
                // color: Colors.red,
                child: FutureBuilder<List<DocumentSnapshot>>(
                  future: getLaptopData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: Image.asset("assets/images/load.gif"));
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text(widget.idUser));
                    }

                    final docs = snapshot.data!;

                    return ListView.builder(
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        var data = docs[index].data() as Map<String, dynamic>;
                      //  return SizedBox(height: 8,);
                       return  Cardhorizontal(
                          judul: data['nama'],
                          harga: data['harga'],
                          deskripsi: data['deskripsi'],
                        );
                      },
                    );
                  },
                ),
              )
            )
            
          ],
        )
      ),
    );
  }
}