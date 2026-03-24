import 'package:flutter/material.dart';
import '../models/admin_viewFeedback_model.dart';
import '../viewmodels/admin_viewFeedback_viewmodel.dart';

class AdminViewFeedback extends StatefulWidget {
  const AdminViewFeedback({super.key});

  @override
  State<AdminViewFeedback> createState() =>
      _AdminViewFeedbackState();
}

class _AdminViewFeedbackState
    extends State<AdminViewFeedback> {
  final AdminFeedbackViewModel viewModel = AdminFeedbackViewModel();

  String searchText = '';

  String formatDate(dynamic timestamp) {
    if (timestamp == null) return '-';

    final dateTime = timestamp.toDate();
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  List<FeedbackModel> filterFeedback(List<FeedbackModel> list) {
    if (searchText.isEmpty) return list;

    return list.where((feedback) {
      return feedback.userId
              .toLowerCase()
              .contains(searchText.toLowerCase()) ||
          feedback.message
              .toLowerCase()
              .contains(searchText.toLowerCase());
    }).toList();
  }

  void showFullMessage(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Feedback Detail'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Feedback'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<FeedbackModel>>(
                stream: viewModel.getAllFeedback(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('Error loading feedback'),
                    );
                  }

                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final originalList = snapshot.data ?? [];
                  final feedbackList = filterFeedback(originalList);

                  if (feedbackList.isEmpty) {
                    return const Center(
                      child: Text('No feedback found'),
                    );
                  }

                  return Column(
                    children: [
                      /// 📊 SUMMARY CARD
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            'Total Feedback: ${feedbackList.length}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columns: const [
                              DataColumn(label: Text('No')),
                              DataColumn(label: Text('Comment')),
                              DataColumn(label: Text('Rating')),
                              DataColumn(label: Text('Date')),
                              DataColumn(label: Text('Action')),
                            ],
                            rows: List.generate(
                                feedbackList.length, (index) {
                              final feedback = feedbackList[index];

                              return DataRow(
                                cells: [
                                  DataCell(Text('${index + 1}')),
                                  DataCell(
                                    SizedBox(
                                      width: 200,
                                      child: Text(
                                        feedback.message,
                                        maxLines: 1,
                                        overflow:
                                            TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),

                                  DataCell(Text(
                                      feedback.rating.toString())),
                                  DataCell(Text(
                                      formatDate(feedback.createdAt))),

                                  DataCell(
                                    IconButton(
                                      icon: const Icon(
                                          Icons.visibility),
                                      onPressed: () {
                                        showFullMessage(
                                            feedback.message);
                                      },
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}