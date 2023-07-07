import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:net_world_international/application/loginBloc/login_bloc.dart';
import 'package:net_world_international/core/color_manager.dart';
import 'package:net_world_international/core/styles_manager.dart';
import 'package:circle_progress_bar/circle_progress_bar.dart';
import 'package:net_world_international/presentation/widget/scale_up_animation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<LoginBloc>(context).add(
      HomePageEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final endPoint = Hive.box("url").get('endpoint');
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Image.asset(
                'assets/header.png',
                fit: BoxFit.contain,
                width: size.width,
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 10),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.arrow_back_ios,
                          size: 10,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Dashboard",
                          style: getMediumtStyle(
                              color: Colors.white, fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      if (state is HomePageState) {
                        return SizedBox(
                          height: 60,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ScaleUpAnimation(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30, right: 30),
                                  child: Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            "$endPoint/${state.userModel?.photoPath}"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // const SizedBox(
                              //   width: 15,
                              // ),
                              ScaleUpAnimation(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.userModel?.name ?? '',
                                      style: getMediumtStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                    Text(
                                      "In publishing and graphic design,",
                                      style: getLightStyle(
                                          color: Colors.white, fontSize: 7),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      }
                      return Container();
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Container(
                      // height: size.height * .4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colormanager.background,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        border: Border.all(
                          width: 1,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 15),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Gross Volume",
                                  style: getMediumtStyle(
                                      color: Colors.grey, fontSize: 9),
                                ),
                                const Icon(Icons.filter_list)
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "\$10.05k",
                                  style: getMediumtStyle(
                                      color: Colormanager.textColor,
                                      fontSize: 15),
                                )
                              ],
                            ),
                            const LineChartSample2(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: size.width * .39,
                          height: 170,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            border: Border.all(
                              width: 1,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 0),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    "Incomes",
                                    style: getMediumtStyle(
                                        color: Colormanager.textColor,
                                        fontSize: 9),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    width: 80,
                                    height: 80,
                                    child: CircleProgressBar(
                                      foregroundColor: Colormanager.primary,
                                      backgroundColor: Colormanager.secondary,
                                      strokeWidth: 8,
                                      value: 0.65,
                                      child: Center(
                                        child: Text(
                                          "65%",
                                          style: getSemiBoldStyle(
                                              color: Colormanager.textColor,
                                              fontSize: 15),
                                        ),
                                      ),
                                      // child: AnimatedCount(
                                      //   count: 0.5,
                                      //   unit: '',
                                      //   duration: Duration(milliseconds: 500),
                                      // ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'In publishing and graphic design,Lorem ipsum is a placeholder text commonlyused to demonstrate the visual.',
                                    style: getLightStyle(
                                        color: Colormanager.textColor,
                                        fontSize: 5),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: size.width * .39,
                          height: 170,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            border: Border.all(
                              width: 1,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 0),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    "Expenses",
                                    style: getMediumtStyle(
                                        color: Colormanager.textColor,
                                        fontSize: 9),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    width: 80,
                                    height: 80,
                                    child: CircleProgressBar(
                                      foregroundColor: Colormanager.primary,
                                      backgroundColor: Colormanager.secondary,
                                      strokeWidth: 8,
                                      value: 0.20,
                                      child: Center(
                                        child: Text(
                                          "20%",
                                          style: getSemiBoldStyle(
                                              color: Colormanager.textColor,
                                              fontSize: 15),
                                        ),
                                      ),
                                      // child: AnimatedCount(
                                      //   count: 0.5,
                                      //   unit: '',
                                      //   duration: Duration(milliseconds: 500),
                                      // ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'In publishing and graphic design,Lorem ipsum is a placeholder text commonlyused to demonstrate the visual.',
                                    style: getLightStyle(
                                        color: Colormanager.textColor,
                                        fontSize: 5),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LineChartSample2 extends StatefulWidget {
  const LineChartSample2({super.key});

  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [
    const Color(0xff2C8CF4),
    const Color(0xff2C8CF4),
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 10,
            ),
            child: LineChart(
              mainData(),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    TextStyle style =
        getRegularStyle(color: Colormanager.textColor, fontSize: 9);
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Text('2023', style: style);
        break;
      case 2:
        text = Text('2022', style: style);
        break;
      case 4:
        text = Text('2021', style: style);
        break;
      case 6:
        text = Text('2020', style: style);
        break;
      case 8:
        text = Text('2019', style: style);
        break;
      case 10:
        text = Text('2018', style: style);
        break;

      default:
        text = Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    TextStyle style = const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '';
        break;
      case 3:
        text = '';
        break;
      case 5:
        text = '';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: false,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colormanager.primary,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Colormanager.primary,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 12,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 10,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: [
            const FlSpot(0, 5),
            const FlSpot(2.6, 2),
            const FlSpot(4.9, 5),
            const FlSpot(6.8, 3.1),
            const FlSpot(8, 4),
            const FlSpot(9, 3),
            const FlSpot(10, 4),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 1,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.15))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  // LineChartData avgData() {
  //   return LineChartData(
  //     lineTouchData: LineTouchData(enabled: false),
  //     gridData: FlGridData(
  //       show: true,
  //       drawHorizontalLine: true,
  //       verticalInterval: 1,
  //       horizontalInterval: 1,
  //       getDrawingVerticalLine: (value) {
  //         return FlLine(
  //           color: const Color(0xff37434d),
  //           strokeWidth: 1,
  //         );
  //       },
  //       getDrawingHorizontalLine: (value) {
  //         return FlLine(
  //           color: const Color(0xff37434d),
  //           strokeWidth: 1,
  //         );
  //       },
  //     ),
  //     titlesData: FlTitlesData(
  //       show: true,
  //       bottomTitles: AxisTitles(
  //         sideTitles: SideTitles(
  //           showTitles: true,
  //           reservedSize: 30,
  //           getTitlesWidget: bottomTitleWidgets,
  //           interval: 1,
  //         ),
  //       ),
  //       leftTitles: AxisTitles(
  //         sideTitles: SideTitles(
  //           showTitles: true,
  //           getTitlesWidget: leftTitleWidgets,
  //           reservedSize: 42,
  //           interval: 1,
  //         ),
  //       ),
  //       topTitles: AxisTitles(
  //         sideTitles: SideTitles(showTitles: false),
  //       ),
  //       rightTitles: AxisTitles(
  //         sideTitles: SideTitles(showTitles: false),
  //       ),
  //     ),
  //     borderData: FlBorderData(
  //       show: true,
  //       border: Border.all(color: Colormanager.primary),
  //     ),
  //     minX: 0,
  //     maxX: 11,
  //     minY: 0,
  //     maxY: 6,
  //     lineBarsData: [
  //       LineChartBarData(
  //         spots: [
  //           const FlSpot(0, 3.44),
  //           const FlSpot(2.6, 3.44),
  //           const FlSpot(4.9, 3.44),
  //           const FlSpot(6.8, 3.44),
  //           const FlSpot(8, 3.44),
  //           const FlSpot(9.5, 3.44),
  //           const FlSpot(11, 3.44),
  //         ],
  //         isCurved: true,
  //         gradient: LinearGradient(
  //           colors: [
  //             ColorTween(begin: gradientColors[0], end: gradientColors[1])
  //                 .lerp(0.2)!,
  //             ColorTween(begin: gradientColors[0], end: gradientColors[1])
  //                 .lerp(0.2)!,
  //           ],
  //         ),
  //         barWidth: 5,
  //         isStrokeCapRound: true,
  //         dotData: FlDotData(
  //           show: false,
  //         ),
  //         belowBarData: BarAreaData(
  //           show: true,
  //           gradient: LinearGradient(
  //             colors: [
  //               ColorTween(begin: gradientColors[0], end: gradientColors[1])
  //                   .lerp(0.2)!
  //                   .withOpacity(0.1),
  //               ColorTween(begin: gradientColors[0], end: gradientColors[1])
  //                   .lerp(0.2)!
  //                   .withOpacity(0.1),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
