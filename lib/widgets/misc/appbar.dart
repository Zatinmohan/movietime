import 'package:flutter/material.dart';
import 'package:movietime/model/colordata.dart';
import 'package:movietime/widgets/profile/profile.dart';

import '../movieFinder/search.dart';

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
      title: title,
      actions: [
        IconButton(
            icon: Icon(
              Icons.search,
              size: 28.0,
            ),
            onPressed: () {
              showSearch(context: context, delegate: Search());
            }),
        Padding(
          padding: EdgeInsets.only(right: 5.0),
          child: InkWell(
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => Profile())),
            child: CircleAvatar(
              radius: 20.0,
              backgroundColor: Colors.white,
              child: Image.asset('assets/newuser.png'),
            ),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(55.0);
}
