import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class addFile extends StatefulWidget {
  final Future<void> Function(BuildContext context) navigation;
  const addFile({
    super.key,
    required this.navigation
  });

  @override
  State<addFile> createState() => _addFileState();
}

class _addFileState extends State<addFile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0xFFF1F1F1),
      ),
      // color: Colors.green,
      width: double.maxFinite,
      height: 118,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
            width: 50,
            child: ElevatedButton(
              style:ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF060A56), // Warna latar
                // foregroundColor: Colors.red, // Warna teks/ikon
                padding: EdgeInsets.all(16)
              ),
              onPressed: (){
                widget.navigation(context);
              },
              child: Center(
                child: Icon(Icons.add,
                  color: Colors.white,
                ),
              )
            ),
          ),
          SizedBox(height: 8),
          Text("Add Your Item",
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFFC8C8C8)
            ),
          )
        ],
      ),
    );
  }
}