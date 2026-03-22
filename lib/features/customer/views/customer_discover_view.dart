import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_assignment/core/widgets/commonAppbar.dart';
import 'package:flutter_assignment/features/customer/viewmodels/customer_discover_viewmodel.dart'; 
import 'package:flutter_assignment/features/customer/models/course_model.dart';
import 'package:intl/intl.dart';

class DiscoverView extends StatefulWidget {
  final ValueNotifier<ThemeMode> themeNotifier;

  const DiscoverView({super.key, required this.themeNotifier});

  @override
  State<DiscoverView> createState() => _DiscoverViewState();
}

class _DiscoverViewState extends State<DiscoverView> {
  String _selectedCategory = 'All';
  final List<String> _categories = ['All', 'Java', 'Python', 'C++', 'Flutter', 'UI/UX'];

  @override
  Widget build(BuildContext context) {
    // Watches the live stream from the ViewModel
    final viewModel = context.watch<CustomerDiscoverViewModel>();

    return Scaffold(
      appBar: CommonAppBar(
        title: "Discover Skills",
        showBack: true,
        showProfile: false,
        themeNotifier: widget.themeNotifier,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search for a language or skill...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Theme.of(context).brightness == Brightness.light 
                    ? Colors.grey.shade200 
                    : Colors.grey.shade800,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 2. Category Filters
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _categories.map((category) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: ChoiceChip(
                      label: Text(category),
                      selected: _selectedCategory == category,
                      onSelected: (bool selected) {
                        setState(() {
                          _selectedCategory = category;
                        });
                        viewModel.filterByCategory(category);
                      },
                      selectedColor: Colors.blue.shade200,
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'Available 1-to-1 Slots',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            
            Expanded(
              child: viewModel.isLoading
              ? const Center(child: CircularProgressIndicator())
              : viewModel.filteredCourses.isEmpty
                ? Center(
                    child: Text(
                      'No available slots for $_selectedCategory right now.',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: viewModel.filteredCourses.length,
                    itemBuilder: (context, index) {
                      final course = viewModel.filteredCourses[index];
                      // PASS the viewModel to the card so it can handle booking
                      return _buildCourseCard(context, course, viewModel);
                    },
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseCard(BuildContext context, CourseModel course, CustomerDiscoverViewModel viewModel) {
    String formattedDate = DateFormat('EEE, MMM d').format(course.scheduledTime);
    String formattedTime = DateFormat('h:mm a').format(course.scheduledTime);

    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    course.category,
                    style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 16, color: Colors.orange),
                    const SizedBox(width: 4),
                    Text(
                      "$formattedDate at $formattedTime",
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.orange),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              course.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              'Mentor: ${course.tutorName}',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              course.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Community Free',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
                ),
                ElevatedButton(
                  onPressed: () async {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Booking ${course.title}...'), duration: const Duration(seconds: 1)),
                    );

                    String result = await viewModel.bookCourse(course);

                    if (context.mounted) {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      
                      if (result == "Success") {
                        // ✨ NOTE: We removed the manual "fetch" call here.
                        // Because CustomerLearningViewModel is now a Stream, 
                        // it will detect the new booking in Firebase automatically!

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Successfully booked! See you on $formattedDate."),
                            backgroundColor: Colors.green,
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(result), backgroundColor: Colors.red),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text('Book Now'),
                ), 
              ],
            ),
          ],
        ),
      ),
    );
  }
}