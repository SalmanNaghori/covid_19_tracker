// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:covid_19_tracker/view/world_states.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  String image;
  String name;
  int? totalRecovered, active, critical, todayRecovered, test;
  int? totalCases, totalDeaths;
  DetailsScreen({
    Key? key,
    required this.image,
    required this.name,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.test,
  })  : assert(totalCases != null),
        assert(totalDeaths != null),
        assert(totalRecovered != null),
        assert(active != null),
        assert(critical != null),
        assert(todayRecovered != null),
        assert(test != null);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                      ),
                      if (widget.totalCases != null)
                        ReusableRow(
                          title: 'Cases',
                          value: widget.totalCases.toString(),
                        ),
                      if (widget.totalRecovered != null)
                        ReusableRow(
                          title: 'Recovered',
                          value: widget.totalRecovered.toString(),
                        ),
                      if (widget.totalDeaths != null)
                        ReusableRow(
                          title: 'Death',
                          value: widget.totalDeaths.toString(),
                        ),
                      if (widget.critical != null)
                        ReusableRow(
                          title: 'Critical',
                          value: widget.critical.toString(),
                        ),
                      if (widget.todayRecovered != null)
                        ReusableRow(
                          title: 'Today Recoverd',
                          value: widget.todayRecovered.toString(),
                        ),
                      if (widget.active != null)
                        ReusableRow(
                          title: 'Active Cases',
                          value: widget.active.toString(),
                        ),
                      if (widget.test != null)
                        ReusableRow(
                          title: 'Test',
                          value: widget.test.toString(),
                        ),
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
    );
  }
}
