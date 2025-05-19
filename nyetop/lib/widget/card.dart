import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nyetop/screen/detailPage.dart';

class cardLaptop extends StatefulWidget {
  final String judul;
  final String harga;
  final String deskripsi;
  const cardLaptop({super.key,
    required this.judul,
    required this.harga,
    required this.deskripsi
  });

  @override
  State<cardLaptop> createState() => _cardLaptopState();
}

class _cardLaptopState extends State<cardLaptop> {
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> Detailpage(nama: widget.judul, harga: widget.harga,deskripsi: widget.deskripsi,)));
      },
      child: Container(
      padding: EdgeInsets.all(10),
      // color: Colors.red,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        // color: Colors.red
        color: Color(0xFFF1F1F1)
      ),
      width: 182,
      height: 234,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/images/laptop.jpg',
              height: 164,
              width: double.maxFinite,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 3,),
          Expanded(
            child:  Container(
              // color: Colors.lightBlueAccent,
              width: double.maxFinite,
              height: double.maxFinite,
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.judul, style: GoogleFonts.poppins(
                          fontSize:14,
                          fontWeight: FontWeight.w700
                        )
                      ),
                      Text(widget.harga)
                    ],
                  ),
                  Expanded(
                    child: Container(
                      alignment: AlignmentDirectional.topEnd,
                      padding: EdgeInsets.all(0),
                      child: GestureDetector(
                        onTap: () {
                          print("amann");
                        },
                        child: SvgPicture.asset("assets/icons/nonactive/save.svg"),
                      )
                    )
                  ),
                  
                ],
              ),
            )
          )
          
        ],
      ),
    ),
    );
   
    
  }
}