import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children:[
              SizedBox(
                  width: 200,
                  child: Image.asset(
                    Theme.of(context).brightness == Brightness.light
                    ? 'assets/images/Codementor.png'
                    : 'assets/images/Codementor_dark.png',
                  ),               
                ),
                const SizedBox(height: 20),
                
              Text(
                'Hi XXX',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                )
              ),
              Text(
                "Welcome to Codementor",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                )
              ),
            ]
          )
        )
      )
      
      

        
      
    );
  }
}