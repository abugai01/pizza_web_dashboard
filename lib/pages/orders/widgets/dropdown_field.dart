//https://stackoverflow.com/questions/49780858/flutter-dropdown-text-field
//TODO: переиспользовать, сделать общим

import 'package:flutter/material.dart';

class DropdownField extends StatefulWidget {
  final List<String> values;
  final String initialValue;
  final Function function;

  DropdownField(this.values,
      {required this.initialValue, required this.function});

  @override
  _DropdownFieldState createState() => _DropdownFieldState();
}

class _DropdownFieldState extends State<DropdownField> {
  String? _currentSelectedValue;

  @override
  Widget build(BuildContext context) {
    _currentSelectedValue = _currentSelectedValue == null
        ? widget.initialValue
        : _currentSelectedValue;

    return FormField<String>(
      //initialValue: widget.initialValue,
      builder: (FormFieldState<String> state) {
        return InputDecorator(
          decoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.black, fontSize: 12.0),
              errorStyle: TextStyle(color: Colors.redAccent, fontSize: 12.0),
              //hintText: 'Please select value',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
          isEmpty: _currentSelectedValue == '',
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _currentSelectedValue,
              isDense: true,
              isExpanded: true,
              onChanged: (String? newValue) {
                setState(() {
                  _currentSelectedValue = newValue;
                  state.didChange(newValue);
                });
                if (widget.function != null) widget.function(newValue);
              },
              items: widget.values.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, overflow: TextOverflow.visible),
                );
              }).toList(),
              style: TextStyle(fontSize: 12.0),
            ),
          ),
        );
      },
    );
  }
}
