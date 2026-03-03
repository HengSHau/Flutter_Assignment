import 'package:flutter/material.dart';
import 'package:flutter_assignment/features/customer/viewmodels/customer_functionPage_viewmodel.dart';
import 'package:flutter_assignment/features/customer/views/customer_discover_view.dart';
import 'package:flutter_assignment/features/customer/views/customer_mycourse_view.dart';

class CustomerFunctionPage extends StatefulWidget {
  const CustomerFunctionPage({super.key});

  @override
  State<CustomerFunctionPage> createState() =>
      _CustomerFunctionPageState();
}

class _CustomerFunctionPageState extends State<CustomerFunctionPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final vm = CustomerFunctionViewModel();

  final List<Widget> pages = const [
    CustomerDiscoverView(),
    CustomerMyCourseView(),
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