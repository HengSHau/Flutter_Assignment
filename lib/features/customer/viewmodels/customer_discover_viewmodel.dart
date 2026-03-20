import 'package:flutter/material.dart';
import 'package:flutter_assignment/features/customer/models/tutor_couce_model.dart' show TutorCourseModel;

class CustomerDiscoverViewModel extends ChangeNotifier {
  // 1. The full list of courses (Simulating data from Firebase for now)
  final List<TutorCourseModel> _allCourses = [
    TutorCourseModel(courseId: '1', tutorUid: 'u1', tutorName: 'Ah Huat', category: 'Java', price: 670.0),
    TutorCourseModel(courseId: '2', tutorUid: 'u2', tutorName: 'Uncle Roger', category: 'Python', price: 999.0),
    TutorCourseModel(courseId: '3', tutorUid: 'u3', tutorName: '秦始皇', category: 'C++', price: 50.0),
    TutorCourseModel(courseId: '4', tutorUid: 'u4', tutorName: 'Ali', category: 'Java', price: 150.0),
  ];

  // 2. State variables for the UI
  List<TutorCourseModel> _displayedCourses = [];
  String _searchQuery = '';
  String _selectedCategory = 'Category';
  String _selectedPriceSort = 'Price';

  // Getters for the UI to read
  List<TutorCourseModel> get displayedCourses => _displayedCourses;
  String get selectedCategory => _selectedCategory;
  String get selectedPriceSort => _selectedPriceSort;

  CustomerDiscoverViewModel() {
    // When the page loads, show all courses initially
    _displayedCourses = List.from(_allCourses);
  }

  // --- UPDATE METHODS ---

  void updateSearchQuery(String query) {
    _searchQuery = query.toLowerCase();
    _applyFilters();
  }

  void updateCategory(String category) {
    _selectedCategory = category;
    _applyFilters();
  }

  void updatePriceSort(String sortType) {
    _selectedPriceSort = sortType;
    _applyFilters();
  }

  // --- FILTERING LOGIC ---
  
  void _applyFilters() {
    // Start with all courses
    List<TutorCourseModel> filtered = List.from(_allCourses);

    // 1. Filter by Search Query (Tutor Name or Category)
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((course) {
        return course.tutorName.toLowerCase().contains(_searchQuery) ||
               course.category.toLowerCase().contains(_searchQuery);
      }).toList();
    }

    // 2. Filter by Category Dropdown
    if (_selectedCategory != 'Category' && _selectedCategory != 'All Categories') {
      filtered = filtered.where((course) => course.category == _selectedCategory).toList();
    }

    // 3. Sort by Price Dropdown
    if (_selectedPriceSort == 'Low') {
      filtered.sort((a, b) => a.price.compareTo(b.price));
    } else if (_selectedPriceSort == 'High') {
      filtered.sort((a, b) => b.price.compareTo(a.price));
    }

    // Update the UI
    _displayedCourses = filtered;
    notifyListeners();
  }
}