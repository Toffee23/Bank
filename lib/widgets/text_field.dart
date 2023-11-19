import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    Key? key,
    required this.hintText,
    this.controller,
    this.focusNode,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.obscureText = false,
    this.prefixText,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.validateOnTextChange = false,
    this.inputFormatters,
    this.onEditingComplete,
  }) : super(key: key);
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final bool validateOnTextChange;
  final String hintText;
  final String? prefixText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? onEditingComplete;

  final textListener = ValueNotifier<bool>(false);
  final focusListener = ValueNotifier<bool>(false);
  final errorTextListener = ValueNotifier<String?>(null);

  @override
  Widget build(BuildContext context) {
    textListener.value = controller?.text.isNotEmpty ?? false;
    focusListener.value = focusNode?.hasFocus ?? false;
    // final stateNotifier = TextFieldStateNotifier();

    // return Padding(
    //   padding: const EdgeInsets.only(bottom: 10.0),
    //   child: ValueListenableBuilder<bool>(
    //     valueListenable: stateNotifier.hasTextNotifier,
    //     builder: (context, hasText, child) {
    //       return Stack(
    //         children: <Widget>[
    //           ValueListenableBuilder<bool>(
    //             valueListenable: stateNotifier.isFocusedNotifier,
    //             builder: (context, isFocused, child) {
    //               return ValueListenableBuilder<String?>(
    //                 valueListenable: stateNotifier.errorTextNotifier,
    //                 builder: (context, errorText, child) {
    //                   return Focus(
    //                     onFocusChange: (value) {
    //                       stateNotifier.isFocusedNotifier.value = value;
    //                       value
    //                           ? focusNode?.requestFocus()
    //                           : focusNode?.unfocus();
    //                     },
    //                     child: TextFormField(
    //                       controller: controller,
    //                       focusNode: focusNode,
    //                       keyboardType: keyboardType,
    //                       textInputAction: textInputAction,
    //                       inputFormatters: inputFormatters,
    //                       validator: validator,
    //                       obscureText: obscureText,
    //                       onChanged: (value) {
    //                         stateNotifier.hasTextNotifier.value = value.isNotEmpty;
    //                         stateNotifier.errorTextNotifier.value =
    //                             validator?.call(controller!.text);
    //                       },
    //                       style: const TextStyle(fontSize: 14),
    //                       decoration: InputDecoration(
    //                         hintStyle: const TextStyle(fontSize: 14),
    //                         fillColor: Colors.grey.shade200,
    //                         filled: true,
    //                         isDense: true,
    //                         hintText: hintText,
    //                         errorText: errorText,
    //                         prefixText: isFocused || hasText ? hintText : null,
    //                         prefixIcon: prefixIcon == null
    //                             ? null
    //                             : Padding(
    //                           padding: const EdgeInsets.only(left: 4.0),
    //                           child: prefixIcon,
    //                         ),
    //                         suffixIcon: suffixIcon == null
    //                             ? null
    //                             : Card(
    //                           margin:
    //                           const EdgeInsets.only(right: 4.0),
    //                           color: Colors.transparent,
    //                           elevation: 0.0,
    //                           shape: const CircleBorder(),
    //                           clipBehavior: Clip.hardEdge,
    //                           child: suffixIcon,
    //                         ),
    //                         enabledBorder: OutlineInputBorder(
    //                           borderSide: BorderSide(
    //                             color: Colors.grey.shade400,
    //                             width: 1.5,
    //                           ),
    //                           borderRadius: BorderRadius.circular(20.0),
    //                         ),
    //                         focusedBorder: OutlineInputBorder(
    //                           borderRadius: BorderRadius.circular(20),
    //                           borderSide: BorderSide(
    //                             color: Theme.of(context).primaryColor,
    //                             width: 2.0,
    //                           ),
    //                         ),
    //                         errorBorder: OutlineInputBorder(
    //                           borderRadius: BorderRadius.circular(20),
    //                           borderSide: const BorderSide(
    //                             color: Colors.red,
    //                             width: 2.0,
    //                           ),
    //                         ),
    //                         border: OutlineInputBorder(
    //                           borderRadius: BorderRadius.circular(20),
    //                           borderSide: BorderSide(
    //                             color: Theme.of(context).primaryColor,
    //                             width: 2.0,
    //                           ),
    //                         ),
    //                         isCollapsed: true,
    //                         contentPadding: EdgeInsets.fromLTRB(
    //                           18.0,
    //                           stateNotifier.hasTextNotifier.value ? 25.0 : 17.0,
    //                           18.0,
    //                           stateNotifier.hasTextNotifier.value ? 11.0 : 17.0,
    //                         ),
    //                       ),
    //                     ),
    //                   );
    //                 },
    //               );
    //             },
    //           ),
    //           if (hasText)
    //             Positioned(
    //               top: 7,
    //               left: 50,
    //               child: Text(
    //                 hintText,
    //                 style: TextStyle(fontSize: 11, color: Colors.grey.shade700),
    //               ),
    //             ),
    //         ],
    //       );
    //     },
    //   ),
    // );

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: ValueListenableBuilder<bool>(
          valueListenable: textListener,
          builder: (context, hasText, child) {
            return Stack(
              children: <Widget>[
                ValueListenableBuilder<bool>(
                    valueListenable: focusListener,
                    builder: (context, isFocused, child) {
                      return ValueListenableBuilder<String?>(
                        valueListenable: errorTextListener,
                        builder: (context, errorText, child) {
                          return Focus(
                            onFocusChange: (value) {
                              focusListener.value = value;
                              value
                                  ? focusNode?.requestFocus()
                                  : focusNode?.unfocus();
                            },
                            child: TextFormField(
                              controller: controller,
                              focusNode: focusNode,
                              keyboardType: keyboardType,
                              textInputAction: textInputAction,
                              inputFormatters: inputFormatters,
                              validator: validator,
                              obscureText: obscureText,
                              onEditingComplete: onEditingComplete,
                              onChanged: (value) {
                                textListener.value = value.isNotEmpty;
                                // errorTextListener.value = validateOnTextChange ?
                                //   validator?.call(controller?.text) : null;
                                // print(validateOnTextChange);
                                // print(validator?.call(controller?.text));
                                // print(errorTextListener.value);
                                // print('');
                              },
                              style: const TextStyle(
                                fontSize: 14
                              ),
                              decoration: InputDecoration(
                                hintStyle: const TextStyle(
                                  fontSize: 14
                                ),
                                  fillColor: Colors.grey.shade200,
                                  filled: true,
                                  isDense: true,
                                  hintText: hintText,
                                  errorText: errorText,
                                  prefixText:
                                      isFocused || hasText ? prefixText : null,
                                  prefixIcon: prefixIcon == null
                                      ? null
                                      : Padding(
                                          padding: const EdgeInsets.only(left: 4.0),
                                          child: prefixIcon,
                                        ),
                                  suffixIcon: suffixIcon == null
                                      ? null
                                      : Card(
                                          margin: const EdgeInsets.only(right: 4.0),
                                          color: Colors.transparent,
                                          elevation: 0.0,
                                          shape: const CircleBorder(),
                                          clipBehavior: Clip.hardEdge,
                                          child: suffixIcon,
                                        ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade400, width: 1.5),
                                      borderRadius: BorderRadius.circular(20.0)),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                      width: 2.0,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                      width: 2.0,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                      width: 2.0,
                                    ),
                                  ),
                                  isCollapsed: true,
                                  contentPadding: EdgeInsets.fromLTRB(
                                    18.0,
                                    textListener.value ? 25.0 : 17.0,
                                    18.0,
                                    textListener.value ? 11.0 : 17.0,
                                  )),
                            ),
                          );
                        }
                      );
                    }),
                if (hasText)
                  Positioned(
                      top: 7,
                      left: 50,
                      child: Text(
                        hintText,
                        style: TextStyle(
                          fontSize: 11, color: Colors.grey.shade700),
                      )),
              ],
            );
          }),
    );
  }
}

class TextFieldStateNotifier {
  final ValueNotifier<bool> isFocusedNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<bool> hasTextNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<String?> errorTextNotifier = ValueNotifier<String?>(null);

  void dispose() {
    isFocusedNotifier.dispose();
    hasTextNotifier.dispose();
    errorTextNotifier.dispose();
  }
}

// class CustomTextField extends StatelessWidget {
//   final TextEditingController controller;
//   final FocusNode? focusNode;
//   final TextInputType keyboardType;
//   final TextInputAction textInputAction;
//   final List<TextInputFormatter>? inputFormatters;
//   final String? Function(String?)? validator;
//   final bool obscureText;
//   final String hintText;
//   final Widget? prefixIcon;
//   final Widget? suffixIcon;
//
//   CustomTextField({
//     required this.controller,
//     this.focusNode,
//     required this.keyboardType,
//     required this.textInputAction,
//     this.inputFormatters,
//     this.validator,
//     required this.obscureText,
//     required this.hintText,
//     this.prefixIcon,
//     this.suffixIcon,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final stateNotifier = TextFieldStateNotifier();
//
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 10.0),
//       child: ValueListenableBuilder<bool>(
//         valueListenable: stateNotifier.hasTextNotifier,
//         builder: (context, hasText, child) {
//           return Stack(
//             children: <Widget>[
//               ValueListenableBuilder<bool>(
//                 valueListenable: stateNotifier.isFocusedNotifier,
//                 builder: (context, isFocused, child) {
//                   return ValueListenableBuilder<String?>(
//                     valueListenable: stateNotifier.errorTextNotifier,
//                     builder: (context, errorText, child) {
//                       return Focus(
//                         onFocusChange: (value) {
//                           stateNotifier.isFocusedNotifier.value = value;
//                           value
//                               ? focusNode?.requestFocus()
//                               : focusNode?.unfocus();
//                         },
//                         child: TextFormField(
//                           controller: controller,
//                           focusNode: focusNode,
//                           keyboardType: keyboardType,
//                           textInputAction: textInputAction,
//                           inputFormatters: inputFormatters,
//                           validator: validator,
//                           obscureText: obscureText,
//                           onChanged: (value) {
//                             stateNotifier.hasTextNotifier.value = value.isNotEmpty;
//                             stateNotifier.errorTextNotifier.value =
//                                 validator?.call(controller.text);
//                           },
//                           style: const TextStyle(fontSize: 14),
//                           decoration: InputDecoration(
//                             hintStyle: const TextStyle(fontSize: 14),
//                             fillColor: Colors.grey.shade200,
//                             filled: true,
//                             isDense: true,
//                             hintText: hintText,
//                             errorText: errorText,
//                             prefixText: isFocused || hasText ? hintText : null,
//                             prefixIcon: prefixIcon == null
//                                 ? null
//                                 : Padding(
//                               padding: const EdgeInsets.only(left: 4.0),
//                               child: prefixIcon,
//                             ),
//                             suffixIcon: suffixIcon == null
//                                 ? null
//                                 : Card(
//                               margin:
//                               const EdgeInsets.only(right: 4.0),
//                               color: Colors.transparent,
//                               elevation: 0.0,
//                               shape: const CircleBorder(),
//                               clipBehavior: Clip.hardEdge,
//                               child: suffixIcon,
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: Colors.grey.shade400,
//                                 width: 1.5,
//                               ),
//                               borderRadius: BorderRadius.circular(20.0),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(20),
//                               borderSide: BorderSide(
//                                 color: Theme.of(context).primaryColor,
//                                 width: 2.0,
//                               ),
//                             ),
//                             errorBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(20),
//                               borderSide: const BorderSide(
//                                 color: Colors.red,
//                                 width: 2.0,
//                               ),
//                             ),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(20),
//                               borderSide: BorderSide(
//                                 color: Theme.of(context).primaryColor,
//                                 width: 2.0,
//                               ),
//                             ),
//                             isCollapsed: true,
//                             contentPadding: EdgeInsets.fromLTRB(
//                               18.0,
//                               stateNotifier.hasTextNotifier.value ? 25.0 : 17.0,
//                               18.0,
//                               stateNotifier.hasTextNotifier.value ? 11.0 : 17.0,
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//               if (hasText)
//                 Positioned(
//                   top: 7,
//                   left: 50,
//                   child: Text(
//                     hintText,
//                     style: TextStyle(fontSize: 11, color: Colors.grey.shade700),
//                   ),
//                 ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }


class PhoneNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty ||
        RegExp(r'\d').hasMatch(newValue.text) && newValue.text.length < 11) {
      return TextEditingValue(text: newValue.text);
    }

    return TextEditingValue(text: oldValue.text);
  }
}

class NumberInputFormatters extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String newText = newValue.text.replaceAll(RegExp(r'[^\d.]'), '');

    final int periodCount = newText.split('.').length - 1;
    if (periodCount > 1) newText = oldValue.text;

    int newSelection = newValue.selection.start;
    if (newSelection > newText.length) {
      newSelection = newText.length;
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newSelection),
    );
  }
}




class NumberInputFormatterAz extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    // Allow only digits and at most one period
    String newText = newValue.text.replaceAll(RegExp(r'[^0-9.]'), '');

    // Allow only one period
    int periodCount = newText.split('.').length - 1;
    if (periodCount > 1) {
      newText = oldValue.text;
    }

    // Handle the case where range.start is out of bounds
    int newSelection = newValue.selection.start;
    if (newSelection > newText.length) {
      newSelection = newText.length;
    }

    // Add commas as a delimiter for better readability
    newText = _addCommas(newText);

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newSelection),
    );
  }

  String _addCommas(String text) {
    List<String> parts = text.split('.');
    parts[0] = _formatIntegerPart(parts[0]);
    return parts.join('.');
  }

  String _formatIntegerPart(String integerPart) {
    final int groupSize = 3;
    final delimiter = ',';
    String result = '';
    int count = 0;

    for (int i = integerPart.length - 1; i >= 0; i--) {
      if (count != 0 && count % groupSize == 0) {
        result = '$delimiter$result';
      }
      result = integerPart[i] + result;
      count++;
    }

    return result;
  }
}


class NumberInputFormatterA extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    // Allow only digits and at most one period
    String newText = newValue.text.replaceAll(RegExp(r'[^0-9.]'), '');

    // Allow only one period
    int periodCount = newText.split('.').length - 1;
    if (periodCount > 1) {
      newText = oldValue.text;
    }

    // Handle the case where range.start is out of bounds
    int newSelection = newValue.selection.start;
    if (newSelection > newText.length) {
      newSelection = newText.length;
    }

    // Add commas as a delimiter for better readability and adjust insertion point
    AdjustedTextResult adjustedText = _addCommas(newText, oldValue.text, oldValue.selection);

    return TextEditingValue(
      text: adjustedText.text,
      selection: TextSelection.collapsed(offset: adjustedText.newSelection),
    );
  }

  AdjustedTextResult _addCommas(String newText, String oldText, TextSelection oldSelection) {
    List<String> newParts = newText.split('.');
    List<String> oldParts = oldText.split('.');

    String formattedIntegerPart = _formatIntegerPart(newParts[0]);

    int insertedCommasCount = formattedIntegerPart.length - oldParts[0].length;

    // Adjust the insertion point based on the number of inserted commas
    int newSelection = oldSelection.baseOffset + insertedCommasCount;

    // Combine the formatted parts
    String formattedText = formattedIntegerPart;
    if (newParts.length > 1) {
      formattedText += '.' + newParts[1];
    }

    return AdjustedTextResult(text: formattedText, newSelection: newSelection);
  }

  String _formatIntegerPart(String integerPart) {
    final int groupSize = 3;
    final delimiter = ',';
    String result = '';
    int count = 0;

    for (int i = integerPart.length - 1; i >= 0; i--) {
      if (count != 0 && count % groupSize == 0) {
        result = '$delimiter$result';
      }
      result = integerPart[i] + result;
      count++;
    }

    return result;
  }
}

class AdjustedTextResultA {
  final String text;
  final int newSelection;

  AdjustedTextResultA({required this.text, required this.newSelection});
}


class NumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    // Allow only digits and at most one period
    String newText = newValue.text.replaceAll(RegExp(r'[^0-9.]'), '');

    // Allow only one period
    int periodCount = newText.split('.').length - 1;
    if (periodCount > 1) {
      newText = oldValue.text;
    }

    // Handle the case where range.start is out of bounds
    int newSelection = newValue.selection.start;
    if (newSelection > newText.length) {
      newSelection = newText.length;
    }

    // Add commas as a delimiter for better readability and adjust insertion point
    AdjustedTextResult adjustedText = _addCommas(newText, oldValue.text, oldValue.selection);

    return TextEditingValue(
      text: adjustedText.text,
      selection: TextSelection.collapsed(offset: adjustedText.newSelection),
    );
  }

  AdjustedTextResult _addCommas(String newText, String oldText, TextSelection oldSelection) {
    List<String> newParts = newText.split('.');
    List<String> oldParts = oldText.split('.');

    String formattedIntegerPart = _formatIntegerPart(newParts[0]);

    int insertedCommasCount = formattedIntegerPart.length - oldParts[0].length;

    // Adjust the selection range based on the number of inserted commas
    int baseOffset = oldSelection.baseOffset + insertedCommasCount;
    int extentOffset = oldSelection.extentOffset + insertedCommasCount;

    // Ensure the selection stays within bounds
    baseOffset = baseOffset.clamp(0, formattedIntegerPart.length);
    extentOffset = extentOffset.clamp(0, formattedIntegerPart.length);

    // Combine the formatted parts
    String formattedText = formattedIntegerPart;
    if (newParts.length > 1) {
      formattedText += '.' + newParts[1];
    }

    return AdjustedTextResult(text: formattedText, newSelection: baseOffset);
  }

  String _formatIntegerPart(String integerPart) {
    final int groupSize = 3;
    final delimiter = ',';
    String result = '';
    int count = 0;

    for (int i = integerPart.length - 1; i >= 0; i--) {
      if (count != 0 && count % groupSize == 0) {
        result = '$delimiter$result';
      }
      result = integerPart[i] + result;
      count++;
    }

    return result;
  }
}

class AdjustedTextResult {
  final String text;
  final int newSelection;

  AdjustedTextResult({required this.text, required this.newSelection});
}

