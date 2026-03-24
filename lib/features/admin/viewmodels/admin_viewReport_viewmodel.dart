import 'package:flutter/material.dart';
import 'package:flutter_assignment/features/admin/models/admin_courseReportData_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminViewReportViewModel extends ChangeNotifier { 
  bool isLoading = true;
  List<CourseReportModel> courseReports = [];

  AdminViewReportViewModel() {
    fetchReportData();
  }

  double get maxY {
    if (courseReports.isEmpty) return 10; 
    
    double highest = 0;
    for (final item in courseReports) {
      if (item.totalStudents > highest) {
        highest = item.totalStudents.toDouble();
      }
    }
    return highest + 10;
  }

  Future<void> fetchReportData() async {
    isLoading = true;
    notifyListeners();

    try {
      final snapshot = await FirebaseFirestore.instance.collection('courses').get();
      
      Map<String, int> categoryCounts = {};

      for (var doc in snapshot.docs) {
        final data = doc.data();
        
        String category = data['category'] ?? 'Other'; 
        
        categoryCounts[category] = (categoryCounts[category] ?? 0) + 1;
      }

      List<CourseReportModel> tempReports = [];
      categoryCounts.forEach((categoryName, count) {
        tempReports.add(CourseReportModel(
          courseName: categoryName, 

          totalStudents: count.toDouble(), 
        ));
      });

      courseReports = tempReports;

    } catch (e) {
      print("Error fetching report data: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}