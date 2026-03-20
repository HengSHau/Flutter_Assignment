import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_assignment/features/finance/viewmodels/finance_dailyReport_viewmodel.dart';

class FinanceDailyView extends StatefulWidget {
  const FinanceDailyView({super.key});

  @override
  State<FinanceDailyView> createState() => FinanceDailyViewState();
}

class FinanceDailyViewState extends State<FinanceDailyView> {
  final vm = FinanceDailyViewModel();

  @override
  void initState() {
    super.initState();
    vm.addListener(_refresh);
  }

  @override
  void dispose() {
    vm.removeListener(_refresh);
    super.dispose();
  }

  void _refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OutlinedButton(
            onPressed: () => vm.pickDateRange(context),
            child: const Text('Select Date Range'),
          ),

          const SizedBox(height: 12),

          Text(
            vm.rangeText,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 20),
          
          Expanded(
            child: vm.chartData.isEmpty
                ? const Center(
                    child: Text('No data available'),
                  )
                : BarChart(
                    BarChartData(
                      maxY: 200,
                      borderData: FlBorderData(show: false),
                      gridData: FlGridData(show: true),
                      titlesData: FlTitlesData(
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: true),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              final index = value.toInt();
                              if (index < 0 || index >= vm.chartData.length) {
                                return const SizedBox.shrink();
                              }
                              return Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  vm.chartData[index].label,
                                  style: const TextStyle(fontSize: 10),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      barGroups: List.generate(
                        vm.chartData.length,
                        (index) => BarChartGroupData(
                          x: index,
                          barRods: [
                            BarChartRodData(
                              toY: vm.chartData[index].value,
                              width: 18,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
