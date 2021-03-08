import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'movieFinder/search.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final scaffoldKey;

  const CustomAppBar({Key key, this.scaffoldKey}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      leading: IconButton(
          icon: Icon(
            Icons.menu,
            size: 28.0,
          ),
          onPressed: () {
            scaffoldKey.currentState.openDrawer();
          }),
      title: Text('movietime',
          style: GoogleFonts.fredokaOne(
            color: Color(0xfffb5558),
            fontWeight: FontWeight.w500,
            fontSize: 28.0,
          )),
      actions: [
        IconButton(
            icon: Icon(
              Icons.search,
              size: 28.0,
            ),
            onPressed: () {
              showSearch(context: context, delegate: Search());
            }),
        IconButton(
            icon: Icon(Icons.person, size: 28.0),
            onPressed: () {
              print("Profile");
            }),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60.0);
}
