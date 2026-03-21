import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_assignment/features/profile/models/user_profile_model.dart';
import 'package:flutter_assignment/features/profile/views/editProfile_view.dart';

class EditprofileViewmodel extends ChangeNotifier{
  bool _isLoading=true;
  bool _isSaving=false;

  UserProfileModel? _userProfile;

  bool get isLoading=>_isLoading;
  bool get isSaving=>_isSaving;
  UserProfileModel?get userProfile=>_userProfile;

  EditprofileViewmodel(){
    loadUserProfile();
  }

  Future<void> loadUserProfile() async{
    try{
      String uid=FirebaseAuth.instance.currentUser?.uid??'';
      if(uid.isNotEmpty){
        DocumentSnapshot doc=await FirebaseFirestore.instance.collection("users").doc(uid).get();
        if(doc.exists&&doc.data()!=null){
          _userProfile=UserProfileModel.fromMap(doc.data()as Map<String,dynamic>);
        }
      }
    }catch(e){
      print("Error loading Profile:$e");
    }finally{
      _isLoading=false;
      notifyListeners();
    }
  }

  Future<bool>saveProfile(UserProfileModel updateProfile) async{
    _isSaving=true;
    notifyListeners();

    try{
      String uid=FirebaseAuth.instance.currentUser?.uid??'';
      if(uid.isNotEmpty){
        await FirebaseFirestore.instance.collection('users').doc(uid).update(updateProfile.toMap());
        _userProfile=updateProfile;
        return true;
      }
      return false;
    }catch(e){
      print('Error saving Profile:$e');
      return false;
    }finally{
      _isSaving=false;
      notifyListeners();
    }
  }

}