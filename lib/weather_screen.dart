import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:WeatherToday/components/additional_info_card.dart';
import 'package:WeatherToday/components/forecast_card.dart';
import 'package:http/http.dart' as http;
import 'package:WeatherToday/secrets.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Future<Map<String, dynamic>> getCurrentWeather() async {
    String cityName = 'Rudrapur, Uttarakhand';
    try {
      final response = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$weatherApiKey',
        ),
      );

      final data = jsonDecode(response.body);

      if (data['cod'] != '200') {
        throw data['message'];
      }
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        title: Text('Weather App'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                getCurrentWeather();
              });
              if (mounted) {
                setState(() {
                  getCurrentWeather();
                });
              }
            },
          ),
          // GestureDetector(onTap: () {print('settings');}, child: const Icon(Icons.settings)),
          // InkWell(onTap: () {print('settings');}, child: const Icon(Icons.color_lens)),
        ],
        // leading: IconButton(
        //   icon: const Icon(Icons.menu),
        //   onPressed: () {
        //     print('menu');
        //   },
        // ),
      ),
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final data = snapshot.data!;
          final cityName = data['city']['name'];
          final cityCountry = data['city']['country'];
          final currentWeather = data['list'][0];
          final double temperature = (currentWeather['main']['temp']) - 273.15;
          final String weatherType = currentWeather['weather'][0]['main'];
          final num pressure = currentWeather['main']['pressure'];
          final num humidity = currentWeather['main']['humidity'];
          final num windSpeed = currentWeather['wind']['speed'];
          // final forecastList = data['list'];
          final forecastList = data['list'];

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              spacing: 20,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                Card(
                  color: Theme.of(context).colorScheme.surface,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        // height: 200,
                        padding: EdgeInsets.all(20),
                        width: double.infinity,
                        // decoration: BoxDecoration(
                        //   color: const Color.fromARGB(255, 48, 45, 15),
                        //   borderRadius: BorderRadius.circular(10),
                        // boxShadow: [
                        //   const BoxShadow(
                        //     color: Color.fromARGB(255, 48, 45, 15),
                        //     spreadRadius: -4.0,
                        //     blurRadius: 8.0,
                        //   ),
                        // ],
                        // ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.location_on, size: 15),
                                Text(
                                  '$cityName, $cityCountry',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  // style: Theme.of(context).textTheme.displayLarge,
                                ),
                              ],
                            ),
                            Text(
                              '${temperature.toStringAsFixed(0)}°C',
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                            Icon(
                              weatherType == 'Clouds'
                                  ? Icons.cloud
                                  : weatherType == 'Rain'
                                  ? Icons.sunny_snowing
                                  : weatherType == 'Snow'
                                  ? Icons.snowing
                                  : Icons.sunny,
                              size: 60,
                            ),
                            Text(
                              weatherType,
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    Text(
                      'Weather Forecast',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),

                    // this renders all widget at once, so if there are many widgets, it will be slow, use ListView.builder instead
                    // SingleChildScrollView(
                    //   padding: EdgeInsets.symmetric(horizontal: 5),
                    //   scrollDirection: Axis.horizontal,
                    //   child: Row(
                    //     spacing: 10,
                    //     children: [
                    //       ...forecastList.map(
                    //         (e) => ForecastCard(
                    //           icon: e['weather'][0]['main'] == 'Clouds'
                    //               ? Icons.cloud
                    //               : e['weather'][0]['main'] == 'Rain'
                    //               ? Icons.sunny_snowing
                    //               : e['weather'][0]['main'] == 'Snow'
                    //               ? Icons.snowing
                    //               : Icons.sunny,
                    //           time: DateFormat.j().format(
                    //             DateTime.parse(e['dt_txt']),
                    //           ),
                    //           // time: DateFormat('h:mm a').format(DateTime.parse(e['dt_txt'])),
                    //           // time: e['dt_txt'].split(' ')[1],
                    //           temperature:
                    //               '${((e['main']['temp']) - 273.15).toStringAsFixed(0)}°C',
                    //           dateTime: DateFormat(
                    //             'dd-MMM',
                    //           ).format(DateTime.parse(e['dt_txt'])),
                    //           // dateTime: DateTime.parse(e['dt_txt']),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    SizedBox(
                      height: 100,
                      // width: double.infinity,
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        itemCount: forecastList.length,
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => SizedBox(width: 10),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => ForecastCard(
                          icon:
                              forecastList[index]['weather'][0]['main'] ==
                                  'Clouds'
                              ? Icons.cloud
                              : forecastList[index]['weather'][0]['main'] ==
                                    'Rain'
                              ? Icons.sunny_snowing
                              : forecastList[index]['weather'][0]['main'] ==
                                    'Snow'
                              ? Icons.snowing
                              : Icons.sunny,
                          time: DateFormat.j().format(
                            DateTime.parse(forecastList[index]['dt_txt']),
                          ),
                          temperature:
                              '${((forecastList[index]['main']['temp']) - 273.15).toStringAsFixed(0)}°C',
                          dateTime: DateFormat('dd-MMM').format(
                            DateTime.parse(forecastList[index]['dt_txt']),
                          ),
                        ),
                      ),
                    ),
                    // ListView.builder(
                    //   itemCount: 100,
                    //   itemBuilder: (context, index) =>
                    //       ListTile(title: Text('Item $index')),
                    // ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    Text(
                      'Additional Information',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        AdditionalInfoCard(
                          icon: Icons.water_drop,
                          label: 'Humadity',
                          value: '$humidity%',
                        ),
                        AdditionalInfoCard(
                          icon: Icons.air,
                          label: 'Wind',
                          value: '$windSpeed km/h',
                        ),
                        AdditionalInfoCard(
                          icon: Icons.dew_point,
                          label: 'Pressure',
                          value: '$pressure hPa',
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
