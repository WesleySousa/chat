import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TextComposer extends StatefulWidget {

  final Function({String text, File imageFile}) sendMessage;

  const TextComposer(this.sendMessage);

  @override
  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {
  final _controller = TextEditingController();
  bool _isComposing = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.photo_camera),
            onPressed: () async {
              final imagePicker = ImagePicker();
              final pickedFile = await imagePicker.getImage(source: ImageSource.camera);
              if (pickedFile == null) return;
              widget.sendMessage(imageFile: File(pickedFile.path));
            },
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration:
                  InputDecoration.collapsed(hintText: 'Enviar uma mensagem'),
              onChanged: (text) {
                setState(() {
                  _isComposing = text.isNotEmpty;
                });
              },
              onSubmitted: (text) {
                _sendMessage();
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _isComposing ? _sendMessage : null,
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    widget.sendMessage(text: _controller.text);
    _controller.clear();
    setState(() => _isComposing = false);
  }
}
