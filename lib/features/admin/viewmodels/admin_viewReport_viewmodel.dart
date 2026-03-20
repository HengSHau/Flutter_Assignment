import 'package:flutter/material.dart';
import 'package:flutter_assignment/features/admin/models/admin_courseReportData_model.dart';

class AdminViewReportViewModel extends Notification{
  final List<CourseReportModel> courseReports = [
      CourseReportModel(courseName: 'Business', totalStudents: 25),
      CourseReportModel(courseName: 'IT', totalStudents: 40),
      CourseReportModel(courseName: 'Accounting', totalStudents: 18),
      CourseReportModel(courseName: 'Design', totalStudents: 12),
      CourseReportModel(courseName: 'Marketing', totalStudents: 20),
    ];

  double get maxY {
    double highest = 0;
    for (final item in courseReports) {
      if (item.totalStudents > highest) {
        highest = item.totalStudents;
      }
    }
    return highest + 10;
  }
}