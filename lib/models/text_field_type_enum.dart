import 'package:flutter/material.dart';

enum TextFieldTypeEnum {
  text,
  longText,
  number,
  email,
  password,
  datetime,
  file,
  dropdown,
}

extension TextFieldTypeEnumExtensio on TextFieldTypeEnum {
  TextInputType? get keyboardType {
    switch (this) {
      case TextFieldTypeEnum.text:
        return TextInputType.text;
      case TextFieldTypeEnum.longText:
        return TextInputType.multiline;
      case TextFieldTypeEnum.number:
        return TextInputType.number;
      case TextFieldTypeEnum.email:
        return TextInputType.emailAddress;
      case TextFieldTypeEnum.password:
        return TextInputType.visiblePassword;
      case TextFieldTypeEnum.datetime:
        return TextInputType.datetime;
      case TextFieldTypeEnum.file:
        return TextInputType.text;
      case TextFieldTypeEnum.dropdown:
        return TextInputType.text;
    }
  }
}
