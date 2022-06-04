import 'package:flutter/material.dart';

class HLTextField extends StatefulWidget{
  final String label;
  const HLTextField({Key? key,this.label=""}):super(key: key);
  @override
  _HLTextField createState()=>_HLTextField();

}

class _HLTextField extends State<HLTextField>{
  TextEditingController _value=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(child: Column(children: <Widget>[
      Text(widget.label,textScaleFactor: 2,),
      TextField(
        controller: _value,
      ),

    ],

    ),);
  }

}