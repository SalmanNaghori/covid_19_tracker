import 'package:cached_network_image/cached_network_image.dart';
import 'package:covid_19_tracker/services/states_services.dart';
import 'package:covid_19_tracker/view/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({super.key});

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: TextFormField(
              controller: searchController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  hintText: 'Search With Country Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0))),
            ),
          ),
          Expanded(
              child: FutureBuilder(
            future: stateServices.CountriesListApi(),
            builder: ((context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (!snapshot.hasData) {
                return ListView.builder(
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
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
                          baseColor: Colors.grey.shade700,
                          highlightColor: Colors.grey.shade100);
                    });
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    String name = snapshot.data![index]['country'];

                    if (searchController.text.isEmpty) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailsScreen(
                                        name: snapshot.data![index]['country'],
                                        image: snapshot.data![index]
                                            ['countryInfo']['flag'],
                                        active: snapshot.data![index]['active'],
                                        totalCases: snapshot.data![index]
                                            ['cases'],
                                        todayRecovered: snapshot.data![index]
                                            ['todayRecovered'],
                                        totalDeaths: snapshot.data![index]
                                            ['deaths'],
                                        test: snapshot.data![index]['test'],
                                        critical: snapshot.data![index]
                                            ['critical'],
                                        totalRecovered: snapshot.data![index]
                                            ['eecovered'],
                                      )));
                        },
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(snapshot.data![index]['country']),
                              subtitle: Text(
                                  snapshot.data![index]['cases'].toString()),
                              leading: CachedNetworkImage(
                                imageUrl: snapshot.data![index]['countryInfo']
                                    ['flag'],
                                placeholder: (context, url) =>
                                    const CircleAvatar(
                                  radius: 50,
                                  backgroundImage:
                                      AssetImage('assets/images/clip.png'),
                                ),
                                imageBuilder: (context, imageProvider) =>
                                    CircleAvatar(
                                  radius: 50,
                                  backgroundImage: imageProvider,
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                                fit: BoxFit.cover,
                              ),
                            )
                          ],
                        ),
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
                                            active: snapshot.data![index]
                                                ['active'],
                                            totalCases: snapshot.data![index]
                                                ['cases'],
                                            todayRecovered: snapshot
                                                .data![index]['todayRecovered'],
                                            totalDeaths: snapshot.data![index]
                                                ['deaths'],
                                            test: snapshot.data![index]['test'],
                                            critical: snapshot.data![index]
                                                ['critical'],
                                            totalRecovered: snapshot
                                                .data![index]['eecovered'],
                                          )));
                            },
                            child: ListTile(
                                title: Text(snapshot.data![index]['country']),
                                subtitle: Text(
                                    snapshot.data![index]['cases'].toString()),
                                leading: CachedNetworkImage(
                                  imageUrl: snapshot.data![index]['countryInfo']
                                      ['flag'],
                                  placeholder: (context, url) =>
                                      const CircleAvatar(
                                    radius: 50,
                                    backgroundImage:
                                        AssetImage('assets/images/clip.png'),
                                  ),
                                  imageBuilder: (context, imageProvider) =>
                                      CircleAvatar(
                                    radius: 50,
                                    backgroundImage: imageProvider,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                  fit: BoxFit.cover,
                                )),
                          )
                        ],
                      );
                    } else {
                      return Container();
                    }
                  },
                );
              }
            }),
          ))
        ],
      )),
    );
  }
}
