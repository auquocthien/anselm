import 'package:anselm/screen_arguments.dart';
import 'package:anselm/ui/page/video/video_detail.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoGridTitle extends StatefulWidget {
  final String url;
  final String label;

  const VideoGridTitle(this.url, this.label, {super.key});

  @override
  State<VideoGridTitle> createState() => _VideoGridTitleState();
}

class _VideoGridTitleState extends State<VideoGridTitle> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
      ..initialize().then((_) {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String showLocation() {
    print(widget.url);
    String location = widget.url.split('/')[7].split('?')[0].split('.')[0];
    print(location);
    if (location.endsWith('T')) {
      location = 'Miền Trung';
    } else {
      if (location.endsWith('B')) {
        location = 'Miền Bắc';
      } else {
        if (location.endsWith('N')) {
          location = 'Miền Nam';
        } else {
          location = 'Toàn quốc';
        }
      }
    }

    return location;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: GridTile(
        child: Padding(
          padding: const EdgeInsets.only(left: 5.0, bottom: 8.0),
          child: GestureDetector(
            onTap: () {
              print(widget.url);
              Navigator.of(context).pushNamed(VideoDetail.routeName,
                  arguments: ScreenArguments(
                      widget.label, widget.url, showLocation()));
            },
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.5),
                      borderRadius: const BorderRadius.all(Radius.circular(3))),
                  height: 100,
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 8.0),
                  width: 180,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.label,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          showLocation(),
                          style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w900,
                              fontSize: 16),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFooter(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(width: 1)),
      height: 30,
      child: const Text('video'),
    );
  }
}
