import 'package:flutter/material.dart';
import '../video/video_gird_title.dart';

class VideoGrid extends StatefulWidget {
  final List urls;
  final List labels;
  const VideoGrid(this.urls, this.labels, {super.key});
  @override
  State<VideoGrid> createState() => _VideoGridState();
}

class _VideoGridState extends State<VideoGrid> {
  int present = 0;
  int perPage = 10;

  var urlWillShow = [];
  var labelWillShow = [];

  @override
  void initState() {
    super.initState();
    // setState(() {
    //   urlWillShow.addAll(widget.urls.getRange(present, present + perPage));
    //   labelWillShow.addAll(widget.labels.getRange(present, present + perPage));
    //   present = present + perPage;
    // });
  }

  // void loadmore() {
  //   setState(() {
  //     if (present + perPage > widget.urls.length) {
  //       urlWillShow.addAll(widget.urls.getRange(present, widget.urls.length));
  //       labelWillShow
  //           .addAll(widget.labels.getRange(present, widget.labels.length));
  //     } else {
  //       urlWillShow.addAll(widget.urls.getRange(present, present + perPage));
  //       labelWillShow
  //           .addAll(widget.labels.getRange(present, present + perPage));
  //     }
  //     present = present + perPage;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.urls.length,
      itemBuilder: (context, index) {
        return VideoGridTitle(
          widget.urls[index],
          widget.labels[index],
        );
      },
    );
  }
}
