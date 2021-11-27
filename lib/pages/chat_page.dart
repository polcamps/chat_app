import 'dart:io';

import 'package:chat_app/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ChatPage extends StatefulWidget {

  static final routeName = "chat_page";

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin{
  
  final _inputController = TextEditingController();
  final _focusNode = new FocusNode();

  List<ChatMessage> _messages = [];

  bool _estaEscribiendo = false;
  
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
                itemCount: _messages.length,
                itemBuilder: ( _ , i) => _messages[i],
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
                onSubmitted: _handleSubmit,
                onChanged: (newVal){
                  if(newVal.trim().length > 0 && !_estaEscribiendo){
                    setState(() {
                      _estaEscribiendo = true;
                    });
                  }
                  else if(newVal.trim().length == 0 && _estaEscribiendo){
                    setState(() {
                      _estaEscribiendo = false;
                    });
                  }
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
                    child: IconTheme(
                      data: IconThemeData(
                        color: Colors.blue[400]
                      ),
                      child: IconButton(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        icon: Icon(Icons.send),
                        onPressed: _estaEscribiendo 
                          ? () => _handleSubmit(_inputController.text.trim())
                          : null
                      ),
                    ),
                  )
            )
          ]
        ),
      )
    );
  }

  _handleSubmit(String texto){

    if(texto.length == 0) return;
    //print(texto);
    _inputController.clear();
    _focusNode.requestFocus();

    final _newMessage = new ChatMessage(
      uid: "123", 
      texto: texto,
      animationController: AnimationController(vsync: this, duration: Duration(milliseconds: 500)),
    );
    _messages.insert(0, _newMessage);
    _newMessage.animationController.forward();

    setState(() {
      _estaEscribiendo = false;
    });
  }

  @override
  void dispose() {
    //TODO: Off del socket

    for(ChatMessage message in _messages){
      message.animationController.dispose();
    }

    super.dispose();
  }
}