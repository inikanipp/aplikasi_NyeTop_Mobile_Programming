import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nyetop/widget/addFile.dart';
import 'package:nyetop/widget/cardHorizontal.dart';
import 'addItems.dart';

class yourItems extends StatefulWidget {
  final String idUser;
  const yourItems({super.key,
    required this.idUser
  
  });

  @override
  State<yourItems> createState() => _yourItemsState();
}

class _yourItemsState extends State<yourItems> {
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
            // Cardhorizontal()
          ],
        )
      ),
    );
  }
}