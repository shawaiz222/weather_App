// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:dynamic_weather_icons/dynamic_weather_icons.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Map info = ModalRoute.of(context)?.settings.arguments as Map;
    var iconlink = info["icon_link"];
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        final value = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Alert"),
                content: Text("Do You Want To Exit App"),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      child: Text("Yes")),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("No")),
                ],
              );
            });
        if (value != null) {
          return Future.value(value);
        } else {
          return Future.value(false);
        }
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(0),
              child: AppBar(
                backgroundColor: Color.fromARGB(255, 0, 67, 122),
              )),
          body: SafeArea(
              child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 0, 67, 122),
                        Color.fromARGB(255, 112, 163, 250),
                      ],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      stops: [0.1, 0.8])),
              child: Column(children: [
                // ignore: avoid_unnecessary_containers
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 17),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white.withOpacity(0.7),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                            controller: searchController,
                            decoration: InputDecoration(
                                hintText: "Search City",
                                border: InputBorder.none,
                                suffixIcon: GestureDetector(
                                    onTap: () {
                                      if (searchController.text.isEmpty ||
                                          searchController.text == ' ') {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: const Text("Alert"),
                                                content: const Text(
                                                    "Please Enter the Location First"),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: const Text("OK"))
                                                ],
                                              );
                                            });
                                      } else {
                                        Navigator.pushReplacementNamed(
                                            context, '/loading',
                                            arguments: {
                                              'location_search':
                                                  searchController.text,
                                            });
                                      }
                                    },
                                    child: Icon(
                                      Icons.search_rounded,
                                      color: Colors.blue,
                                    )))),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white.withOpacity(0.5)),
                        child: Row(
                          children: [
                            // ignore: sized_box_for_whitespace
                            Container(
                                height: 50,
                                width: 50,
                                child: Image.network(iconlink)),
                            Container(
                              margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    info["desc_value"],
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "In ${info["location_"]}",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 200,
                        margin:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white.withOpacity(0.5)),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  WeatherIcon.getIcon("wi-thermometer"),
                                  size: 25,
                                ),
                                Text("TEMPREATURE")
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    info["temp_value"],
                                    style: TextStyle(
                                      fontSize: 80,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(5, 30, 0, 0),
                                    child: Icon(
                                      WeatherIcon.getIcon("wi-celsius"),
                                      size: 40,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(25, 0, 5, 0),
                        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white.withOpacity(0.5)),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  WeatherIcon.getIcon("wi-humidity"),
                                  size: 20,
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                  child: Text(
                                    "Humidity",
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    info["humidity_value"],
                                    style: TextStyle(fontSize: 35),
                                  ),
                                  Container(
                                      margin: EdgeInsets.fromLTRB(5, 10, 0, 0),
                                      child: Text(
                                        "%",
                                        style: TextStyle(fontSize: 18),
                                      )),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(5, 0, 25, 0),
                        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white.withOpacity(0.5)),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  WeatherIcon.getIcon("wi-day-cloudy-gusts"),
                                  size: 20,
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(15, 10, 0, 0),
                                  child: Text(
                                    "Feels-Like",
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    info["feel_value"],
                                    style: TextStyle(fontSize: 35),
                                  ),
                                  Icon(WeatherIcon.getIcon("wi-celsius")),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(25, 0, 5, 0),
                          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white.withOpacity(0.5)),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    WeatherIcon.getIcon("wi-strong-wind"),
                                    size: 20,
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                    child: Text(
                                      "Wind-Speed",
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      info["w_Speed"],
                                      style: TextStyle(fontSize: 35),
                                    ),
                                    Container(
                                        margin:
                                            EdgeInsets.fromLTRB(5, 10, 0, 0),
                                        child: Text(
                                          "KM/H",
                                          style: TextStyle(fontSize: 15),
                                        )),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(5, 0, 25, 0),
                          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white.withOpacity(0.5)),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    WeatherIcon.getIcon("wi-day-fog"),
                                    size: 20,
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(15, 10, 0, 0),
                                    child: Text(
                                      "Visibility",
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      info["visibility_value"],
                                      style: TextStyle(fontSize: 35),
                                    ),
                                    Container(
                                        margin:
                                            EdgeInsets.fromLTRB(5, 10, 0, 0),
                                        child: Text(
                                          "KM's",
                                          style: TextStyle(fontSize: 15),
                                        )),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 50, 0, 10),
                  child: Text("Powered by Shawaiz"),
                )
              ]),
            ),
          ))),
    );
  }
}
