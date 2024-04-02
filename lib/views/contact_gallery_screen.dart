import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/color_constant.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = <ChatMessage>[];

  void _handleSubmitted(String text) {
    _textController.clear();
    ChatMessage message = ChatMessage(
      text: text,
      isSentByMe: true,
    );
    setState(() {
      _messages.insert(0, message);
    });

    // Simulating receiving a response after a short delay (for demonstration purposes)
    Future.delayed(Duration(seconds: 1), () {
      ChatMessage response = ChatMessage(
        text: 'Sample response from the other user.',
        isSentByMe: false,
      );
      setState(() {
        _messages.insert(0, response);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        title: Text('One-to-One Chat', style: TextStyle(
            fontSize: 18.sp,
            color: ColorConstants.black,fontWeight: FontWeight.bold),),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.only(left: 5.w,right: 5.w,top: 5.h,bottom: 5.h),
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (_, int index) => _messages[index],
            ),
          ),
          Divider(height: 1.h),
          Container(
            margin: EdgeInsets.only(bottom: 50.h),
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Colors.white),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 6.w),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration: InputDecoration.collapsed(hintText: 'Type a message'),
              ),
            ),
            IconButton(
              icon: Icon(Icons.send,color: Colors.black,),
              onPressed: () => _handleSubmitted(_textController.text),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isSentByMe;

  ChatMessage({required this.text, required this.isSentByMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: isSentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 5.w),
            child: CircleAvatar(
              backgroundColor: ColorConstants.purple,
                child: Text(isSentByMe ? 'Me' : 'Other',style: TextStyle(fontSize: 8.sp,color: Colors.white,fontWeight: FontWeight.w600),)),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(isSentByMe ? 'You' : 'Other User', style: TextStyle(fontWeight: FontWeight.bold)),
                Container(
                  margin: EdgeInsets.only(top: 5.h),
                  child: Text(text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
