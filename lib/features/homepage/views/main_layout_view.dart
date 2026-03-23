import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_assignment/core/widgets/commonAppbar.dart';
import 'package:flutter_assignment/features/homepage/views/homePage_view.dart';
import 'package:flutter_assignment/features/chat/views/chatHomePage_view.dart';
import 'package:flutter_assignment/features/admin/views/admin_functionPage_view.dart';
import 'package:flutter_assignment/features/customer/views/customer_functionPage_view.dart';
import 'package:flutter_assignment/features/finance/views/finance_functionPage_view.dart';
import 'package:flutter_assignment/features/settings/views/settingsPage_view.dart';

class Home extends StatefulWidget {
  const Home({super.key,required this.themeNotifier,});
  final ValueNotifier<ThemeMode> themeNotifier;

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  int _currentIndex = 0;

  String _userRole='customer';
  bool _isLoadingRole=true;

  final List<String> _titles = const [
    'Home',
    'Chat',
    'Functions',
    'Settings',
  ];
  
  @override
  void initState(){
    super.initState();
    _fetchUserRole();
  }

  Future<void> _fetchUserRole() async {
    try{
      String uid=FirebaseAuth.instance.currentUser?.uid??'';
      if(uid.isNotEmpty){
        DocumentSnapshot doc=await FirebaseFirestore.instance.collection('users').doc(uid).get();
        if(doc.exists&&doc.data()!=null){
          setState(() {
            _userRole=(doc.data() as Map<String,dynamic>)['role']?.toString().toLowerCase()??'customer';
          });
        }
      }
    }catch(e){
      print('Error fetching role:$e');

    }finally{
      setState((){
        _isLoadingRole=false;
      });
    }
  }

  Widget _getFunctionPage(){
    if(_userRole=='admin'){
      return const AdminFunctionPage();
    }else if(_userRole=='finance'){
      return const FinanceFunctionPage();
    }else{
      return CustomerFunctionPage(themeNotifier: widget.themeNotifier);
    }
  }



  @override
  Widget build(BuildContext context) {
    if(_isLoadingRole){
      return const Scaffold(
        body:Center(child:CircularProgressIndicator()),
      );
    }

    final pages = [
      HomePage(),
      ChatHomePage(themeNotifier: widget.themeNotifier),
      _getFunctionPage(),
      SettingsPage(themeNotifier: widget.themeNotifier),
    ];

    return Scaffold(
      appBar: CommonAppBar(
        title: _titles[_currentIndex],
        showBack: false,
        themeNotifier: widget.themeNotifier,
      ),
      body:IndexedStack(
        index:_currentIndex,
        children: pages,
      ),

      bottomNavigationBar: buildBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
