import 'package:flutter/material.dart';
import 'package:movietime/model/url.dart';
import 'package:movietime/widgets/person/person_detail.dart';

class AllCast extends StatelessWidget {
  final id, path, name, role;
  const AllCast({Key key, this.id, this.path, this.name, this.role})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => PersonDetail(
                    id: id.toString(),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                  ))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        CircleAvatar(
          radius: MediaQuery.of(context).size.width * 0.20,
          backgroundImage: path != null
              ? NetworkImage('${URLs.imageURL}$path')
              : AssetImage('assets/nfound.png'),
        ),
        SizedBox(height: 8.0),
        Text(
          '$name',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 20.0,
          ),
        ),
        Text(
          '$role',
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w400,
            fontSize: 18.0,
          ),
        )
      ]),
    );
  }
}
