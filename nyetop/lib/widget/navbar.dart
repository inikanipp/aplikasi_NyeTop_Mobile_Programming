import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class navBar extends StatefulWidget {
  final void Function(int) setPage;
  const navBar({
    super.key,
    required this.setPage
  });

  @override
  State<navBar> createState() => _navBarState();
}

class _navBarState extends State<navBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(32),
        color: Color(0xFF060A56),
      ),
      width: double.maxFinite,
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 31),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () => widget.setPage(0),
            icon: SvgPicture.asset("assets/icons/nonactive/home.svg", width: 25,)
          ),
          IconButton(
            onPressed: () => widget.setPage(0),
            icon: SvgPicture.asset("assets/icons/nonactive/history.svg", width: 25)
          ),
          IconButton(
            onPressed: ()=> widget.setPage(1),
            icon: SvgPicture.asset("assets/icons/nonactive/list.svg", width: 25)
          ),
          IconButton(
            onPressed: (){},
            icon: SvgPicture.asset("assets/icons/nonactive/profile.svg", width: 25)
          ),
        ],
      ),
    );
  }
}