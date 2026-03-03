import 'package:flutter/material.dart';
import 'package:flutter_assignment/features/customer/viewmodels/customer_functionPage_viewmodel.dart';
import 'package:flutter_assignment/features/customer/views/customer_recommendationCard_view.dart';

class CustomerDiscoverView extends StatefulWidget {
  const CustomerDiscoverView({super.key});

  @override
  State<CustomerDiscoverView> createState() => CustomerDiscoverViewState();
}

class CustomerDiscoverViewState extends State<CustomerDiscoverView> {
  final CustomerFunctionViewModel viewModel = CustomerFunctionViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search courses',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: 'Price',
                    items: const [
                      DropdownMenuItem(value: 'Price', child: Text('Price')),
                    ],
                    onChanged: (_) {},
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: 'Category',
                    items: const [
                      DropdownMenuItem(value: 'Category', child: Text('Category')),
                    ],
                    onChanged: (_) {},
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 12),

          Expanded(
            child: ListView(
              children: const [
                RecommendationCard(
                  username: 'Ah Huat',
                  price: 'RM670',
                ),
                RecommendationCard(
                  username: 'Uncle Roger',
                  price: 'RM999',
                ),
                RecommendationCard(
                  username: '秦始皇',
                  price: 'RM50',
                )
              ],
            ),
          )
        ],
      )
    );
  }
}

