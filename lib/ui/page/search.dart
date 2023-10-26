// import 'dart:html';
// import 'dart:io';

import 'package:anselm/ui/page/video/video_grid.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../../global.dart';
// import 'package:video_player/video_player.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchState();
}

class _SearchState extends State<SearchScreen> {
  late String searchText = '';
  late bool checkValue1;
  late bool checkValue2;
  late bool checkValue3;
  late bool checkValue4;
  List urlVideo = [];
  List labelVideo = [];
  List video = [];
  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    checkValue1 = false;
    checkValue2 = false;
    checkValue3 = false;
    checkValue4 = false;
    super.initState();
  }

  List getVideo(String searchText) {
    List listVideo = [];

    for (var element in labels.toList()) {
      if (element.nameVni.toLowerCase().contains(searchText.toLowerCase())) {
        listVideo.add(element.nameEng);
      }
    }

    // listLabelVideo = [];
    return listVideo;
  }

  List getLabel(List video) {
    List label = [];
    for (var el in video) {
      var name = labels.toList().where((element) => element.nameEng == el);
      name.forEach((element) {
        label.add(element.nameVni);
      });
    }
    return label;
  }

  Future<List> getUrlVideoToShow(List videoToShow) async {
    List urlToShow = [];
    final storage = FirebaseStorage.instance;
    for (var element in videoToShow) {
      String url = '';
      Reference ref = storage.ref().child('$element.mp4');
      url = (await ref.getDownloadURL()).toString();
      urlToShow.add(url);
    }

    return urlToShow;
  }

  List filterVideo(bool value1, bool value2, bool value3, bool value4) {
    List videos = getVideo(searchText);
    List videoafter = [];
    if (value1 && !value2 && !value3) {
      var vid = videos.where((element) => element.toString().endsWith('B'));
      for (var el in vid) {
        videoafter.add(el);
      }
    }
    if (value1 && value2 && !value3) {
      var vid = videos.where((element) =>
          element.toString().endsWith('B') && element.toString().endsWith('N'));
      for (var el in vid) {
        videoafter.add(el);
      }
    }
    if (value1 && !value2 && value3) {
      var vid = videos.where((element) =>
          element.toString().endsWith('B') && element.toString().endsWith('T'));
      for (var el in vid) {
        videoafter.add(el);
      }
    }
    if (value2 && !value1 && !value3) {
      var vid = videos.where((element) => element.toString().endsWith('N'));
      for (var el in vid) {
        videoafter.add(el);
      }
    }
    if (value2 && !value1 && value3) {
      var vid = videos.where((element) =>
          element.toString().endsWith('N') && element.toString().endsWith('T'));
      for (var el in vid) {
        videoafter.add(el);
      }
    }
    if (value3 && !value2 && !value1) {
      var vid = videos.where((element) => element.toString().endsWith('T'));
      for (var el in vid) {
        videoafter.add(el);
      }
    }
    if (value4 && !value3 && !value2 && !value1) {
      var vid = videos.where((element) =>
          !element.toString().endsWith('T') &&
          !element.toString().endsWith('N') &&
          !element.toString().endsWith('B'));
      for (var el in vid) {
        videoafter.add(el);
      }
    }
    if (!value1 && !value2 && !value3) {
      return getVideo(searchText);
    }
    return videoafter;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 60,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          // decoration: const BoxDecoration(
          //     borderRadius: BorderRadius.all(Radius.circular(12)),
          //     color: Color(0xFFCACACA)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 300,
                child: TextField(
                  controller: editingController,
                  onChanged: (value) {
                    setState(() {
                      searchText = value;
                    });
                    // urlVideo = await getUrlVideoToShow(searchText);

                    // await listVideo(value);
                    // print(urlVideo.length);
                  },
                  decoration: const InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    prefixIconColor: Color.fromARGB(255, 142, 142, 142),
                  ),
                ),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFB6AFAF),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      textStyle: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  onPressed: () async {
                    List videoToShow = getVideo(searchText);
                    List urls = await getUrlVideoToShow(videoToShow);
                    List labels = getLabel(videoToShow);

                    setState(() {
                      urlVideo = urls;
                      labelVideo = labels;
                      video = videoToShow;
                    });
                  },
                  child: const Text('Tìm'))
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20),
          child: const Text(
            "Bộ Lọc",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        Container(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FilterChip(
                label: const Text('Miền Bắc'),
                selected: checkValue1,
                onSelected: (bool? value) async {
                  setState(() {
                    checkValue1 = value!;
                  });
                  video = filterVideo(
                      checkValue1, checkValue2, checkValue3, checkValue4);
                  labelVideo = getLabel(video);
                  urlVideo = await getUrlVideoToShow(video);
                  setState(() {});
                },
              ),
              FilterChip(
                label: const Text('Miền Nam'),
                selected: checkValue2,
                onSelected: (bool? value) async {
                  setState(() {
                    checkValue2 = value!;
                  });
                  print(checkValue2);
                  video = filterVideo(
                      checkValue1, checkValue2, checkValue3, checkValue4);
                  labelVideo = getLabel(video);
                  urlVideo = await getUrlVideoToShow(video);
                  setState(() {});
                },
              ),
              FilterChip(
                label: const Text('Miền Trung'),
                selected: checkValue3,
                onSelected: (bool? value) async {
                  setState(() {
                    checkValue3 = value!;
                  });
                  print(checkValue3);
                  video = await filterVideo(
                      checkValue1, checkValue2, checkValue3, checkValue4);
                  labelVideo = getLabel(video);
                  urlVideo = await getUrlVideoToShow(video);
                  setState(() {});
                },
              ),
              FilterChip(
                label: const Text('Khác'),
                selected: checkValue4,
                onSelected: (bool? value) async {
                  setState(() {
                    checkValue4 = value!;
                  });
                  print(checkValue4);
                  video = filterVideo(
                      checkValue1, checkValue2, checkValue3, checkValue4);
                  labelVideo = getLabel(video);
                  urlVideo = await getUrlVideoToShow(video);
                  setState(() {});
                },
              )
            ],
          ),
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(15),
          child: VideoGrid(urlVideo, labelVideo),
        ))
        // Text(urlVideo[2].toString())
      ],
    );
  }
}
