import 'package:anselm/screen_arguments.dart';
import 'package:anselm/ui/page/video/video_gird_title.dart';
import 'package:chewie/chewie.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../../global.dart';

class VideoDetail extends StatefulWidget {
  static String routeName = '/video_detail';
  final String url;
  final String label;
  final String location;
  const VideoDetail(this.label, this.url, this.location, {super.key});
  @override
  State<VideoDetail> createState() => _VideoDetailState();
}

class _VideoDetailState extends State<VideoDetail> {
  late VideoPlayerController _controller;
  late ChewieController _videoController;

  late List sameVideo = [];
  late List sameLabel = [];
  late List sameUrl = [];
  @override
  void initState() {
    _videoController = ChewieController(
        videoPlayerController:
            VideoPlayerController.networkUrl(Uri.parse(widget.url)),
        aspectRatio: 16 / 9,
        autoInitialize: true,
        looping: true,
        errorBuilder: (context, errorMessage) {
          return const Center(child: CircularProgressIndicator());
        });

    super.initState();
  }

  @override
  void dispose() {
    // _controller.dispose();
    _videoController.dispose();
    super.dispose();
  }

  List getLabel() {
    List sameVideo = getVideo();
    List label = [];
    for (var el in sameVideo) {
      var name = labels.toList().where((element) => element.nameEng == el);
      name.forEach((element) {
        label.add(element.nameVni);
      });
    }
    return label;
  }

  List getVideo() {
    List same = [];
    widget.label.split(' ').forEach((element) {
      if (!element.contains('(') && !element.contains(')')) {
        same.add(element);
      }
    });
    print(same);
    List listVideo = [];
    for (var element in labels.toList()) {
      for (var el in same) {
        if (element.nameVni.toLowerCase().contains(el.toLowerCase())) {
          listVideo.add(element.nameEng);
        }
      }
    }
    return listVideo;
  }

  List sameName() {
    List same = [];
    widget.label.split(' ').forEach((element) {
      if (!element.contains('(') && !element.contains(')')) {
        same.add(element);
      }
    });
    return same;
  }

  Future<List> getUrlVideoToShow() async {
    List videoToShow = getVideo();
    List urlToShow = [];
    final storage = FirebaseStorage.instance;
    for (var element in videoToShow) {
      String url = '';
      Reference ref = storage.ref().child('$element.mp4');
      url = (await ref.getDownloadURL()).toString();
      urlToShow.add(url);
    }
    print(videoToShow);
    return urlToShow;
  }

  @override
  Widget build(BuildContext context) {
    print(widget.location);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.label),
      ),
      body: Column(
        children: [
          Container(
              padding: const EdgeInsets.all(8),
              height: 240,
              child: Chewie(controller: _videoController)),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(
              height: 10,
              thickness: 5,
            ),
          ),
          Container(
              padding: const EdgeInsets.only(left: 8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Khu vực sử dụng: ${widget.location}',
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
              )),
          Container(
            padding: const EdgeInsets.only(left: 8.0),
            child: const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Hướng dẫn động tác: Đang cập nhật',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 18),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(
              height: 10,
              thickness: 5,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 8.0, bottom: 10.0),
            child: const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Các video khác',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 18),
              ),
            ),
          ),
          Expanded(
              child: FutureBuilder(
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  final data = snapshot.data as List;
                  sameLabel = getLabel();
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return VideoGridTitle(data[index], sameLabel[index]);
                    },
                  );
                }
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            future: getUrlVideoToShow(),
          ))
        ],
      ),
    );
  }
}
