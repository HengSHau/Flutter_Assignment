import 'package:flutter/material.dart';
import 'package:flutter_assignment/features/finance/viewmodels/finance_functionPage_viewmodel.dart';

class FinanceYearlyView extends StatefulWidget {
  const FinanceYearlyView({super.key});

  @override
  State<FinanceYearlyView> createState() => FinanceYearlyViewState();
}

class FinanceYearlyViewState extends State<FinanceYearlyView> {
  final FinanceFunctionViewModel viewModel = FinanceFunctionViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: Text("Yearly"),
      ),
    );
  }
}