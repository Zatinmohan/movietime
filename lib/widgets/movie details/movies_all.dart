import 'package:flutter/material.dart';
import 'package:movietime/api/url.dart';
import 'package:movietime/widgets/movie%20details/moviedetail.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';

class MoviesAll extends StatelessWidget {
  final id, path, name;
  const MoviesAll({Key key, this.id, this.path, this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => MovieDetail(
                    id: id,
                  ))),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.width * 0.60,
              child: Card(
                elevation: 2.0,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: OptimizedCacheImage(
                  imageUrl: "${URLs.imageURL}$path",
                ),
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              '$name',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 20.0,
              ),
              maxLines: 2,
              overflow: TextOverflow.clip,
            )
          ],
        ),
      ),
    );
  }
}
