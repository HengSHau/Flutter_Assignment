import 'package:flutter/material.dart';
import 'package:flutter_assignment/features/admin/viewmodels/admin_functionPage_viewmodel.dart';

class AdminAddStaff extends StatefulWidget {
  const AdminAddStaff({super.key});

  @override
  State<AdminAddStaff> createState() => AdminAddStaffState();
}

class AdminAddStaffState extends State<AdminAddStaff> {
  final AdminFunctionViewModel vm = AdminFunctionViewModel();

   Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(),
                      labelText: 'Staff Name',
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width: 300,
                  child: TextField(
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(),
                      labelText: 'Gmail',
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width: 300,
                  child: DropdownButtonFormField<String>(
                    initialValue: vm.selectedRole,
                    decoration: const InputDecoration(
                      labelText: 'Role',
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'Admin',
                        child: Text('Admin'),
                      ),
                      DropdownMenuItem(
                        value: 'Finance',
                        child: Text('Finance'),
                      ),
                    ],
                    onChanged: vm.changeRole,
                  ),
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width: 300,
                  child: TextField(
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(),
                      labelText: 'Contact No.',
                      labelStyle: TextStyle(
                      )
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width: 300,
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      labelText: 'Gender',
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(), 
                    ),
                    isExpanded: true,
                    items:[
                      DropdownMenuItem(value: 'Male', child: Text('Male')
                      ),
                      DropdownMenuItem( value: 'Female', child: Text('Female')
                      )
                   ],
                   onChanged: (value) {
                   }, 
                  )
                ),
                const SizedBox(height: 24),

                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(                      
                        minimumSize: const Size(100, 40)
                    ),
                    child: const Text('Add Staff'),
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}