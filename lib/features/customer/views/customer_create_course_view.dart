import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_assignment/features/customer/viewmodels/customer_create_course_viewmodel.dart';
import 'package:flutter_assignment/core/widgets/commonAppbar.dart';

class CustomerCreateCourseView extends StatefulWidget{
  final ValueNotifier <ThemeMode> themeNotifier;

  const CustomerCreateCourseView({super.key,required this.themeNotifier});

  @override
  State<CustomerCreateCourseView>createState()=>_CustomerCreateCourseViewState();
}

class _CustomerCreateCourseViewState extends State<CustomerCreateCourseView>{
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  String _selectedCategory = 'Java';
  
  // 1. Variable to store the picked slot
  DateTime? _selectedDateTime;

  final List<String>_categories=['Java','Python','C++','Flutter','UI/UX']; 
  
  @override
  void initState(){
    super.initState();
    _titleController=TextEditingController();
    _descriptionController=TextEditingController();
  }

  @override
  void dispose(){
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  // 2. Logic to pick both Date and Time
  Future<void> _pickDateTime() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (pickedDate == null) return;

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime == null) return;

    setState(() {
      _selectedDateTime = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );
    });
  }

  @override
  Widget build(BuildContext context){
    final viewModel=context.watch<CustomerCreateCourseViewmodel>();

    return Scaffold(
      appBar: CommonAppBar(
        title:'Offer a Skill', 
        showBack:true,
        showProfile: false,
        themeNotifier: widget.themeNotifier
      ),
      body:SingleChildScrollView(
        child:Padding(
          padding:const EdgeInsets.all(20.0),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'What would you like to teach?',
                style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Course Title',
                  hintText: 'e.g., Learn Flutter from Scratch',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              DropdownButtonFormField<String>(
                value:_selectedCategory,
                decoration:const InputDecoration(
                  labelText:'Category',
                  border:OutlineInputBorder(),
                ),
                items:_categories.map((String category){
                  return DropdownMenuItem(
                    value:category,
                    child:Text(category),
                  );
                }).toList(),
                onChanged:(String? newValue){
                  if(newValue!=null){
                    setState(() {
                      _selectedCategory=newValue;
                    });
                  }
                },
              ),
              const SizedBox(height: 20),

              TextField(
                controller: _descriptionController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  hintText: 'Explain what students will learn in this session...',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 20),

              // ✨ NEW: UI Tile for selecting the time slot ✨
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: ListTile(
                  leading: const Icon(Icons.calendar_month, color: Colors.blue),
                  title: Text(
                    _selectedDateTime == null 
                      ? "Select Date & Time" 
                      : "Slot: ${_selectedDateTime.toString().split('.')[0]}", 
                    style: TextStyle(
                      color: _selectedDateTime == null ? Colors.grey[700] : Colors.black,
                      fontWeight: _selectedDateTime == null ? FontWeight.normal : FontWeight.bold,
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_drop_down),
                  onTap: _pickDateTime, // Calls your picker function
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width:double.infinity,
                height: 50,
                child:ElevatedButton(
                  onPressed: viewModel.isLoading?null:()async{
                    if(_titleController.text.trim().isEmpty || 
                       _descriptionController.text.trim().isEmpty ||
                       _selectedDateTime == null){
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please fill all fields and pick a time slot!')),
                      );
                      return;
                    }

                    bool success=await viewModel.createCourse(
                      title:_titleController.text.trim(),
                      description:_descriptionController.text.trim(),
                      category:_selectedCategory,
                      scheduledTime: _selectedDateTime!,
                    );
                    
                    if(success && mounted){
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Skill successfully posted!!")),
                      );
                      Navigator.pop(context);
                    }
                  },
                  style:ElevatedButton.styleFrom(
                    shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child:viewModel.isLoading
                  ? const CircularProgressIndicator(color:Colors.white)
                  :const Text("Post Skill to Community",style:TextStyle(fontSize: 16)),
                )
              )
            ],
          )
        )
      )
    );
  }
}