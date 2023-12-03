import 'package:transfer_subway/imports.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Weather {
  final double temp; //현재 온도
  final double tempMin; //최저 온도
  final double tempMax; //최고 온도
  final String weatherMain; //흐림정도
  final int code; //흐림정도의 id(icon 작업시 필요)

  Weather({
    this.temp = 0.0,
    this.tempMin = 0.0,
    this.tempMax = 0.0,
    this.weatherMain = 'sunny',
    this.code = 0,
  });
}

class MyWeather extends StatefulWidget {
  const MyWeather({Key? key}) : super(key: key);

  @override
  State<MyWeather> createState() => _MyWeatherState();
}

class _MyWeatherState extends State<MyWeather> {
  Future<Weather> getWeather() async {
    String apiAddr =
        "https://api.openweathermap.org/data/2.5/weather?lat=37.2410864&lon=127.1775537&appid=5a16f6971832b1495a6a571690368f67&units=metric";

    http.Response response;
    var data1;
    Weather weather;
    try {
      response = await http.get(Uri.parse(apiAddr));
      data1 = json.decode(response.body);
      weather = Weather(
          temp: data1["main"]["temp"],
          tempMax: data1["main"]["temp_max"],
          tempMin: data1["main"]["temp_min"],
          weatherMain: data1["weather"][0]["main"],
          code: data1["weather"][0]["id"]);
      //print(weather.tempMin);
    } catch (e) {
      weather = Weather();
      print(e);
    }

    return weather;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getWeather(),
        builder: (context, AsyncSnapshot<Weather> snapshot) {
          if (snapshot.hasData == false) {
            return CircularProgressIndicator();
          } else {
            IconData iconData;
            snapshot.data!.code == 800
                ? iconData = Icons.wb_sunny
                : snapshot.data!.code / 100 == 8 ||
                        snapshot.data!.code / 100 == 2
                    ? iconData = Icons.wb_cloudy
                    : snapshot.data!.code / 100 == 3 ||
                            snapshot.data!.code / 100 == 5
                        ? iconData = Icons.beach_access
                        : snapshot.data!.code / 100 == 6
                            ? iconData = Icons.ac_unit
                            : iconData = Icons.cloud_circle;
            return PopupMenuButton(
                icon: Icon(
                  iconData,
                  color: Colors.white,
                  size: 32,
                ),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      value: 'temp',
                      child: Text('현재 온도 : ${snapshot.data!.temp.toString()}',
                          style: TextStyle(color: Colors.white)),
                    ),
                    PopupMenuItem(
                      value: 'wm',
                      child: Text(
                          '날씨 상태 : ${snapshot.data!.weatherMain.toString()}',
                          style: TextStyle(color: Colors.white)),
                    )
                  ];
                });
          }
        });
  }
}
