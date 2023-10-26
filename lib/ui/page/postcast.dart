import '../../route.dart';
import 'package:flutter/material.dart';

class Podcast extends StatefulWidget {
  const Podcast({Key? key}) : super(key: key);

  @override
  State<Podcast> createState() => _PodcastState();
}

class _PodcastState extends State<Podcast> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 15, left: 20),
          child: const Text(
            "Video đã tải xuống",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        SizedBox(
            height: 150,
            // color: Colors.black,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: podcast.length,
                itemBuilder: (context, i) {
                  return Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      image: DecorationImage(
                        image: AssetImage("${podcast[i]['img']}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    margin:
                        const EdgeInsets.only(left: 20, top: 30, bottom: 15),
                  );
                })),
        Container(
          margin: const EdgeInsets.only(top: 15, left: 20),
          child: const Text(
            "Các video khác",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 100,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  image: DecorationImage(
                    image: AssetImage(podcast[0]['img']),
                    fit: BoxFit.cover,
                  ),
                ),
                margin: const EdgeInsets.only(left: 20, top: 30, bottom: 15),
                child: Text(
                  podcast[0]['title'],
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                height: 100,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  image: DecorationImage(
                    image: AssetImage(podcast[1]['img']),
                    fit: BoxFit.cover,
                  ),
                ),
                margin: const EdgeInsets.only(right: 10, top: 30, bottom: 15),
                child: Text(
                  podcast[1]['title'],
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
              ),
            )
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 100,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  image: DecorationImage(
                    image: AssetImage(podcast[2]['img']),
                    fit: BoxFit.cover,
                  ),
                ),
                margin: const EdgeInsets.only(left: 20, top: 30, bottom: 15),
                child: Text(
                  podcast[2]['title'],
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                height: 100,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  image: DecorationImage(
                    image: AssetImage(podcast[3]['img']),
                    fit: BoxFit.cover,
                  ),
                ),
                margin: const EdgeInsets.only(right: 10, top: 30, bottom: 15),
                child: Text(
                  podcast[3]['title'],
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
              ),
            )
          ],
        ),
        Container(
          decoration: const BoxDecoration(
              color: Color(0xFFB6AFAF),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          margin: const EdgeInsets.only(top: 15, left: 100),
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          child: const Text(
            "Xem Thêm",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ],
    );
  }
}
