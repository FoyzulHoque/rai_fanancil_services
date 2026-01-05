import 'package:flutter/material.dart';

import '../widget/notification_widget.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification"),
        centerTitle: true,
        titleTextStyle: TextStyle(color: Colors.black87,fontSize: 18,fontWeight: FontWeight.w600),
      ),
      body:Padding(
        padding: EdgeInsetsGeometry.all(10.0),
        child:ListView.builder(
          itemCount: 2,
            itemBuilder: (context,index){
          return NotificationWidget(
            title: "Account Setup Successful!",
            subTitle:"Your account has been created!" ,
          );
        }),)
    );
  }
}
