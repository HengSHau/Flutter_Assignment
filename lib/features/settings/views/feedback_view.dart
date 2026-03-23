import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_assignment/features/settings/viewmodels/feedback_viewmodel.dart';

class FeedbackPage extends StatefulWidget{
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackState();
}

class _FeedbackState extends State<FeedbackPage>{
  int rating = 0;
  late TextEditingController _feedbackController;

  @override
  void initState(){
    super.initState();
    _feedbackController=TextEditingController();
  }

  @override
  void dispose(){
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    final viewModel=context.watch<FeedbackViewmodel>();

    return Scaffold(
      appBar: AppBar(
         title: const Text('Feedback'),
      ),
      body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20),            
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Text(
                'Rating:',
                style: TextStyle(
                  fontSize: 24,
                )
              ),
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  final starIndex = index + 1;

                  return IconButton(
                    onPressed: () {
                      setState(() {
                        rating = starIndex;
                      });
                    },
                    icon: Icon(
                      starIndex <= rating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 32,
                    ),
                  );
                }),
              ),

              Text(
                'Tell us your opinion:',
                style: TextStyle(
                  fontSize: 24,
                )
              ),
              const SizedBox(height: 10),

              Align(
                alignment: AlignmentGeometry.center,
                child:SizedBox(
                  width: 500,                 
                  child: TextField(
                    controller:_feedbackController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(),
                      labelText: 'Feedback',
                    ),
                  )
                )
              ),
              const SizedBox(height: 24),

              Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: viewModel.isLoading
                    ? null
                    :() async {
                      FocusScope.of(context).unfocus();

                      String result=await viewModel.submitFeedback(
                        rating,
                        _feedbackController.text,
                      );

                      if(context.mounted){
                        if(result=='Success'){
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Thank You for your feedback'),
                              backgroundColor: Colors.green,
                            ),
                          );

                          _feedbackController.clear();
                          setState(() {
                            rating=0;
                          });
                        }
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(result),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(                      
                        minimumSize: const Size(100, 40)
                    ),
                    child: viewModel.isLoading
                      ? const SizedBox(width:20,height: 20,child:CircularProgressIndicator(strokeWidth: 2))
                      :const Text ('Submit'),
                  ),
                )
            ]
          )
        )
      )
    );
  }
}