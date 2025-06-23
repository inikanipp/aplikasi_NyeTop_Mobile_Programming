import 'package:flutter/material.dart';
import 'package:nyetop/screen/yourItems.dart';
import 'package:nyetop/screen/homePage.dart';
import 'package:nyetop/widget/navbar.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';

class mainPage extends StatefulWidget {
  final String id_user;
  mainPage({super.key,
    required this.id_user
  
  });

  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  late String idUser;
  int currentIndex = 0;
  
   @override
  void initState() {
    super.initState();
    // Inisialisasi idUser dari widget yang sudah tersedia
    idUser = widget.id_user;
  }

  List<Widget> get pages => [
    HomePage(id_user: idUser, imageId: idUser.toString(),),
    // addItems(),
    yourItems(idUser: idUser,)
    // iniList(),
    // profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.yellow,
      child: Stack(
        children: [
          pages[currentIndex],
          Align(
            alignment: Alignment.bottomCenter,
            child: navBar(
              setPage:(index)=>setState(() {
                  currentIndex = index;
                }
              )
            ),
          )
        ],
      ),
    );
  }
}