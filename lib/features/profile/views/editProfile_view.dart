import 'package:flutter/material.dart';
import 'package:flutter_assignment/core/widgets/commonAppbar.dart';
import 'package:flutter_assignment/features/profile/viewmodels/editProfile_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:flutter_assignment/features/profile/models/user_profile_model.dart';
import 'package:flutter_assignment/features/auth/views/change_password_view.dart'; 

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key,required this.themeNotifier,});
  final ValueNotifier<ThemeMode> themeNotifier;
  
  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _contactController;

  String _selectedGender='Male';
  bool _isInitialized=false;

  @override
  void initState(){
    super.initState();
    _usernameController=TextEditingController();
    _emailController=TextEditingController();
    _contactController=TextEditingController();

    // ✨ THE FIX: Force the ViewModel to fetch fresh data when this page opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // NOTE: Change 'loadProfile()' to the actual function name inside your EditprofileViewmodel!
      context.read<EditprofileViewmodel>().loadUserProfile(); 
      
      setState(() {
        _isInitialized = false; 
      });
    });
  }

  @override
  void dispose(){
    _usernameController.dispose();
    _emailController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel=context.watch<EditprofileViewmodel>();

    if(viewModel.isLoading){
      return const Scaffold(body:Center(child:CircularProgressIndicator()));
    }

    if(!_isInitialized&&viewModel.userProfile!=null){
      _usernameController.text=viewModel.userProfile!.username;
      _emailController.text=viewModel.userProfile!.email;
      _contactController.text = viewModel.userProfile!.contactNo;
      _selectedGender = viewModel.userProfile!.gender;
      _isInitialized = true;     
    }

    return Scaffold(
      appBar: CommonAppBar(
        title: "Edit Profile", 
        showBack: true,
        showProfile: false,
        themeNotifier: widget.themeNotifier
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(
                  width: 200,
                  child: Image.asset(
                    Theme.of(context).brightness == Brightness.light
                    ? 'assets/images/Codementor.png'
                    : 'assets/images/Codementor_dark.png',
                  ),               
                ),
                const SizedBox(height: 20),

                SizedBox(
                  width: 300,
                  child: TextField(
                    controller:_usernameController,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      labelText: 'Username',
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      labelText: 'Gmail',
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: _contactController,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      labelText: 'Contact No.',
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width: 300,
                  child: DropdownButtonFormField<String>(
                    value:_selectedGender,
                    decoration: const InputDecoration(
                      labelText: 'Gender',
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(), 
                    ),
                    isExpanded: true,
                    items: const [
                      DropdownMenuItem(value: 'Male', child: Text('Male')),
                      DropdownMenuItem(value: 'Female', child: Text('Female'))
                   ],
                   onChanged: (value) {
                    if(value!=null){
                      setState(() {
                        _selectedGender=value;
                      });
                    }
                   }, 
                  )
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width:300,
                  height:50,
                  child:OutlinedButton.icon(
                    icon:const Icon(Icons.lock_reset,color: Colors.redAccent),
                    label:const Text(
                      'Change Password',
                      style:TextStyle(color:Colors.redAccent,fontWeight:FontWeight.bold),
                    ),
                    style: OutlinedButton.styleFrom(
                      side:const BorderSide(color:Colors.redAccent),
                      shape:RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context)=>ChangePasswordView(themeNotifier: widget.themeNotifier),
                        )
                      );
                    },
                  ),
                ),
                const SizedBox(height: 30),

                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed:viewModel.isSaving?null: () async{
                      final updatedProfile=UserProfileModel(
                        username: _usernameController.text.trim(),
                        email:_emailController.text.trim(),
                        contactNo:_contactController.text.trim(),
                        gender: _selectedGender,
                      );

                      bool success=await viewModel.saveProfile(updatedProfile);
                      if(success&&mounted){
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Profile Updated Success!')),
                        );
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(                      
                        minimumSize: const Size(100, 40)
                    ),
                    child: viewModel.isSaving
                      ? const SizedBox(width: 20,height:20,child: CircularProgressIndicator(strokeWidth: 2))
                      : const Text('Save Profile'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}