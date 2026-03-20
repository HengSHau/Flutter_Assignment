import 'package:flutter/material.dart';
import 'package:flutter_assignment/features/finance/viewmodels/finance_functionPage_viewmodel.dart';

class FinanceMonthlyView extends StatefulWidget {
  const FinanceMonthlyView({super.key});

  @override
  State<FinanceMonthlyView> createState() => FinanceMonthlyViewState();
}

class FinanceMonthlyViewState extends State<FinanceMonthlyView> {
  final FinanceFunctionViewModel viewModel = FinanceFunctionViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: Text("Monthly"),
      ),
    );
  }
}