import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grabgo/presentation/components/text/support_widget.dart';

import '../colors/colors.dart';

class Searchbar extends StatefulWidget {
  final String hintText;

  const Searchbar({super.key, required this.hintText});

  @override
  State<Searchbar> createState() => _SearchbarState();
}

class _SearchbarState extends State<Searchbar> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.only(left: 20.0, right: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: [surfaceColor, Color(0xFFF0F2F5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 1,
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
        border: Border.all(color: primaryColor.withOpacity(0.2), width: 1),
      ),
      width: MediaQuery.of(context).size.width,
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.hintText,
          hintStyle: AppText.lightTextFieldStyle(),
          suffixIcon: Icon(Icons.search, color: textPrimary),
        ),
      ),
    );
  }
}
