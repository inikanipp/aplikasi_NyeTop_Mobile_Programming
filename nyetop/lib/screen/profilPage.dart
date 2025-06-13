import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nyetop/screen/loginPage.dart';
import 'package:nyetop/shared/theme.dart';
import 'package:nyetop/widget/profileMenuItem.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  File? _profileImage;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        _profileImage = File(pickedImage.path);
      });
    }
  }

  void _showImageSourceActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Kamera'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Galeri'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 22),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: mainColor,
            ),
            child: Column(
              children: [
                const SizedBox(height: 22),
                GestureDetector(
                  onTap: () => _showImageSourceActionSheet(context),
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: _profileImage != null
                            ? FileImage(_profileImage!)
                            : const AssetImage('assets/images/img_profile.png') as ImageProvider,
                      ),
                      const CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.edit, size: 20),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Agus',
                  style: whiteTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: medium,
                  ),
                ),
                const SizedBox(height: 40),
                ProfileMenuItem(
                  iconUrl: 'assets/icons/png/ic2_profile.png',
                  title: 'Edit Profile',
                  onTap: () {},
                ),
                ProfileMenuItem(
                  iconUrl: 'assets/icons/png/ic2_history.png',
                  title: 'History',
                  onTap: () {},
                ),
                ProfileMenuItem(
                  iconUrl: 'assets/icons/png/ic2_wishlist.png',
                  title: 'Wishlist',
                  onTap: () {},
                ),
                ProfileMenuItem(
                  iconUrl: 'assets/icons/png/ic2_item.png',
                  title: 'Your Item',
                  onTap: () {},
                ),
                ProfileMenuItem(
                  iconUrl: 'assets/icons/png/ic2_logout.png',
                  title: 'Log Out',
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Loginpage()),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 87),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
























// ------------------------------ ini punya ku sebelumnya hasil coding sendiri

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:nyetop/screen/loginPage.dart';
// import 'package:nyetop/shared/theme.dart';
// import 'package:nyetop/widget/profileMenuItem.dart';

// class ProfilPage extends StatelessWidget {
//   const ProfilPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: lightBackgroundColor,
//       appBar: AppBar(
//         // backgroundColor: lightBackgroundColor,
//         // elevation: 0,
//         // // untuk versi android agar ketengah pakai centertitle, kalau ios defaultnya langsung tengah
//         // centerTitle: true,
//         // iconTheme: IconThemeData(
//         //   color: blackColor,
//         // ),
//         // jika mau pakai program dibawah hanya untuk ios karna kalau android otomatis hitam
//         // iconTheme: IconThemeData(
//         //   color: blackColor,
//         // ),
//         title: const Text(
//           'My Profile',
//           // style: blackTextStyle.copyWith(fontSize: 20, fontWeight: semiBold),
//         ),
//       ),
//       body: ListView(
//         padding: const EdgeInsets.symmetric(horizontal: 24),
//         children: [
//           const SizedBox(height: 20),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 22),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(20),
//               color: mainColor,
//             ),
//             child: Column(
//               children: [
//                 SizedBox(height: 22),
//                 Container(
//                   width: 120,
//                   height: 120,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     image: DecorationImage(
//                       image: AssetImage('assets/images/img_profile.png'),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 Text(
//                   'Agus',
//                   style: whiteTextStyle.copyWith(
//                     fontSize: 18,
//                     fontWeight: medium,
//                   ),
//                 ),
//                 const SizedBox(height: 40),
//                 ProfileMenuItem(
//                   iconUrl: 'assets/icons/png/ic2_profile.png',
//                   title: 'Edit Profile',
//                   onTap: () {
//                     // Navigator.pushNamed(context, '/pin');
//                   },
//                 ),
//                 ProfileMenuItem(
//                   iconUrl: 'assets/icons/png/ic2_history.png',
//                   title: 'History',
//                   onTap: () {
//                     // Navigator.pushNamed(context, '/pin');
//                   },
//                 ),
//                 ProfileMenuItem(
//                   iconUrl: 'assets/icons/png/ic2_wishlist.png',
//                   title: 'History',
//                   onTap: () {
//                     // Navigator.pushNamed(context, '/pin');
//                   },
//                 ),
//                 ProfileMenuItem(
//                   iconUrl: 'assets/icons/png/ic2_item.png',
//                   title: 'Your Item',
//                   onTap: () {
//                     // Navigator.pushNamed(context, '/pin');
//                   },
//                 ),
//                 ProfileMenuItem(
//                   iconUrl: 'assets/icons/png/ic2_logout.png',
//                   title: 'Log Out',
//                   onTap: () async {
//                     await FirebaseAuth.instance.signOut();
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(builder: (context) => Loginpage()),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 87),
//           // CustomTextButton(title: 'Report a Problem', onPressed: () {}),
//           const SizedBox(height: 50),
//         ],
//       ),
//     );
//   }
// }
