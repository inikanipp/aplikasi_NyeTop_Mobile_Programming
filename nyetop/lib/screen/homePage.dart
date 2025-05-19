import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'loginPage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nyetop/screen/loginPage.dart';
import 'package:nyetop/widget/navbar.dart';
import 'package:nyetop/widget/card.dart';
import 'package:nyetop/widget/serachBar.dart';
import 'package:nyetop/screen/addItems.dart';
import 'package:cloud_firestore/cloud_firestore.dart';




class HomePage extends StatefulWidget {
  final String id_user ;
  const HomePage({
    super.key,
    required this.id_user
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // final List<Widget> pages = [
  //   HomePage(),
  //   History(),
  //   iniList(),
  //   profile(),
  // ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("")),
      body: Container(
        padding: EdgeInsets.all(16),
        color: Colors.white,
        height: double.maxFinite,
        width: double.maxFinite,
        child: Stack(
          children: [
            Container(
              // color: Colors.greenAccent,
              width: double.maxFinite,
              height: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 8),
                    // color: Colors.amber,
                    width: double.maxFinite,
                    height: 50,
                    child: Row(
                      children: [
                        Expanded(
                        child: Container(
                            // color: Colors.red,
                            height: double.maxFinite,
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 16),
                                  height: double.maxFinite,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle
                                  ),
                                ),
                                // Text("Halo, ${widget.id_user} ",
                                Text("Halo, Agus",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500
                                  ),
                                )
                              ],
                            )
                          ),
                        ),
                        
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.white, 
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 8,
                                offset: Offset(0, 4), // arah bayangan
                              ),
                            ],
                          ),
                          child: IconButton(
                            onPressed: () async {
                              await FirebaseAuth.instance.signOut();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => Loginpage()),
                              );
                            },
                            icon: SvgPicture.asset("assets/icons/active/notif.svg"),
                            color: Colors.white,
                          ),
                        )

                      ],
                    ),
                  ),
                  Container(
                    // color: Colors.lightBlue,
                    width: 250,
                    height: 68,
                    child: Text("Temukan Laptop yang kamu butuhkan",
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                  Container(
                    // color: Colors.amber,
                    width: double.maxFinite,
                    height: 40,
                    child: Text("Dengan spesifikasi dan harga terbaik",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFFA1A1A1)
                      ),
                    ),
                  ),
                  Container(
                    // color: Colors.lightBlue,
                    width: double.maxFinite,
                    height: 53,
                    child: Row(
                      children: [
                        Expanded(
                        child: searchBar()
                        ),
                        SizedBox(width: 13),
                        GestureDetector(
                          onTap: (){print("filter");},
                          child: 
                            Container(
                            // color: Colors.cyanAccent,
                            padding: EdgeInsets.all(16),
                            width: 53,
                            height: double.maxFinite,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              color: Color(0xFF060A56)
                            ),
                            child: SvgPicture.asset("assets/icons/nonactive/filter.svg"),
                          ),
                        )
                        
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      // color: Colors.red,
                      width: 500,
                      padding: EdgeInsets.only(top: 16),
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance.collection('laptops').snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: Image.asset("assets/images/load.gif"));
                          }

                          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                            return Center(child: Text('Tidak ada data.'));
                          }

                          final laptops = snapshot.data!.docs;
                      
                      return GridView.builder(
                        itemCount: laptops.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // jumlah kolom
                          crossAxisSpacing: 10, // jarak antar kolom
                          mainAxisSpacing: 10, // jarak antar baris
                          childAspectRatio: 182/ 234, 
                        ),
                        itemBuilder: (context, index) {
                          final data = laptops[index].data() as Map<String, dynamic>;
                          return cardLaptop(
                            judul: data['nama'],
                            harga: data['harga'].toString(),
                            deskripsi: data['deskripsi'],
                          );
                        },
                      
                      );
                    }
                    )
                    )
                  )
                ],
              ),
            ),
            Positioned(
              right: 0,
              bottom : 100,
              child:FloatingActionButton(
                backgroundColor: Color(0XFF060A56),
                foregroundColor: Colors.white,
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> addItems(idUser: widget.id_user,)));
                },
                child: Icon(Icons.add),
              )
            )
          ],
        ),
      ),
    );
  }
}
