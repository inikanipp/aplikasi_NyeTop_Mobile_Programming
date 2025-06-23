// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import '../model/wishlist_provider.dart';
// import '../screen/detailPage.dart';

// class WishlistFloatingButton extends StatelessWidget {
//   const WishlistFloatingButton({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<WishlistProvider>(
//       builder: (context, wishlistProvider, child) {
//         return AnimatedContainer(
//           duration: const Duration(milliseconds: 300),
//           child: FloatingActionButton.extended(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const DetailPage(
//                     nama: 'Wishlist',
//  // ✅ tambahkan parameter yang dibutuhkan
//                   ),
//                 ),
//               );
//             },
//             backgroundColor: const Color(0xFF060A56),
//             foregroundColor: Colors.white,
//             icon: Stack(
//               children: [
//                 const Icon(Icons.favorite),
//                 if (wishlistProvider.wishlistCount > 0)
//                   Positioned(
//                     right: -2,
//                     top: -2,
//                     child: Container(
//                       padding: const EdgeInsets.all(2),
//                       decoration: BoxDecoration(
//                         color: Colors.red,
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       constraints: const BoxConstraints(
//                         minWidth: 16,
//                         minHeight: 16,
//                       ),
//                       child: Text(
//                         '${wishlistProvider.wishlistCount}',
//                         style: GoogleFonts.poppins(
//                           color: Colors.white,
//                           fontSize: 10,
//                           fontWeight: FontWeight.w600,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//             label: Text(
//               wishlistProvider.wishlistCount > 0
//                   ? 'Wishlist (${wishlistProvider.wishlistCount})'
//                   : 'Wishlist',
//               style: GoogleFonts.poppins(
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
