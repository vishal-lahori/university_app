import 'package:flutter/material.dart';

TextStyle kSendButtonTextStyle = TextStyle(
  color: Colors.indigo[100],
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

InputDecoration kMessageTextFieldDecoration = InputDecoration(
  hintText: 'Type your message here...',
  hintStyle: TextStyle(color: Colors.white54),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20.0),
  ),
);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.indigoAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.indigoAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
