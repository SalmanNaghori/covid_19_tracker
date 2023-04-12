// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:covid_19_tracker/services/states_services.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

import '../model/world_state_model.dart';

class WorldStateScreen extends StatefulWidget {
  const WorldStateScreen({super.key});

  @override
  State<WorldStateScreen> createState() => _WorldStateScreenState();
}

class _WorldStateScreenState extends State<WorldStateScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    Colors.blue,
    Colors.green,
    Colors.red,
  ];

  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            FutureBuilder(
                future: stateServices.fecthWorldStateRecords(),
                builder: (context, AsyncSnapshot<WorldStateModel> snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50.0,
                        controller: _controller,
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        PieChart(
                          chartRadius: MediaQuery.of(context).size.width / 3.2,
                          legendOptions: LegendOptions(
                              legendPosition: LegendPosition.left),
                          dataMap: {
                            "Total":
                                double.parse(snapshot.data!.cases!.toString()),
                            "Recovered": double.parse(
                                snapshot.data!.recovered.toString()),
                            "Deaths":
                                double.parse(snapshot.data!.deaths.toString()),
                          },
                          chartValuesOptions: ChartValuesOptions(
                              showChartValuesInPercentage: true),
                          animationDuration: const Duration(milliseconds: 1200),
                          chartType: ChartType.ring,
                          colorList: colorList,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * 0.06),
                          child: Card(
                            child: Column(children: [
                              ReusableRow(
                                  title: "total",
                                  value: snapshot.data!.cases.toString()),
                              ReusableRow(
                                  title: "Deaths",
                                  value: snapshot.data!.deaths.toString()),
                              ReusableRow(
                                  title: "Recovered",
                                  value: snapshot.data!.recovered.toString()),
                              ReusableRow(
                                  title: "Active",
                                  value: snapshot.data!.active.toString()),
                              ReusableRow(
                                  title: "Critical",
                                  value: snapshot.data!.critical.toString()),
                              ReusableRow(
                                  title: "Today Deaths",
                                  value: snapshot.data!.todayDeaths.toString()),
                              ReusableRow(
                                  title: "Today Recovered",
                                  value:
                                      snapshot.data!.todayRecovered.toString()),
                              ReusableRow(
                                  title: "Today Cases",
                                  value: snapshot.data!.todayCases.toString()),
                            ]),
                          ),
                        ),
                        GestureDetector(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: Color(0xff1aa260),
                                borderRadius: BorderRadius.circular(10)),
                            child: const Center(
                              child: Text('Track Countires'),
                            ),
                          ),
                        )
                      ],
                    );
                  }
                }),
          ],
        ),
      ),
    ));
  }
}

class ReusableRow extends StatelessWidget {
  final String title, value;
  ReusableRow({Key? key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Divider(),
        ],
      ),
    );
  }
}
