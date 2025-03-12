import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'chat_screen.dart';

main()async{
  await dotenv.load(fileName: ".env");

  runApp(const AIChatBot());

}



class AIChatBot extends StatelessWidget {

  const AIChatBot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
primaryColor: Colors.lightBlue,
      ),
      debugShowCheckedModeBanner: false,
      home: ChatScreen(),
    );
  }
}
