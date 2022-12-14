import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class LoadPayment extends StatelessWidget {
  const LoadPayment({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left:10,right:10,top:40), 
        child: SingleChildScrollView(
          child: Column(  
            children: [
              Container( 
                width:double.infinity,
                height: 50,
                alignment: Alignment.centerLeft, 
                decoration: BoxDecoration(  
                  color: Colors.white54, 
                  borderRadius: BorderRadius.circular(5), 
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 2, 
                      offset: Offset(0,0), 
                    )
                  ]
                ),
                child:Text("  Payment",style: TextStyle(fontSize: 22, ),),
              ),
              SizedBox(height: 100,),
              Container( 
                width:double.infinity,
                height: 50,
                alignment: Alignment.centerLeft, 
                decoration: BoxDecoration(  
                  color: Colors.white54, 
                  borderRadius: BorderRadius.circular(5), 
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 2, 
                      offset: Offset(0,0), 
                    )
                  ]
                ),
                child:Text("  Payment",style: TextStyle(fontSize: 22, ),),
              )
            ],
          )
        ),
      ),
    );
  }
}