import 'package:chat_bot/Controller/controller.dart';
import 'package:chat_bot/Widgets/message_tile.dart';
import 'package:chat_bot/Widgets/prompt_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final Controller controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.of(context).size.height;
    final maxWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.lightBlue[200],
      body: Column(
        children: [
          Obx(() {
            return Container(
              height: maxHeight * 0.15,
              width: maxWidth * 0.28,
              decoration: BoxDecoration(
                  image: controller.data.isNotEmpty
                      ? const DecorationImage(
                          image: AssetImage(
                          "assets/bot.png",
                        ))
                      : null),
            );
          }),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: maxWidth * 0.05),
              width: maxWidth,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(42),
                  topRight: Radius.circular(42),
                ),
              ),
              child: Obx(
                () => controller.data.isEmpty
                    ? Center(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset("assets/bot.png",
                                  width: maxWidth * 0.53, fit: BoxFit.fill),
                              SizedBox(height: maxHeight * 0.03),
                              Center(
                                child: Text(
                                  "How can I help you today?",
                                  style: GoogleFonts.poppins(
                                      fontSize: maxWidth * 0.05,
                                      color: Colors.lightBlue,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ListView.builder(
                              controller: controller.scrollController,
                              itemCount: controller.data.length,
                              itemBuilder: (context, index) {
                                if (controller.data.isNotEmpty) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: maxHeight * 0.02),
                                    child: MessageTile(
                                      message: controller.data[index]["text"],
                                      isUser: controller.data[index]["isUser"],
                                    ),
                                  );
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          controller.isTyping.value
                              ?  SizedBox(
                                  width: maxWidth * 0.18,
                                  child: Lottie.asset(
                                      "assets/animations/typing.json",
                                      fit: BoxFit.fill))
                              : const SizedBox()
                        ],
                      ),
              ),
            ),
          ),
          PromptField(
            promptController: controller.promptController,
            onSend: () async {
              controller.scrollToBottom();
              final text = controller.promptController.text.toString().trim();
              controller.promptController.clear();

              if (text.isNotEmpty) {
                controller.data.add({"text": text, "isUser": true});

                await controller.getResponse(prompt: text);
                controller.scrollToBottom();
              }
            },
          ),
        ],
      ),
    );
  }
}
