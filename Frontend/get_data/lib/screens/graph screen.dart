import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get_data/core/services/api_service.dart';

class SawtoothGraph extends StatefulWidget {
  @override
  _SawtoothGraphState createState() => _SawtoothGraphState();
}

class _SawtoothGraphState extends State<SawtoothGraph> {
  List<FlSpot> _graphData = [];
  Timer? _timer;
  int counter = 0;
  int reqNum = 0;
  final int maxRequests = 7;

  @override
  void initState() {
    super.initState();
    fetchData(); // Fetch initial data
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (reqNum < maxRequests) {
        fetchData();
      } else {
        _timer?.cancel(); // Stop the timer after reaching max requests
      }
    });
  }

  Future<void> fetchData() async {
    try {
      final waveData = await SawtoothService.fetchSawtoothWave(counter);
      if (waveData.isNotEmpty) {
        setState(() {
          // Add all points from the response to the graph
          for (var dataPoint in waveData) {
            _graphData.add(FlSpot(
              dataPoint["timestamp"].toDouble(),
              dataPoint["amplitude"].toDouble(),
            ));
          }
        });
        counter += 3; // Increment counter after each request
        reqNum++;
      }
    } catch (e) {
      reqNum = maxRequests; // Stop the timer if an error occurs
      print("Error fetching data: $e");
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        child: Icon(Icons.arrow_back),
      ),
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: _graphData.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 10),
                    Text("No Data at this moment, sorry"),
                  ],
                ),
              ) // Show loader if data is empty
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sawtooth Waveform",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 477,
                    child: LineChart(
                      LineChartData(
                        gridData: FlGridData(show: true),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            axisNameWidget: Text(
                              "Amplitude",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 40,
                              getTitlesWidget: (value, meta) {
                                return Text(
                                  value.toStringAsFixed(1),
                                  style: TextStyle(fontSize: 12),
                                );
                              },
                            ),
                          ),
                          bottomTitles: AxisTitles(
                            axisNameWidget: Padding(
                              padding: const EdgeInsets.only(top: 1.0),
                              child: Text(
                                "Time (seconds)",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 30,
                              getTitlesWidget: (value, meta) {
                                return Text(
                                  value.toStringAsFixed(1),
                                  style: TextStyle(fontSize: 12),
                                );
                              },
                            ),
                          ),
                          rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                          topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                        ),
                        borderData: FlBorderData(show: true),
                        lineBarsData: [
                          LineChartBarData(
                            spots: _graphData,
                            isCurved: false,
                            color: Colors.blue,
                            barWidth: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
