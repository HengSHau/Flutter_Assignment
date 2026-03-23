import 'package:flutter/material.dart';

class FeedbackPage extends StatefulWidget{
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackState();
}

class _FeedbackState extends State<FeedbackPage>{
  int rating = 0;
  @override
  Widget build(BuildContext context){
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
                  width: 300,                 
                  child: TextField(
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
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(                      
                        minimumSize: const Size(100, 40)
                    ),
                    child: const Text('Submit'),
                  ),
                )
            ]
          )
        )
      )
    );
  }
}