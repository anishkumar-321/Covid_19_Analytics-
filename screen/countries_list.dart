import 'package:covid19_tracker/screen/detail_screen.dart';
import 'package:covid19_tracker/services/states_services.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color.fromARGB(36, 255, 67, 10), Colors.black],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {});
                  },
                  controller: searchController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    hintText: 'Search with country name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: statesServices.countriesListApi(),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                    if (!snapshot.hasData) {
                      return ListView.builder(
                        itemCount: 8,
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey.shade700,
                            highlightColor: Colors.grey.shade100,
                            // highlightColor: Colors.yellow,
                            child: Column(
                              children: [
                                ListTile(
                                  title: Container(
                                    height: 10,
                                    width: 80,
                                    color: Colors.white,
                                  ),
                                  subtitle: Container(
                                    height: 10,
                                    width: 80,
                                    color: Colors.white,
                                  ),
                                  leading: Container(
                                    height: 50,
                                    width: 50,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          );
                          // return
                        },
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          String name = snapshot.data![index]['country'];
                          if (searchController.text.isEmpty) {
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailsScreen(
                                          name: snapshot.data![index]
                                              ['country'],
                                          image: snapshot.data![index]
                                              ['countryInfo']['flag'],
                                          totalCases: snapshot.data![index]
                                              ['cases'],
                                          totalDeaths: snapshot.data![index]
                                              ['deaths'],
                                          totalRecovered: snapshot.data![index]
                                              ['recovered'],
                                          active: snapshot.data![index]
                                              ['active'],
                                          critical: snapshot.data![index]
                                              ['critical'],
                                          todayRecovered: snapshot.data![index]
                                              ['todayRecovered'],
                                          test: snapshot.data![index]['tests'],
                                        ),
                                      ),
                                    );
                                  },
                                  child: ListTile(
                                    title:
                                        Text(snapshot.data![index]['country']),
                                    subtitle: Text(snapshot.data![index]
                                            ['cases']
                                        .toString()),
                                    leading: Image(
                                      height: 50,
                                      width: 50,
                                      image: NetworkImage(snapshot.data![index]
                                          ['countryInfo']['flag']),
                                    ),
                                  ),
                                )
                              ],
                            );
                          } else if (name
                              .toLowerCase()
                              .contains(searchController.text.toLowerCase())) {
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailsScreen(
                                          name: snapshot.data![index]
                                              ['country'],
                                          image: snapshot.data![index]
                                              ['countryInfo']['flag'],
                                          totalCases: snapshot.data![index]
                                              ['cases'],
                                          totalDeaths: snapshot.data![index]
                                              ['deaths'],
                                          totalRecovered: snapshot.data![index]
                                              ['recovered'],
                                          active: snapshot.data![index]
                                              ['active'],
                                          critical: snapshot.data![index]
                                              ['critical'],
                                          todayRecovered: snapshot.data![index]
                                              ['todayRecovered'],
                                          test: snapshot.data![index]['tests'],
                                        ),
                                      ),
                                    );
                                  },
                                  child: ListTile(
                                    title:
                                        Text(snapshot.data![index]['country']),
                                    subtitle: Text(snapshot.data![index]
                                            ['cases']
                                        .toString()),
                                    leading: Image(
                                      height: 50,
                                      width: 50,
                                      image: NetworkImage(snapshot.data![index]
                                          ['countryInfo']['flag']),
                                    ),
                                  ),
                                )
                              ],
                            );
                          } else {
                            return Container();
                          }
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
