import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:turismo_app/widgets/widgets.dart';

/* class ChatScreen extends StatelessWidget { */

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final List<Map<String,Object>> messages = [
    { 'name': 'Emma Scott',
      'first': true,
      'message': 'effort truth you lungs nuts meant rope image forest smoke card cave home brain possible palace heading time aloud ask triangle base report sudden'
    },
    { 'name': 'Emma Scott',
      'first': false,
      'message': 'safety zoo dog closer lesson tent consonant double anywhere across perfectly though valley desert clay of giving short'
    },
    { 'name': 'Emma Scott',
      'first': false,
      'message': 'accurate determine position'
    },
    { 'name': 'Isabelle Wilkins',
      'first': true,
      'message': 'gain our guard case easy electric black sold hungry flight wonder airplane flies essential highway factory peace exchange pipe struggle pretty fully program herd'
    },
    { 'name': 'Dorothy McDonald',
      'first': true,
      'message': 'practice let health consonant tears small'
    },
    { 'name': 'Dorothy McDonald',
      'first': false,
      'message': 'add raw enough said wish actually government knowledge quick talk sale quickly industry tie happen mile explore'
    },
    { 'name': 'Martin Hansen',
      'first': true,
      'message': 'pink scientific whether pay pilot horse orange far tax watch play belt brain stop flame speech tool event anyone avoid truth battle my part'
    },
    { 'name': 'Martin Hansen',
      'first': false,
      'message': 'negative central outer before setting bean spell sea human pride say radio cattle again shade something team'
    },
    { 'name': 'Martin Hansen',
      'first': false,
      'message': 'everybody company am curve made lying equipment grandmother sang definition exercise afraid essential had support wheel husband'
    },
    { 'name': 'Martin Hansen',
      'first': false,
      'message': 'greatest escape famous apple bit whispered cool fill crop harder driven which night person graph hole next progress whole'
    },
    { 'name': null,
      'first': true,
      'message': 'tobacco does loose above return loud jet cutting think leather top whether serve blow with slope sentence mathematics frame wood silence require from modern'
    },
    { 'name': null,
      'first': false,
      'message': 'sheep sea headed same birthday atom large'
    },
    { 'name': 'Lois Woods',
      'first': true,
      'message': 'horn task rhyme lamp floor length president occur shore toward stood individual according none someone butter chosen cause shut'
    },
    { 'name': 'Lois Woods',
      'first': false,
      'message': 'peace poetry buffalo memory whale pole last rocky breathe unusual surrounded aboard find eager'
    },
    { 'name': 'Lois Woods',
      'first': false,
      'message': 'write fear pupil whether pleasure to am duty water egg desert climb may gravity welcome'
    },
  ];
  final TextEditingController _textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  _processText() {
    String text = _textEditingController.text.trim();

    if (text.isNotEmpty) {
      final msg = {
        'name': null,
        'first': (messages.last['name'] == null ? false : true),
        'message': text
      }; 
      setState(() {
        messages.add(msg);
        _textEditingController.clear();
      });
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      });
    }
  }

  Widget _getMessages() {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      controller: _scrollController,
      children: 
        messages.map<Widget>((item) { 
          return MessageWidget(
            name: item['name'],
            message: item['message'],
            first: item['first'],
          );
        }).toList()
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Chat', 
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        /* leading: IconButton(
          icon: Icon(Icons.chat, color: Colors.white, size: 27.0,), 
          onPressed: null/* () => Navigator.pushNamed(context, '/filtros') */,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.filter_list, color: Colors.white, size: 30.0,), 
            onPressed: () => Navigator.pushNamed(context, '/filtros'),
          )
        ], */
        centerTitle: true,
      ),
      body: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          Expanded(
            child: _getMessages(),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              /* height: 45, */
              constraints: BoxConstraints(minHeight: 45, maxHeight: 150),
              margin: EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 15),
              padding: EdgeInsets.only(left: 20),
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(20)
              ),
              child: Flex( 
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Flexible(
                    child: TextField(
                      textCapitalization: TextCapitalization.sentences,
                      controller: _textEditingController,
                      /* onEditingComplete: _processText, */
                      decoration: InputDecoration(
                        hintText: 'Escribe un mensaje',
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                      minLines: 1,
                      maxLines: 6,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send, color: Colors.grey[800],),
                    onPressed: _processText,
                  )
                ]
              )
            )
          )
        ]
      ),
    );
  }
}