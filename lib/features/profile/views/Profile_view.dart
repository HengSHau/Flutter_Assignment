import 'package:flutter/material.dart';
import 'package:flutter_assignment/core/widgets/CommonAppBar.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Profile',
        showBack: true,
        showProfile: false
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
                onPressed: () {},
                child: const Text('Edit Profile'),
              ),

              const SizedBox(height: 20),

              Align(
                alignment: Alignment.bottomRight,
                child:ElevatedButton(
                  onPressed: () {},
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