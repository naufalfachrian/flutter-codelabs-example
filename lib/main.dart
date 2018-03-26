import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() => runApp(new YetAnotherChatClient());

class YetAnotherChatClient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Yet Another Chat Client',
      theme: new ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: new ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new ChatScreenState();
  }

}


class ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {

  final TextEditingController _textController = new TextEditingController();

  final List<ChatMessage> _messages = <ChatMessage>[];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Yet Another Chat Client'),
      ),
      body: new Column(
        children: <Widget>[
          new Flexible(
            child: new ListView.builder(
              itemBuilder: (_, int index) => _messages[index],
              itemCount: _messages.length,
              reverse: true,
              padding: new EdgeInsets.all(8.0),
            ),
          ),
          new Divider(height: 1.0,),
          new Container(
            decoration: new BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: _textComposer(),
          ),
        ],
      ),
    );
  }

  Widget _textComposer() {
    return new Container(
      margin: new EdgeInsets.symmetric(horizontal: 8.0),
      child: new Row(
        children: <Widget>[
          new Flexible(
            child: new TextField(
              controller: _textController,
              onSubmitted: _handleSubmitted,
              decoration: new InputDecoration.collapsed(hintText: 'Send a message'),
            ),
          ),
          new Container(
            margin: new EdgeInsets.symmetric(horizontal: 4.0),
            child: new IconButton(
              icon: new Icon(Icons.send),
              onPressed: () => _handleSubmitted(_textController.text)
            ),
          ),
        ],
      ),
    );
  }

  _handleSubmitted(String text) {
    _textController.clear();
    var message = new ChatMessage(
      text: text,
      animationController: new AnimationController(
        vsync: this,
        duration: new Duration(milliseconds: 250)
      ),
    );
    setState(() => _messages.insert(0, message));
    message.animationController.forward();
  }

  @override
  void dispose() {
    for (var message in _messages){
      message.animationController.dispose();
    }
    super.dispose();
  }

}

const String _name = 'Bunga Mungil';

class ChatMessage extends StatelessWidget {

  ChatMessage({@required this.text, @required this.animationController});

  final String text;

  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.symmetric(vertical: 10.0),
      child: new SizeTransition(
        sizeFactor: new CurvedAnimation(
          parent: animationController,
          curve: Curves.easeOut
        ),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              margin: new EdgeInsets.only(right: 16.0),
              child: new CircleAvatar(child: new Text(_name[0]),),
            ),
            new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(_name,
                  style: Theme.of(context).textTheme.subhead,
                ),
                new Container(
                  margin: new EdgeInsets.only(top: 5.0),
                  child: new Text(text),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}