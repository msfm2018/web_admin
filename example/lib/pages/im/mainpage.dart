import 'dart:io';
import 'package:flutter/material.dart';

// import 'helppage.dart';

// class MyApp1 extends StatelessWidget {
//   const MyApp1({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const CodeBookHomePage(),
//       routes: {'help': (context) => HelpPage()},
//     );
//   }
// }

class ChatMsgContent {
  String? fromname;
  String? text;
  bool isme = false;

  ChatMsgContent(this.fromname, this.text) : isme = fromname == "我" ? true : false;
}

//条目
class ChatMessage extends StatelessWidget {
  const ChatMessage({Key? key, required this.msg, required this.animationController}) : super(key: key);
  final ChatMsgContent msg;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        sizeFactor: CurvedAnimation(parent: animationController, curve: Curves.easeOut),
        // axisAlignment: 0.0,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisAlignment: msg.isme ? MainAxisAlignment.start : MainAxisAlignment.end,
            textDirection: msg.isme ? TextDirection.rtl : TextDirection.ltr,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 16.0),
                child: CircleAvatar(child: Text(msg.fromname!)),
              ),
              //  Flexible(
              //   child:
              GestureDetector(
                onTapDown: (TapDownDetails pos) {},
                // onLongPress: () async {
                //   // final RenderBox overlay = Overlay.of(context)!.context.findRenderObject() as RenderBox;
                //   // final RenderBox overlay = context.findRenderObject();
                //   // final value = await showMenu(context: context, position: RelativeRect.fromRect(_tapPosition & Size(40, 40), Offset.zero & overlay.size),
                //   // final value = await showMenu(context: context, position: RelativeRect.fromRect((_tapPosition & const Size(40, 40)), Offset.zero & overlay.size), items: [
                //   //   const PopupMenuItem(child: Text('复制'), value: 'copy'),
                //   //   const PopupMenuItem(
                //   //     child: Text('收藏'),
                //   //     value: 'favorite',
                //   //     enabled: false,
                //   //   ),
                //   // ]);
                //   // if (value == "copy") {
                //   //   Clipboard.setData(ClipboardData(text: msg.text));
                //   // }
                // },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(color: msg.isme ? Colors.lightGreenAccent[700] : Colors.white, borderRadius: BorderRadius.circular(10.0)),
                  child: Text(msg.text!),
                ),
              ),
              // ),
            ],
          ),
        ));
  }
}

class SendChatText extends StatefulWidget {
  const SendChatText({Key? key, required this.onSubmitted}) : super(key: key);

  final ValueChanged<String> onSubmitted;
  @override
  State<StatefulWidget> createState() {
    return SendChatTextState();
  }
}

class SendChatTextState extends State<SendChatText> {
  final TextEditingController _textController = TextEditingController();
  final FocusNode msgNode = FocusNode();

  bool _isComposing = false;
  void _handleOnSubmitted(BuildContext context, String text) {
    setState(() {
      _isComposing = false;
    });
    if (Platform.isWindows) {
      if (text[text.length - 1] == '\n') {
        text = text.substring(0, text.length - 1);
      }
      FocusScope.of(context).requestFocus(msgNode);
    }
    if (text.trim().isEmpty) return;

    widget.onSubmitted(text);
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      // decoration: Theme.of(context).platform == TargetPlatform.iOS ?
      // BoxDecoration(border: Border(top: BorderSide(color: Colors.grey))) : null,
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              maxLines: null,
              keyboardType: TextInputType.multiline,
              focusNode: msgNode,
              textInputAction: TextInputAction.done,
              controller: _textController,
              onChanged: (String text) {
                setState(() {
                  _isComposing = text.isNotEmpty;
                });
              },
              onSubmitted: (text) => _handleOnSubmitted(context, text),
              decoration: const InputDecoration.collapsed(hintText: "输入要加密的消息"),
            ),
          ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: const Icon(Icons.send),
                onPressed: _isComposing
                    ? () {
                        msgNode.unfocus();
                        _handleOnSubmitted(context, _textController.text);
                      }
                    : null,
              ))
        ],
      ),
    );
  }
}

class CodeBookHomePage extends StatefulWidget {
  const CodeBookHomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CodeBookHomePageState();
  }
}

class CodeBookHomePageState extends State<CodeBookHomePage> with TickerProviderStateMixin {
  final List<ChatMessage> _messages = <ChatMessage>[];

  DateTime? _lastPressedAt;

  void _addMessage(String fromname, String text) {
    ChatMessage message = ChatMessage(
      msg: ChatMsgContent(fromname, text),
      animationController: AnimationController(
        duration: const Duration(milliseconds: 700),
        vsync: this,
      ),
    );
    setState(() {
      _messages.insert(0, message);
    });
    //开启动画
    message.animationController.forward();
  }

  void _handleOnSubmitted(String text) {
    _addMessage("我", text);
  }

  void _onAppBarSelected(String value) {
    if (value == 'clean') {
      setState(() {
        _messages.clear();
      });
    } else if (value == "about") {}
  }

  @override
  void dispose() {
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if (_lastPressedAt == null || (DateTime.now().difference(_lastPressedAt!) > const Duration(seconds: 1))) {
            //两次点击间隔超过1秒，重新计时
            _lastPressedAt = DateTime.now();
            return false;
          }
          return true;
        },
        child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            child: Builder(builder: (context) {
              return Column(
                children: [
                  const Divider(height: 1.0),
                  Expanded(
                      child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    child: ListView.builder(
                        padding: const EdgeInsets.all(8.0),
                        reverse: true,
                        itemBuilder: (BuildContext context, int index) {
                          return _messages[index];
                        },
                        itemCount: _messages.length),
                  )),
                  const Divider(height: 1.0),
                  Container(
                    decoration: BoxDecoration(color: Theme.of(context).cardColor),
                    child: SendChatText(
                      onSubmitted: _handleOnSubmitted,
                    ),
                  ),
                ],
              );
            }

                ///
                )

            ///
            )

        ///
        // )

        ///
        );
  }
}
