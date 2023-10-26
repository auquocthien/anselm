import 'dart:ui';

import './ui/page/index.dart';
import './ui/page/postcast.dart';
import './ui/page/search.dart';
import './ui/page/settings.dart';
import 'route.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
// import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomePage extends StatefulWidget {
  static String id = '/Home';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // var hei = MediaQuery.of(context).size.height;
    // var wid = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Container(
            // color: Colors.red,
            margin: const EdgeInsets.only(top: 10),
            child: Row(
                children: selectedIndex == 0
                    ? const [
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Trang chủ",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 33),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                      ]
                    : selectedIndex == 1
                        ? const [
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Thư viện",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 33),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                          ]
                        : selectedIndex == 3
                            ? const [
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Cài đặt",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 33),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                              ]
                            : const [
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Tìm kiếm",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 33),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                              ])),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Ionicons.notifications_outline,
                size: 30,
                color: Colors.black87,
              )),
          const SizedBox(
            width: 2,
          ),
          // IconButton(
          //     onPressed: () {},
          //     icon: const Icon(
          //       Ionicons.settings_outline,
          //       size: 24,
          //       color: Colors.black87,
          //     )),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false, // <-- HERE
          showUnselectedLabels: false, // <-- AND HERE
          elevation: 18,
          items: [
            BottomNavigationBarItem(
              icon: selectedIndex == 0
                  ? IconButton(
                      icon: const Icon(
                        Ionicons.home_outline,
                        color: Colors.red,
                        size: 27,
                      ),
                      onPressed: () {
                        setState(() {
                          selectedIndex = 0;
                          print("$selectedIndex");
                        });
                      },
                    )
                  : IconButton(
                      icon: const Icon(
                        Ionicons.home,
                        color: Colors.black,
                        size: 27,
                      ),
                      onPressed: () {
                        setState(() {
                          selectedIndex = 0;
                          print("$selectedIndex");
                        });
                      },
                    ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: IconButton(
                icon: selectedIndex == 1
                    ? const Icon(
                        Ionicons.library_outline,
                        color: Colors.red,
                        size: 27,
                      )
                    : const Icon(
                        Ionicons.library,
                        color: Colors.black,
                        size: 27,
                      ),
                onPressed: () {
                  setState(() {
                    selectedIndex = 1;
                    print("$selectedIndex");
                  });
                },
              ),
              label: "Search",
            ),
            BottomNavigationBarItem(
              icon: selectedIndex == 2
                  ? IconButton(
                      icon: const Icon(
                        Ionicons.search_outline,
                        color: Colors.red,
                        size: 27,
                      ),
                      onPressed: () {
                        setState(() {
                          selectedIndex = 2;
                          print("$selectedIndex");
                        });
                      },
                    )
                  : IconButton(
                      icon: const Icon(
                        Ionicons.search,
                        color: Colors.black,
                        size: 27,
                      ),
                      onPressed: () {
                        setState(() {
                          selectedIndex = 2;
                          print("$selectedIndex");
                        });
                      },
                    ),
              label: "Movie",
            ),
            BottomNavigationBarItem(
              icon: selectedIndex == 3
                  ? IconButton(
                      icon: const Icon(
                        Ionicons.reorder_three_outline,
                        color: Colors.red,
                        size: 27,
                      ),
                      onPressed: () {
                        setState(() {
                          selectedIndex = 3;
                          print("$selectedIndex");
                        });
                      },
                    )
                  : IconButton(
                      icon: const Icon(
                        Ionicons.reorder_three,
                        color: Colors.black,
                        size: 27,
                      ),
                      onPressed: () {
                        setState(() {
                          selectedIndex = 3;
                          print("$selectedIndex");
                        });
                      },
                    ),
              label: "Shop",
            ),
          ]),
      body: selectedIndex == 0
          ? const Index()
          : selectedIndex == 1
              ? const Podcast()
              : selectedIndex == 2
                  ? const SearchScreen()
                  : const Settings(),
    );
  }
}
