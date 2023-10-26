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

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: GridTile(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                print(widget.url);
                Navigator.of(context).pushNamed(VideoDetail.routeName,
                    arguments: ScreenArguments(widget.label, widget.url));
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 0.5),
                    borderRadius: const BorderRadius.all(Radius.circular(3))),
                height: 100,
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              ),
            ),
            Text(widget.label)
          ],
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
