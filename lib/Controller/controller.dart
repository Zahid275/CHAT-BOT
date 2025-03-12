import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Controller extends GetxController {
  ScrollController scrollController = ScrollController();
  String apiKey = "${dotenv.env["API_KEY"]}";
  RxList<dynamic> data = [].obs;
  final promptController = TextEditingController();
  RxBool isTyping = false.obs;

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });
  }

  getResponse({required prompt}) async {
    try {
      isTyping.value = true;

      final url = Uri.parse(
          "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$apiKey");
      final body = {
        "contents": [
          {
            "parts": [
              {"text": "$prompt"}
            ]
          }
        ]
      };

      final header = {
        "Content-Type": "application/json",
      };

      final response =
          await http.post(url, headers: header, body: jsonEncode(body));
      if (response.statusCode == 200) {
        final res = jsonDecode(response.body);
        String finalResponse =
            res["candidates"][0]["content"]["parts"][0]["text"];
        data.add({"text": finalResponse, "isUser": false});
        isTyping.value = false;

        return finalResponse;
      } else {
        isTyping.value = false;
        Get.showSnackbar(const GetSnackBar(
            duration: Duration(seconds: 3),
            messageText: Text(
              "Failed to load data",
              style: TextStyle(color: Colors.white),
            )));

        return "Failed to load data ";
      }
    } catch (e) {
      isTyping.value = false;
      data.add({"text": "Error: something went wrong", "isUser": false});

    }
  }
}
