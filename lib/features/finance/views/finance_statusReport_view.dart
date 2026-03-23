import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../models/finance_sessionData_model.dart';
import '../viewmodels/finance_statusReport_viewmodel.dart';

class FinanceStatusPage extends StatefulWidget {
  const FinanceStatusPage({super.key});

  @override
  State<FinanceStatusPage> createState() =>
      _FinanceStatusReportPageState();
}

class _FinanceStatusReportPageState extends State<FinanceStatusPage> {
  final vm = FinanceStatusReportViewData();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: StreamBuilder<List<FinanceSessionData>>(
        stream: vm.getBookedSessions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          final sessions = snapshot.data ?? [];

          if (sessions.isEmpty) {
            return const Center(
              child: Text('No data available'),
            );
          }

          final completedTotal = vm.getCompletedTotal(sessions);
          final upcomingTotal = vm.getUpcomingTotal(sessions);
          final upcomingSessions = vm.getUpcomingSessions(sessions);
          final total = completedTotal + upcomingTotal;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Session Status Report',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              SizedBox(
                height: 260,
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: PieChart(
                        PieChartData(
                          centerSpaceRadius: 36,
                          sectionsSpace: 2,
                          sections: [
                            PieChartSectionData(
                              value: completedTotal <= 0 ? 0.01 : completedTotal,
                              title: total == 0
                                  ? '0%'
                                  : '${((completedTotal / total) * 100).toStringAsFixed(1)}%',
                              radius: 70,
                            ),
                            PieChartSectionData(
                              value: upcomingTotal <= 0 ? 0.01 : upcomingTotal,
                              title: total == 0
                                  ? '0%'
                                  : '${((upcomingTotal / total) * 100).toStringAsFixed(1)}%',
                              radius: 70,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLegendItem(
                            label: 'Completed',
                            value: completedTotal,
                          ),
                          const SizedBox(height: 16),
                          _buildLegendItem(
                            label: 'Upcoming',
                            value: upcomingTotal,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              Text(
                'Upcoming Sessions',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),

              Expanded(
                child: upcomingSessions.isEmpty
                    ? const Center(
                        child: Text('No upcoming session'),
                      )
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SingleChildScrollView(
                          child: DataTable(
                            columns: const [
                              DataColumn(label: Text('Title')),
                              DataColumn(label: Text('Category')),
                              DataColumn(label: Text('Tutor')),
                              DataColumn(label: Text('Price')),
                              DataColumn(label: Text('Scheduled Time')),
                            ],
                            rows: upcomingSessions.map((item) {
                              return DataRow(
                                cells: [
                                  DataCell(Text(item.title)),
                                  DataCell(Text(item.category)),
                                  DataCell(Text(item.tutorName)),
                                  DataCell(Text(item.price.toStringAsFixed(2))),
                                  DataCell(Text(vm.formatDateTime(item.scheduledTime))),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLegendItem({
    required String label,
    required double value,
  }) {
    return Row(
      children: [
        const SizedBox(
          width: 14,
          height: 14,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.black12,
              shape: BoxShape.circle,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text('$label: RM ${value.toStringAsFixed(2)}'),
        ),
      ],
    );
  }
}