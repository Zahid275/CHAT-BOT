import 'package:flutter/material.dart';

class MessageTile extends StatelessWidget {
  final String message;
  final bool isUser;
const MessageTile({super.key, required this.message,required this.isUser});
  @override
  Widget build(BuildContext context) {

    double maxHeight = MediaQuery.of(context).size.height;
    double maxWidth = MediaQuery.of(context).size.width;

    return Container(
      alignment: isUser ?Alignment.centerRight :Alignment.centerLeft,

      child: Container(
        padding:  EdgeInsets.symmetric(horizontal: maxWidth*0.02,vertical: maxHeight*0.01),
        decoration: BoxDecoration(
            color: isUser ?Colors.lightBlue.shade200:Colors.blueGrey.shade100,
            borderRadius: BorderRadius.circular(12)
        ),
        child: Text(message,style: TextStyle(color:isUser ? Colors.white:Colors.black,fontSize: maxWidth*0.05),),
      ),
    );
  }
}
