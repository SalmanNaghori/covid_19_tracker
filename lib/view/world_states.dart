// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

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

  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 5),
        () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => WorldStateScreen())));
  }

  final colorList = <Color>[
    Colors.blue,
    Colors.green,
    Colors.red,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            PieChart(
              chartRadius: MediaQuery.of(context).size.width / 3.2,
              legendOptions: LegendOptions(legendPosition: LegendPosition.left),
              dataMap: {"Total": 20, "Recovered": 55, "Deaths": 5},
              animationDuration: const Duration(milliseconds: 1200),
              chartType: ChartType.ring,
              colorList: colorList,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.06),
              child: Card(
                child: Column(children: [
                  ReusableRow(title: "total", value: '200'),
                  ReusableRow(title: "total", value: '200'),
                  ReusableRow(title: "total", value: '200'),
                ]),
              ),
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                  color: Color(0xff1aa260),
                  borderRadius: BorderRadius.circular(10)),
              child: const Center(
                child: Text('Track Countires'),
              ),
            )
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
