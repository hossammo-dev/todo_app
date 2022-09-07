import 'package:flutter/material.dart';

Widget buildDefaultFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  Function onSubmit,
  Function onChange,
  Function onTap,
  bool isPassword = false,
  @required Function validate,
  @required String label,
  @required IconData prefix,
  IconData suffix,
  Function suffixPressed,
  bool readOnly = false,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      readOnly: readOnly,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );

Widget buildTasksList(Map<String, dynamic> model) => ListTile(
      leading: CircleAvatar(
        radius: 35.0,
        child: Text(
          model['time'],
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ),
      title: Text(
        model['title'],
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      ),
      subtitle: Text(
        model['date'],
        style: TextStyle(
            color: Colors.grey[600], fontSize: 14, fontWeight: FontWeight.w300),
      ),
    );
