import 'package:flutter/material.dart';
import 'package:flutter_assignment/features/admin/viewmodels/admin_functionPage_viewmodel.dart';
import 'package:flutter_assignment/features/admin/views/admin_addStaff_view.dart';
import 'package:flutter_assignment/features/admin/views/admin_editStaff_view.dart';
import 'package:flutter_assignment/features/admin/views/admin_viewReport_view.dart';
import 'package:flutter_assignment/features/admin/views/admin_viewFeedback_view.dart';

class AdminFunctionPage extends StatefulWidget {
  const AdminFunctionPage({super.key});

  @override
  State<AdminFunctionPage> createState() =>
      _AdminFunctionPageState();
}

class _AdminFunctionPageState extends State<AdminFunctionPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final vm = AdminFunctionViewModel();

  final List<Widget> pages = const [
    AdminAddStaff(),
    AdminEditStaff(),
    AdminViewReport(),
    AdminViewFeedback()
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