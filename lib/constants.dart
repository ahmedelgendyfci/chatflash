import 'package:flutter/material.dart';

class Constants {
  BoxDecoration kBoxDecoration =
      BoxDecoration(borderRadius: BorderRadius.circular(50), boxShadow: [
    BoxShadow(
      color: Color(0xff125589).withOpacity(0.5),
      spreadRadius: 1,
      blurRadius: 7,
      offset: Offset(0, 4),
    )
  ]);
}
