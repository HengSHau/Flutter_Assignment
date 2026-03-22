import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // 1. IMPORT PROVIDER
import 'package:flutter_assignment/features/customer/viewmodels/customer_discover_viewmodel.dart'; // 2. IMPORT THE NEW VIEWMODEL
import 'package:flutter_assignment/features/customer/views/customer_recommendationCard_view.dart';

// We can change this to a StatelessWidget because Provider handles the state now!
class CustomerDiscoverView extends StatelessWidget {
  const CustomerDiscoverView({super.key});

  @override
  Widget build(BuildContext context) {
    // 3. LISTEN TO THE VIEWMODEL
    final viewModel = context.watch<CustomerDiscoverViewModel>();

    return Scaffold(
      body: Column(
        children: [
          // 1. Search Bar for courses/tutors
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              // 4. CONNECT THE SEARCH BAR
              onChanged: (value) => viewModel.updateSearchQuery(value),
              decoration: InputDecoration(
                hintText: 'Search courses (Java, C++, Python)',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          // 2. Filter Row (Price & Category)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: viewModel.selectedPriceSort, // Bind to ViewModel
                    items: const [
                      DropdownMenuItem(value: 'Price', child: Text('Sort by Price')),
                      DropdownMenuItem(value: 'Low', child: Text('Lowest First')),
                      DropdownMenuItem(value: 'High', child: Text('Highest First')),
                    ],
                    // 5. CONNECT THE PRICE FILTER
                    onChanged: (val) {
                      if (val != null) viewModel.updatePriceSort(val);
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                      labelText: 'Price',
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: viewModel.selectedCategory, // Bind to ViewModel
                    items: const [
                      DropdownMenuItem(value: 'Category', child: Text('All Categories')),
                      DropdownMenuItem(value: 'Java', child: Text('Java')),
                      DropdownMenuItem(value: 'Python', child: Text('Python')),
                      DropdownMenuItem(value: 'C++', child: Text('C++')),
                    ],
                    // 6. CONNECT THE CATEGORY FILTER
                    onChanged: (val) {
                      if (val != null) viewModel.updateCategory(val);
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                      labelText: 'Category',
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),
          
          // Section Title
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Recommendations',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          // 3. Dynamic List of Tutors/Courses
          Expanded(
            // 7. REPLACE HARDCODED LIST WITH LISTVIEW.BUILDER
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 8),
              itemCount: viewModel.displayedCourses.length,
              itemBuilder: (context, index) {
                // Get the specific course data
                final course = viewModel.displayedCourses[index];
                
                // Pass that data into your RecommendationCard
                return RecommendationCard(
                  username: '${course.tutorName} (${course.category})',
                  price: 'RM${course.price.toStringAsFixed(0)}',
                  onViewPressed: () {
                    print('Navigating to profile of ${course.tutorName}');
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}