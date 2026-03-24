import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_assignment/features/admin/viewmodels/admin_editStaff_viewmodel.dart';

class AdminEditStaff extends StatefulWidget {
  const AdminEditStaff({super.key});

  @override
  State<AdminEditStaff> createState() => _AdminEditStaffState();
}

class _AdminEditStaffState extends State<AdminEditStaff> {
  final AdminEditStaffViewModel vm = AdminEditStaffViewModel();

  @override
  void initState() {
    super.initState();
    vm.addListener(_refresh);
  }

  void _refresh() {
    setState(() {});
  }

  @override
  void dispose() {
    vm.removeListener(_refresh);
    vm.disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  width: 320,
                  height: 180,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('users').where('role',isNotEqualTo: 'Learner').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return const Center(child: Text('Error loading staff'));
                      }

                      final alldocs = snapshot.data?.docs ?? [];

                      final currentUserId=FirebaseAuth.instance.currentUser?.uid;

                      final docs=alldocs.where((doc){
                        final data=doc.data()as Map<String,dynamic>;
                        bool isNotSuperAdmin=data['username']!='Super Admin';
                        bool isNotMyself=doc.id!=currentUserId;
                        return isNotMyself&&isNotSuperAdmin;
                      }).toList();

                      if (docs.isEmpty) {
                        return const Center(child: Text('No staff found'));
                      }

                      return ListView.separated(
                        itemCount: docs.length,
                        separatorBuilder: (context, index) => const Divider(height: 1),
                        itemBuilder: (context, index) {
                          final doc = docs[index];
                          final data = doc.data() as Map<String, dynamic>;
                          final isSelected = vm.selectedDocId == doc.id;

                          return ListTile(
                            title: Text(data['username'] ?? ''),
                            subtitle: Text(data['email'] ?? ''),
                            trailing: Text(data['gender'] ?? ''),
                            onTap: () {
                              vm.selectStaff(doc);
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: vm.usernameController,
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
                    controller: vm.emailController,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width: 300,
                  child: DropdownButtonFormField<String>(
                    value: vm.selectedRole,
                    decoration: const InputDecoration(
                      labelText: 'Role',
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'admin',
                        child: Text('Admin'),
                      ),
                      DropdownMenuItem(
                        value: 'finance',
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
                    controller: vm.contactNoController,
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
                    value: vm.selectedGender,
                    decoration: const InputDecoration(
                      labelText: 'Gender',
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                    ),
                    isExpanded: true,
                    items: const [
                      DropdownMenuItem(
                        value: 'Male',
                        child: Text('Male'),
                      ),
                      DropdownMenuItem(
                        value: 'Female',
                        child: Text('Female'),
                      ),
                    ],
                    onChanged: vm.changeGender,
                  ),
                ),
                const SizedBox(height: 24),


                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          minimumSize: const Size(100, 40),
                        ),
                       onPressed: () async {
                        if (vm.selectedDocId == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please select a staff first'),
                            ),
                          );
                          return;
                        }

                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Delete Staff'),
                              content: const Text('Are you sure you want to delete this staff?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, false);
                                  },
                                  child: const Text('Cancel'),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context, true);
                                  },
                                  child: const Text('Delete'),
                                ),
                              ],
                            );
                          },
                        );

                        if (confirm == true) {
                          await vm.deleteSelectedStaff();

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Staff deleted successfully'),
                            ),
                          );
                        }
                      },
                        child: const Text('Delete'),
                      ),

                      const SizedBox(width: 10),

                      ElevatedButton(
                        onPressed: () async {
                          if (vm.selectedDocId == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please select a staff first'),
                              ),
                            );
                            return;
                          }

                          await vm.updateSelectedStaff();

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Staff updated successfully'),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(100, 40),
                        ),
                        child: const Text('Edit Staff'),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}