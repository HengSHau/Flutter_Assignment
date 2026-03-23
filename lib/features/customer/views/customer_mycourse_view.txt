import 'package:flutter/material.dart';
import 'package:flutter_assignment/features/customer/views/customer_recommendationCard_view.dart';

class CustomerMyCourseView extends StatefulWidget {
  const CustomerMyCourseView({super.key});

  @override
  State<CustomerMyCourseView> createState() => CustomerMyCourseViewState();
}

class CustomerMyCourseViewState extends State<CustomerMyCourseView> {
  @override
  Widget build(BuildContext context) {
    // We use DefaultTabController here to create the sub-tabs for Teaching/Learning
    return DefaultTabController(
      length: 2, 
      child: Column(
        children: [
          // 1. The Sub-TabBar
          const TabBar(
            labelColor: Colors.blue, // Match this to your theme if needed
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.blue,
            tabs: [
              Tab(text: 'Teaching'),
              Tab(text: 'Learning'),
            ],
          ),

          // 2. The Content for each Tab
          Expanded(
            child: TabBarView(
              children: [
                // --- TEACHING TAB CONTENT ---
                ListView(
                  padding: const EdgeInsets.all(12),
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text('Courses you are teaching:', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    RecommendationCard(
                      username: 'Ah Huat (You)',
                      price: 'RM670',
                      onViewPressed: () {
                        print('Manage your teaching course');
                      },
                    ),
                  ],
                ),

                // --- LEARNING TAB CONTENT ---
                ListView(
                  padding: const EdgeInsets.all(12),
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text('Courses you are enrolled in:', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    RecommendationCard(
                      username: '秦始皇',
                      price: 'RM50',
                      onViewPressed: () {
                        print('View course materials / Join session');
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}