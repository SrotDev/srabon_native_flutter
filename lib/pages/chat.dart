import 'package:flutter/material.dart';
import 'package:srabon/pages/appbar.dart';
import 'dart:ui';

import 'package:srabon/pages/dashboard.dart';
import 'package:srabon/pages/drawer.dart';

//final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

class MessageData {
  final String message;
  final bool isAI;

  MessageData({required this.message, required this.isAI});
}

class Chat extends StatefulWidget {
  const Chat({super.key});

  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  bool isBangla = false;
  String name = "John";

  final List<MessageData> sampleMessages = [
    MessageData(message: "Hi there!", isAI: false),
    MessageData(
      message:
          "Hello! How can I assistsdvasdvaf adfvadvcvawefcwcewedc you today?",
      isAI: true,
    ),
    MessageData(message: "What's the weather like today?", isAI: false),
    MessageData(message: "It's sunny with a high of 27°C.", isAI: true),
    MessageData(message: "Thanks!", isAI: false),
    MessageData(message: "You're welcome!", isAI: true),
    MessageData(message: "Thanks!", isAI: false),
    MessageData(message: "You're welcome!", isAI: true),
    MessageData(message: "Thanks!", isAI: false),
    MessageData(message: "You're !", isAI: true),
  ];

  String currentMessage = "";
  bool isSendEnabled = false;

  void toggleLanguage(bool value) {
    setState(() {
      isBangla = value;
    });
    // You can add logic to switch app language here
  }

  void addMessage(List<MessageData> messages, MessageData message) {
    setState(() {
      messages.add(message);
    });
    Future.delayed(Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void deleteMessage(List<MessageData> messages) {
    setState(() {
      messages.clear();
    });
  }

  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: CustomAppBar(isBangla: false, onLanguageToggle: toggleLanguage),

      body: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: screenHeight,
          minWidth: screenWidth,
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                "assets/main.jpg", // Your background image
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Container(color: Color.fromARGB(150, 213, 254, 251)),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  const Color.fromARGB(255, 25, 219, 193),
                                  const Color.fromARGB(255, 89, 248, 211),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(30),
                                onTap: () {
                                  Navigator.of(context).pushReplacement(
                                    PageRouteBuilder(
                                      transitionDuration: Duration(
                                        milliseconds: 400,
                                      ),
                                      pageBuilder: (_, __, ___) => Dashboard(),
                                      transitionsBuilder:
                                          (_, animation, __, child) {
                                            return FadeTransition(
                                              opacity: animation,
                                              child: child,
                                            );
                                          },
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 12,
                                  ),
                                  child: Icon(Icons.arrow_back_ios_new),
                                ),
                              ),
                            ),
                          ),

                          Text(
                            "Chat with আভা.AI",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: screenHeight * 0.69,
                          minWidth: screenWidth * 0.82,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            //border: Border.all()
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                      255,
                                      180,
                                      255,
                                      215,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),

                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      "Hey, $name! I'm your friend আভা. I'm here to support you with your studies, clarify doubts, or just have a chat. Ask me anything to get started! 🚀",
                                      style: TextStyle(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                              // Message(message: sampleMessages[0].message, isAI: false)
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxHeight: screenHeight * 0.56,
                                  minWidth: screenWidth * 0.9,
                                ),
                                child: ChatBody(
                                  messages: sampleMessages,
                                  addMessage: addMessage,
                                  clearMessage: deleteMessage,
                                  scrollController: _scrollController,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(color: Colors.grey.shade300),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 5,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: TextField(
                                controller: _controller,
                                minLines: 1,
                                maxLines: 4, // Allow multiline input
                                decoration: InputDecoration(
                                  hintText: 'Write a message...',
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 12,
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    currentMessage = value;
                                    isSendEnabled = value.trim().isNotEmpty;
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          IconButton(
                            color: Colors.green,
                            iconSize: 30,
                            icon: Icon(Icons.send),
                            onPressed: isSendEnabled
                                ? () {
                                    addMessage(
                                      sampleMessages,
                                      MessageData(
                                        message: currentMessage,
                                        isAI: false,
                                      ),
                                    );
                                    _controller.clear();
                                    setState(() {
                                      currentMessage = "";
                                      isSendEnabled =
                                          false; // Disable send button
                                    });
                                  }
                                : null, // disables the button
                          ),

                          IconButton(
                            icon: Icon(Icons.mic),
                            iconSize: 30,
                            onPressed: () {
                              // Voice input logic
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      drawer: CustomDrawer()
    );
  }
}

class Message extends StatelessWidget {
  final String message;
  final bool isAI;

  const Message({required this.message, required this.isAI, super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isAI ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(vertical: 7, horizontal: 8),
        decoration: BoxDecoration(
          color: isAI ? Colors.white : const Color.fromARGB(255, 159, 239, 215),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 1,
              offset: Offset(0.5, 0.5),
            ),
          ],
        ),
        child: Text(message, style: TextStyle(fontSize: 16)),
      ),
    );
  }
}

class ChatBody extends StatelessWidget {
  final List<MessageData> messages;
  final Function(List<MessageData>, MessageData) addMessage;
  final Function(List<MessageData>) clearMessage;
  final ScrollController scrollController;

  const ChatBody({
    required this.messages,
    required this.addMessage,
    required this.clearMessage,
    required this.scrollController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 10),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final msg = messages[index];
        return Message(message: msg.message, isAI: msg.isAI);
      },
    );
  }
}
