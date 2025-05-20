import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nyetop/screen/detailPage.dart';

class Cardhorizontal extends StatefulWidget {
  final String judul;
  final String harga;
  final String deskripsi;
  const Cardhorizontal({super.key,
    required this.judul,
    required this.harga,
    required this.deskripsi
  
  });

  @override
  State<Cardhorizontal> createState() => _CardhorizontalState();
}

class _CardhorizontalState extends State<Cardhorizontal> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(10),
      width: double.maxFinite,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.25),
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(0, 2), // arah bayangan (kanan, bawah)
          ),
        ],
      ),
      
      child: Row(
        children: [
            ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/images/laptop.jpg',
              height: 130,
              width: 130,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 10,),
          Expanded(
            child: Container(
              // color: Colors.green,
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.judul,
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  // SizedBox(height: 4,),
                  Text(widget.judul,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                  SizedBox(height: 4,),
                  Text(widget.deskripsi,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 4,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 90,
                        height: 22,
                        child: ElevatedButton(
                          style:  ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF060A56),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> Detailpage(nama: widget.judul,harga: widget.harga, deskripsi: widget.deskripsi,)));
                          },
                          child: Text(
                            "Pilih",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.white, // ✅ Tambahkan ini!
                            ),
                          ),
                        ),
                      )
                    ],
                  ) 
                ],
              ),
            )
          )
        ],
      )
    );
  }
}