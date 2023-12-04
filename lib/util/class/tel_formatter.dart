import 'package:flutter/services.dart';

class TelFormatter extends TextInputFormatter {
  final List<String>? masks;
  final String? separator;
  String _prevMask = "";

  TelFormatter({
    this.masks,
    this.separator,
  });

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = newValue.text;
    final oldText = oldValue.text;

    if (newText.isEmpty ||
        newText.length < oldText.length ||
        masks == null ||
        separator == null) {
      return newValue;
    }

    final pasted = (newText.length - oldText.length).abs() > 1;
    final mask = masks!.firstWhere(
      (value) {
        final maskValue = pasted ? value.replaceAll(separator!, '') : value;
        return newText.length <= maskValue.length;
      },
      orElse: () => "",
    );

    if (mask.isEmpty) {
      return oldValue;
    }

    final needReset =
        (_prevMask != mask || newText.length - oldText.length > 1);
    _prevMask = mask;

    if (needReset) {
      final text = newText.replaceAll(separator!, '');
      String resetValue = '';
      int sep = 0;

      for (int i = 0; i < text.length; i++) {
        if (mask[i + sep] == separator) {
          resetValue += separator!;
          ++sep;
        }
        resetValue += text[i];
      }

      return TextEditingValue(
          text: resetValue,
          selection: TextSelection.collapsed(
            offset: resetValue.length,
          ));
    }

    if (newText.length < mask.length &&
        mask[newText.length - 1] == separator!) {
      final text = '$oldText$separator${newText.substring(newText.length - 1)}';
      return TextEditingValue(
        text: text,
        selection: TextSelection.collapsed(
          offset: text.length,
        ),
      );
    }

    return newValue;
  }
}
