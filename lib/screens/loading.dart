import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    super.initState();
    getLocation();
    fetchData();
  }

  void getLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition();
      flutterToast(position.toString());
      print("position");
      print(position);
    } catch (e) {
      flutterToast('There was a problem with the internet connection');
    }
  }

  void fetchData() async {
    try {
      Response response = await get(Uri.parse(
          'https://samples.openweathermap.org/data/2.5/weather?q=London&appid=b1b15e88fa797225412429c1c50c122a1'));
      if (response.statusCode == 200) {
        String jsonData = response.body;
        var myWeather = jsonDecode(jsonData)['weather'][0]['description'];
        flutterToast(myWeather.toString());
        //print(myWeather.toString());

        var myWind = jsonDecode(jsonData)['wind']['speed'];
        flutterToast(myWind.toString());
        //print(myWind);

        var myId = jsonDecode(jsonData)['id'];
        flutterToast(myId.toString());
        //print(myId);
      }
      print(response.statusCode);
    } catch (e) {
      flutterToast('There was a problem with the internet connection');
    }
    /*return Future.delayed(
        Duration(seconds: 3), () => throw Exception('response failed'));*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            getLocation();
            fetchData();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          child: const Text(
            'Get my location',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

void flutterToast(String msg) {
  Fluttertoast.showToast(msg: msg, toastLength: Toast.LENGTH_SHORT);
}
