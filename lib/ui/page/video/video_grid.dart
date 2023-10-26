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
    setState(() {
      urlWillShow.addAll(widget.urls.getRange(present, present + perPage));
      labelWillShow.addAll(widget.labels.getRange(present, present + perPage));
      present = present + perPage;
    });
  }

  void loadmore() {
    setState(() {
      if (present + perPage > widget.urls.length) {
        urlWillShow.addAll(widget.urls.getRange(present, widget.urls.length));
        labelWillShow
            .addAll(widget.labels.getRange(present, widget.labels.length));
      } else {
        urlWillShow.addAll(widget.urls.getRange(present, present + perPage));
        labelWillShow
            .addAll(widget.labels.getRange(present, present + perPage));
      }
      present = present + perPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
          loadmore();
        }
        return true;
      },
      child: GridView.builder(
          itemCount: widget.urls.length,
          itemBuilder: (context, index) {
            return (index == urlWillShow.length)
                ? Container(
                    color: Colors.amberAccent,
                    child: TextButton(
                      child: Text('Xem Thêm'),
                      onPressed: () {
                        loadmore();
                      },
                    ),
                  )
                : VideoGridTitle(widget.urls[index], widget.labels[index]);
          },
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10)),
    );
  }
}
