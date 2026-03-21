import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomepageViewmodel extends ChangeNotifier{
  String _userName='';
  bool _isLoading=true;

  String get userName=>_userName;
  bool get isLoading=>_isLoading;

  HomepageViewmodel(){
    _fetchUserName();
  }

  Future<void>_fetchUserName()async{
    try{
      String uid=FirebaseAuth.instance.currentUser?.uid??'';

      if(uid.isNotEmpty){
        DocumentSnapshot doc=await FirebaseFirestore.instance.collection('users').doc(uid).get();

        if(doc.exists&&doc.data()!=null){
          _userName=(doc.data()as Map<String,dynamic>)['username']??'User';
        }
      }
    }catch(e){
      print("Error fetch username:$e");
      _userName='User';
    }finally{
      _isLoading=false;
      notifyListeners();
    }
  }
}