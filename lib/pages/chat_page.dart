import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ChatPage extends StatefulWidget {

  static final routeName = "chat_page";

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  
  final _inputController = TextEditingController();
  final _focusNode = new FocusNode();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          children: [
            CircleAvatar(
              child: Text("Me", style: TextStyle(fontSize: 12)),
              backgroundColor: Colors.blue[100],
              maxRadius: 14,
            ),
            SizedBox(height: 3),
            Text("Melissa Flores", style: TextStyle(color: Colors.black87, fontSize: 10))
          ],
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemBuilder: ( _ , i) => Text("$i"),
                reverse: true,
              )
            ),
            Divider(height: 1),
            Container(
              //height: 100,
              color: Colors.white,
              child: _inputChat(),
            )
          ],
        )
      ),
   );
  }

  Widget _inputChat(){
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _inputController,
                onSubmitted: (newVal){

                },
                onChanged: (newVal){
                  //TODO: cuando hay un valor, para poder postear
                },
                decoration: InputDecoration.collapsed(
                  hintText: "Enviar mensaje"
                ),
                focusNode: _focusNode,
              )
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              child: Platform.isIOS 
                ? CupertinoButton(
                    child: Text("Enviar"), 
                    onPressed: (){}
                  )
                : Container(
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    child: IconButton(
                      icon: Icon(Icons.send, color: Colors.blue[400],),
                      onPressed: (){}
                    ),
                  )
            )
          ]
        ),
      )
    );
  }
}