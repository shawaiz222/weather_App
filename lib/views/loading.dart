// ignore_for_file: use_build_context_synchronously, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weather_app/Api/api.dart';
import 'package:location/location.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  Location locationn = Location();
  String location = '';
  // ignore: prefer_typing_uninitialized_variables
  var arguments;

  Future<void> checkPermissionAndEnableLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    // Check if location services are enabled
    serviceEnabled = await locationn.serviceEnabled();
    if (!serviceEnabled) {
      // Request to enable location services
      serviceEnabled = await locationn.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    // Check location permission status
    permissionGranted = await locationn.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      // Request location permission
      permissionGranted = await locationn.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    // Location permission and service are granted, you can now get the location
    LocationData locationData = await locationn.getLocation();
    // print("Location: ${locationData.latitude}, ${locationData.longitude}");
    String latitde = locationData.latitude.toString();
    String longitude = locationData.longitude.toString();

    location = ("$latitde ,$longitude");
    // print(location);
    fetchingdata();
  }
  //background vedio

  //initialize variables

  String temp = '';
  String feel = '';
  String humi = '';
  String wSpeed = '';
  String desc = '';
  String visi = '';
  String wIcon = '';
  // ignore: prefer_typing_uninitialized_variables

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
    location = instance.location;

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
    checkPermissionAndEnableLocation();

    Fluttertoast.showToast(
      msg: "Welcome to Weather App",
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Colors.black,
    );
  }

  @override
  Widget build(BuildContext context) {
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
