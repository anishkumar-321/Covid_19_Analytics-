import 'dart:ui';

import 'package:covid19_tracker/model/worldstates_model.dart';
import 'package:covid19_tracker/screen/countries_list.dart';
import 'package:covid19_tracker/services/states_services.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:simple_list_tile/simple_list_tile.dart';

class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({super.key});

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 10), vsync: this)
        ..repeat();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final colorList = const <Color>[
    Color(0xffc77e18),
    Color(0xff7a1ce6),
    Color(0xffdeeb34),
    Color(0xff18c7b3),
  ];

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color.fromARGB(36, 255, 67, 10), Colors.black],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  FutureBuilder(
                    future: statesServices.fetchWorldStatesRecords(),
                    builder:
                        (context, AsyncSnapshot<WorldStatesModel> snapshot) {
                      if (!snapshot.hasData) {
                        return SizedBox(
                          // color: Colors.black,
                          height: size.height,
                          width: size.width,
                          child: Center(
                            child: SpinKitFadingCircle(
                              color: Colors.white,
                              size: 50,
                              controller: _controller,
                            ),
                          ),
                        );
                      } else {
                        return Column(
                          children: [
                            PieChart(
                              dataMap: {
                                'Total': double.parse(
                                    snapshot.data!.cases.toString()),
                                'Recovered': double.parse(
                                    snapshot.data!.recovered.toString()),
                                'Cases': double.parse(
                                    snapshot.data!.cases.toString()),
                                'Active': double.parse(
                                    snapshot.data!.active.toString()),
                              },
                              chartValuesOptions: const ChartValuesOptions(
                                // showChartValuesInPercentage: true,
                                // chartValueBackgroundColor:
                                //     const Color.fromARGB(255, 0, 0, 0),
                                // chartValueStyle: const TextStyle(
                                //   fontWeight: FontWeight.bold,
                                //   color: Colors.white,
                                //   fontSize: 15,
                                // ),
                                // decimalPlaces: 0,
                                // showChartValuesOutside: true,
                                // showChartValueBackground: false,
                                showChartValues: false,
                              ),
                              animationDuration:
                                  const Duration(milliseconds: 3000),
                              chartType: ChartType.disc,
                              colorList: colorList,
                              legendOptions: const LegendOptions(
                                showLegendsInRow: true,
                                legendPosition: LegendPosition.bottom,
                              ),
                              chartRadius: 150,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.001,
                                // bottom:
                                //     MediaQuery.of(context).size.height * 0.03,
                              ),
                              child: Column(
                                children: [
                                  ReusableRow(
                                      title: 'Cases',
                                      value: snapshot.data!.cases.toString()),
                                  ReusableRow(
                                      title: 'Deaths',
                                      value: snapshot.data!.deaths.toString()),
                                  ReusableRow(
                                      title: 'Recovered',
                                      value:
                                          snapshot.data!.recovered.toString()),
                                  ReusableRow(
                                      title: 'Active',
                                      value: snapshot.data!.active.toString()),
                                  ReusableRow(
                                      title: 'Critical',
                                      value:
                                          snapshot.data!.critical.toString()),
                                  ReusableRow(
                                      title: 'Deaths Today',
                                      value: snapshot.data!.todayDeaths
                                          .toString()),
                                  ReusableRow(
                                      title: 'Recovered Today',
                                      value: snapshot.data!.todayRecovered
                                          .toString()),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 15.0,
                                bottom: 20,
                              ),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const CountriesList(),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: size.width * 0.7,
                                  height: size.height * 0.06,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Colors.black,
                                        Color.fromARGB(36, 255, 67, 10)
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white.withOpacity(0.2),
                                        blurRadius: 5,
                                        spreadRadius: 2,
                                        offset: const Offset(3, 6),
                                      ),
                                    ],
                                  ),
                                  child: const Center(
                                      child: Text('Country Stats')),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  final String title;
  final String value;

  const ReusableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text(title),
          //     Text(value),
          //   ],
          // ),
          // ListTile(
          //   leading: Text(title),
          //   trailing: Text(value),
          //   horizontalTitleGap: 0.2,
          //   leadingAndTrailingTextStyle:
          //       const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),

          // ),
          SimpleListTile(
            onTap: null,
            title: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            subtitle: Text(
              value,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            leading: Image.asset('images/corona.png'),
            borderRadius: BorderRadius.circular(20),
            tileColor: Colors.grey[300]!,
            circleColor: Colors.black,
            circleDiameter: 200,
            gradient: const LinearGradient(
              colors: [Colors.black, Color.fromARGB(36, 255, 67, 10)],
            ),
          ),
          // const SizedBox(height: 5),
          // const Divider(),
        ],
      ),
    );
  }
}
