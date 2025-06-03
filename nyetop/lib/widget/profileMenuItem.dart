import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nyetop/shared/theme.dart';

class ProfileMenuItem extends StatelessWidget {
  final String iconUrl;
  final String title;
  final VoidCallback? onTap;

  const ProfileMenuItem({
    super.key,
    required this.iconUrl,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 30),
        child: Row(
          children: [
            Image.asset(iconUrl, width: 24),
            const SizedBox(width: 18),
            Text(
              title,
              style: whiteTextStyle.copyWith(fontWeight: medium, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilemenuitemSvg extends StatelessWidget {
  final String iconUrl;
  final String title;
  final VoidCallback? onTap;

  const ProfilemenuitemSvg({
    super.key,
    required this.iconUrl,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 30),
        child: Row(
          children: [
            SvgPicture.asset(iconUrl, width: 20),
            const SizedBox(width: 18),
            Text(
              title,
              style: whiteTextStyle.copyWith(fontWeight: medium, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
