import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/core/widgets/commonAppbar.dart';
import 'package:flutter_assignment/features/auth/views/loginPage_view.dart';
import 'package:flutter_assignment/features/profile/views/editProfile_view.dart';
import 'package:flutter_assignment/core/theme/theme.dart';

class Profile extends StatefulWidget {
  const Profile({super.key, required this.themeNotifier});
  final ValueNotifier<ThemeMode> themeNotifier;

  @override
  State<Profile> createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Profile',
        showBack: true,
        showProfile: false,
        themeNotifier: widget.themeNotifier,
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children:[
              const SizedBox(
                width: 150,
                child: Image(
                  image: AssetImage('assets/images/profile.png'),
                ),    
              ),

              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.edit,
                  size: 16,
                ),             
                label: const Text(
                  'Change Profile Picture',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 50),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EditProfileView(themeNotifier: widget.themeNotifier,),
                        )
                      );
                },
                child: const Text('Edit Profile'),
              ),

              const SizedBox(height: 20),

              Align(
                alignment: Alignment.bottomRight,
                child:ElevatedButton(
                  onPressed: () async {
                    try{
                      await FirebaseAuth.instance.signOut();
                      if(context.mounted){
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context)=>LoginPage(themeNotifier: widget.themeNotifier,)),
                          (Route<dynamic>route)=>false,
                        );
                      }
                    }catch(e){
                      print('Error loging out: $e');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Failded to logout, Try Again.')),
                      );
                    }
                    
                  },
                  child: const Text('Logout'),
                )
            )
              
            ]
          )
        )
      )        
    );
  }
}