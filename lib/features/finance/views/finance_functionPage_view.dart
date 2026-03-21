import 'package:flutter/material.dart';
import 'package:flutter_assignment/features/finance/viewmodels/finance_functionPage_viewmodel.dart';
import 'package:flutter_assignment/features/finance/views/finance_dailyReport_view.dart';
import 'package:flutter_assignment/features/finance/views/finance_monthlyReport_view.dart';
import 'package:flutter_assignment/features/finance/views/finance_yearlyReport_view.dart';

class FinanceFunctionPage extends StatefulWidget {
  const FinanceFunctionPage({super.key});

  @override
  State<FinanceFunctionPage> createState() =>
      _FinanceFunctionPageState();
}

class _FinanceFunctionPageState extends State<FinanceFunctionPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final vm = FinanceFunctionViewModel();

  final List<Widget> pages = const [
    FinanceDailyView(),
    FinanceMonthlyView(),
    FinanceYearlyView()
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: vm.tabs.length,
      vsync: this,
    );

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          vm.changeTab(_tabController.index);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          tabs: vm.tabs.map((t) => Tab(text: t)).toList(),
        ),

        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: pages,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}