import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PromptField extends StatelessWidget {
  final Function()? onSend;
  final TextEditingController promptController;

  const PromptField(
      {super.key, required this.onSend, required this.promptController});

  @override
  Widget build(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height;
    double maxWidth = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: maxWidth * 0.07),

      child: SizedBox(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: maxHeight * 0.02),

        child: TextField(
            cursorColor: Colors.lightBlue,
            autofocus: false,
            controller: promptController,
            decoration: InputDecoration(
              contentPadding:  EdgeInsets.symmetric(horizontal: maxWidth * 0.06,vertical: maxHeight*0.01) ,
              suffixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: maxWidth * 0.01,vertical: maxHeight*0.008),

                child: CircleAvatar(
                  radius: maxWidth*0.05,
                    backgroundColor: Colors.lightBlue.shade200,
                    child: IconButton(
                        onPressed: onSend,
                        icon: Icon(
                          FontAwesomeIcons.paperPlane,
                          size: maxWidth * 0.05,
                          color: Colors.white,
                        ))),
              ),
              hintText: "Write Prompt",
              hintStyle:  TextStyle(color: Colors.grey, fontSize: maxWidth*0.038),
              filled: true,
              fillColor: Colors.blue.shade50,
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.circular(maxWidth*0.1),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.circular(maxWidth*0.1),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.circular(maxWidth*0.1),
              ),

            ),
          ),
        ),
      ),
    );
  }
}
