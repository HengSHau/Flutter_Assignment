import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import 'package:flutter_assignment/features/customer/views/customer_discover_view.dart';
import 'package:flutter_assignment/features/customer/views/customer_create_course_view.dart';
import 'package:flutter_assignment/features/customer/viewmodels/customer_learning_viewmodel.dart';
import 'package:flutter_assignment/features/customer/viewmodels/customer_teaching_viewmodel.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';


class CustomerFunctionPage extends StatelessWidget {
  final ValueNotifier<ThemeMode> themeNotifier;

  const CustomerFunctionPage({super.key, required this.themeNotifier});

  @override
  Widget build(BuildContext context) {
    final learningViewModel = context.watch<CustomerLearningViewModel>();
    final teachingViewModel = context.watch<CustomerTeachingViewmodel>();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Hub'),
          centerTitle: true,
          bottom: const TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            tabs: [
              Tab(text: 'Learning'),
              Tab(text: "Teaching"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildLearningTab(context, learningViewModel),
            _buildTeachingTab(context, teachingViewModel),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CustomerCreateCourseView(themeNotifier: themeNotifier))
            );
          },
          icon: const Icon(Icons.add),
          label: const Text('Offer a skill'),
        ),
      ),
    );
  }

  Widget _buildLearningTab(BuildContext context, CustomerLearningViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Courses You've Booked",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: viewModel.isLoading
              ? const Center(child: CircularProgressIndicator())
              : viewModel.bookedCourses.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.menu_book, size: 64, color: Colors.grey.shade400),
                          const SizedBox(height: 16),
                          Text(
                            "You haven't booked any classes yet.",
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DiscoverView(themeNotifier: themeNotifier)
                                ),
                              );
                            },
                            child: const Text('Find a Mentor'),
                          )
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DiscoverView(themeNotifier: themeNotifier)
                                  ),
                                );
                              },
                              icon: const Icon(Icons.search),
                              label: const Text("Book Another Class"),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: viewModel.bookedCourses.length,
                            itemBuilder: (context, index) {
                              final course = viewModel.bookedCourses[index];
                              String FormattedDate = DateFormat('EEE, MMM d').format(course.scheduledTime);
                              String formattedTime = DateFormat('h:mm a').format(course.scheduledTime);                               
                              
                              return Card(
                                margin: const EdgeInsets.only(bottom: 12),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(16),
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.blue.shade100,
                                    child: const Icon(Icons.school, color: Colors.blue),
                                  ),
                                  title: Text(course.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                                  
                                  // ✨ UPDATED: Subtitle is now a Column to show the Time Slot
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Taught by: ${course.tutorName}'),
                                      Text('Category: ${course.category}'),
                                      const SizedBox(height: 6),
                                      Row(
                                        children: [
                                          const Icon(Icons.access_time, size: 14, color: Colors.orange),
                                          const SizedBox(width: 4),
                                          Text(
                                            "$FormattedDate at $formattedTime",
                                            style: const TextStyle(
                                              color: Colors.orange,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  trailing: ElevatedButton(
                                    onPressed: () async {
                                      final Uri meetUrl = Uri.parse(course.meetLink);
                                      try {
                                        if (!await launchUrl(meetUrl, mode: LaunchMode.externalApplication)) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text('Could not Open Video Room.')),
                                          );
                                        }
                                      } catch (e) {
                                        print('Error launching Url: $e');
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      foregroundColor: Colors.white,
                                    ),
                                    child: const Text('Join Class'),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeachingTab(BuildContext context, CustomerTeachingViewmodel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Skills You Are Offering',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: viewModel.isLoading
              ? const Center(child: CircularProgressIndicator())
              : viewModel.taughtCourses.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.school, size: 64, color: Colors.grey.shade400),
                          const SizedBox(height: 16),
                          const Text("You aren't teaching anything yet."),
                          const SizedBox(height: 16),
                          const Text(
                            "Share your knowledge and earn!",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: viewModel.taughtCourses.length,
                      itemBuilder: (context, index) {
                        final course = viewModel.taughtCourses[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16),
                            leading: CircleAvatar(
                              backgroundColor: Colors.orange.shade100,
                              child: const Icon(Icons.star, color: Colors.orange),
                            ),
                            title: Text(course.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text('Category: ${course.category}\nCommunity Class (Free)'),
                            trailing: ElevatedButton(
                              onPressed: () async {
                                final Uri meetUrl = Uri.parse(course.meetLink);
                                try {
                                  if (!await launchUrl(meetUrl, mode: LaunchMode.externalApplication)) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Could not open Video Room.')),
                                    );
                                  }
                                } catch (e) {
                                  print('Error launching Url: $e');
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                              ),
                              child: const Text('Start Class'),
                            ),
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}