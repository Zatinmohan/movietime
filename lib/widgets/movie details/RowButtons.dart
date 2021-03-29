import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movietime/api/url.dart';
import 'package:movietime/firebase/authentication.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class UpperToolbar extends StatefulWidget {
  final id, name, image;

  const UpperToolbar({Key key, this.id, this.name, this.image})
      : super(key: key);
  @override
  _UpperToolbarState createState() => _UpperToolbarState();
}

class _UpperToolbarState extends State<UpperToolbar> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 20.0),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 30.0,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        Row(
          children: [
            StreamBuilder<DocumentSnapshot>(
                stream: context
                    .read<AuthenticationServices>()
                    .searchData(widget.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData) {
                      return IconButton(
                          icon: Icon(
                            FontAwesomeIcons.solidHeart,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            setState(() {});
                            context
                                .read<AuthenticationServices>()
                                .removeData(widget.id);
                          });
                    } else {
                      return IconButton(
                          icon: Icon(
                            FontAwesomeIcons.heart,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {});
                            context
                                .read<AuthenticationServices>()
                                .addData(widget.id, widget.name, widget.image);
                          });
                    }
                  }

                  return IconButton(
                      icon: Icon(
                        FontAwesomeIcons.heart,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {});
                        context
                            .read<AuthenticationServices>()
                            .addData(widget.id, widget.name, widget.image);
                      });
                }),
            PopupMenuButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Text('Share'),
                  value: 1,
                ),
                PopupMenuItem(
                  child: Text('Report'),
                  value: 2,
                ),
              ],
              onSelected: (selected) {
                if (selected == 1)
                  Share.share(
                      "Check out this movie \n ${URLs.movieShareURL}${widget.id}-${widget.name}");
              },
            )
          ],
        ),
      ],
    );
  }
}
