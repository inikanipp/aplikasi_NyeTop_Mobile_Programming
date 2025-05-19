import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class field extends StatelessWidget {
  final int line;
  final String name;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;

  const field({super.key,
    required this.line,
    required this.name,
    required this.onSaved,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600
          ),
        ),
        SizedBox(height: 16),
        TextFormField(
          maxLines: line,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide : BorderSide(
                color: Colors.red,
                width: 2
              )
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide : BorderSide(
                color: Color(0xFFF1F1F1),
                width: 2
              )
            ),
            filled: true,
            fillColor: Color(0xFFF1F1F1),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide : BorderSide(
                color: Color(0xFF060A56),
                width: 2
              )
            ),
          ),
          onSaved: onSaved,
          validator: validator,
        )
      ],
    );
  }
}