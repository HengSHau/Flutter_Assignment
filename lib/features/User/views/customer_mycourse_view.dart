import 'package:flutter/material.dart';
import 'package:flutter_assignment/features/customer/viewmodels/customer_functionPage_viewmodel.dart';
import 'package:flutter_assignment/features/customer/views/customer_recommendationCard_view.dart';

class CustomerMyCourseView extends StatefulWidget {
  const CustomerMyCourseView({super.key});

  @override
  State<CustomerMyCourseView> createState() => CustomerMyCourseViewState();
}

class CustomerMyCourseViewState extends State<CustomerMyCourseView> {
  final CustomerFunctionViewModel viewModel = CustomerFunctionViewModel();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        RecommendationCard(
          username: '秦始皇',
          price: 'RM50',
        ),
        RecommendationCard(
          username: 'Ah Huat',
          price: 'RM670'
        )
      ]
    );
  }
}