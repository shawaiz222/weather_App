import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/Api/api.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  //background vedio

  //initialize variables
  String location = '';
  String temp = '';
  String feel = '';
  String humi = '';
  String wSpeed = '';
  String desc = '';
  String visi = '';
  String wIcon = '';
  dynamic arguments;

  void fetchingdata() async {
    GetData instance = GetData(location);
    await instance.getData();

    temp = instance.temp;
    feel = instance.feelslike;
    humi = instance.humidity;
    wSpeed = instance.windSpeed;
    desc = instance.desc;
    visi = instance.visibility;
    wIcon = instance.icon;

    arguments = {
      "temp_value": temp,
      "feel_value": feel,
      "humidity_value": humi,
      "w_Speed": wSpeed,
      "desc_value": desc,
      "visibility_value": visi,
      "icon_link": wIcon,
      "location_": location,
    };
    pushdata();
  }

  void pushdata() {
    Navigator.pushReplacementNamed(context, '/home', arguments: arguments);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map? search = ModalRoute.of(context)?.settings.arguments as Map;
    if (search.isNotEmpty) {
      location = search['location_search'];
    }
    fetchingdata();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: AppBar(
            backgroundColor: const Color.fromARGB(255, 0, 67, 122),
          )),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 0, 67, 122),
                        Color.fromARGB(255, 112, 163, 250),
                      ],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      stops: [0.1, 0.8])),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset("images/C.png", height: 200, width: 200),
                    const Text("Weather App",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w600)),
                    const SizedBox(
                      height: 40,
                    ),
                    const SpinKitThreeInOut(
                      color: Colors.white,
                      size: 50.0,
                    ),
                    const SizedBox(
                      height: 250,
                    ),
                    const Text("Powered by Shawaiz",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w400)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
