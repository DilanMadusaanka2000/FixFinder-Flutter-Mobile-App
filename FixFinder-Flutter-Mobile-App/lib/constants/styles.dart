import 'package:checkfirebase/constants/colors.dart';
import 'package:flutter/material.dart';

const TextStyle descriptionStyle = TextStyle(
  fontSize: 15,
  color: textColor,
  fontWeight: FontWeight.w400,
);

const textInputDecoration = InputDecoration(
  hintText: "Email",
  fillColor: bgSolitude,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: lightBlue, width: 2),
    borderRadius: BorderRadius.all(Radius.circular(100)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: lightBlue, width: 2),
    borderRadius: BorderRadius.all(Radius.circular(100)),
  ),
);
