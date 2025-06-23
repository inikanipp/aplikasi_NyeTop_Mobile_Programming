import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddFile extends StatelessWidget {
  final File? imageFile;
  final VoidCallback onTap;

  const AddFile({
    super.key,
    required this.imageFile,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color(0xFFF1F1F1),
        ),
        width: double.infinity,
        height: 150,
        child: Center(
          child: imageFile == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF060A56),
                          padding: EdgeInsets.all(16),
                        ),
                        onPressed: onTap,
                        child: Icon(Icons.add, color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Add Your Item",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFC8C8C8),
                      ),
                    ),
                  ],
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    imageFile!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 150,
                  ),
                ),
        ),
      ),
    );
  }
}
