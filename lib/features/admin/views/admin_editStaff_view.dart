import 'package:flutter/material.dart';
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
                  child: ListView.separated(
                    itemCount: vm.staffList.length,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final staff = vm.staffList[index];
                      final isSelected = vm.selectedIndex == index;

                      return ListTile(
                        tileColor:
                            isSelected ? Colors.grey.shade300 : Colors.white,
                        title: Text(staff.username),
                        subtitle: Text(staff.gmail),
                        trailing: Text(staff.gender),
                        onTap: () {
                          vm.selectStaff(index);
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
                    controller: vm.gmailController,
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

                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: vm.passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      vm.updateSelectedStaff();

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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}