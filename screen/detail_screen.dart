import 'package:covid19_tracker/screen/world_states.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  final String image;
  final String name;
  final int totalCases,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      todayRecovered,
      test;

  const DetailsScreen({
    super.key,
    required this.name,
    required this.image,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.test,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
        elevation: 0,
        // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color.fromARGB(36, 255, 67, 10), Colors.black],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.067),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.06),
                              ReusableRow(
                                  title: 'Cases',
                                  value: widget.totalCases.toString()),

                              ReusableRow(
                                  title: 'Deaths',
                                  value: widget.totalDeaths.toString()),

                              ReusableRow(
                                  title: 'Recovered',
                                  value: widget.totalRecovered.toString()),

                              ReusableRow(
                                  title: 'Active',
                                  value: widget.active.toString()),

                              ReusableRow(
                                  title: 'Critical',
                                  value: widget.critical.toString()),

                              ReusableRow(
                                  title: 'Recovered Today',
                                  value: widget.todayRecovered.toString()),

                              ReusableRow(
                                  title: 'Tests Conducted',
                                  value: widget.test.toString()),
                              // const Divider(),
                            ],
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(widget.image),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
