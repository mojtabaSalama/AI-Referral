import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
 final String text;
   const Loading({super.key ,required this.text});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(child: Column( mainAxisAlignment: MainAxisAlignment.center,
        children: [   Text(text,style: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.bold),),
          SpinKitThreeInOut(color :Colors.white ,size:100),
        ],
      )),
    );
  }
}