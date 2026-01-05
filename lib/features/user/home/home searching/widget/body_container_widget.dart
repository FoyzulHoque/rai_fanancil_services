import 'package:flutter/material.dart';

class BodyContainerWidget extends StatelessWidget {
  const BodyContainerWidget({super.key, this.title, this.subtitle, this.callBackTap});
  final String? title;
  final String? subtitle;
  final VoidCallback? callBackTap;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callBackTap,
      child: Container(
        width: 327,
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey, width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text("$title",style: TextStyle(color: Colors.grey,fontSize: 16),),
              Spacer(),
              Text("$subtitle",style: TextStyle(color: Colors.black,fontSize: 16),),
            ],
          ),
        ),
      ),
    );
  }
}
