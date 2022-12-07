import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class formcomp extends StatefulWidget {

  final String text;
  final TextInputType type;
  final TextEditingController controller;

  const formcomp({Key? key, 

  required this.text, 
  required this.type, 
  required this.controller,
  
  }) : super(key: key);

  @override
  State<formcomp> createState() => _formcompState();
}

class _formcompState extends State<formcomp> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.type,
        decoration: InputDecoration(
          label: Text(widget.text,style: TextStyle(color: Colors.black),),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.deepOrange.shade400, width: 2)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.deepOrange.shade400, width: 2),
                borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}
