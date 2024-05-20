import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'constants.dart';
import 'package:flutter/material.dart';

typedef CallbackButtonTap = void Function({String buttonText});

class KeyboardButtons extends StatelessWidget {
  const KeyboardButtons(
      {super.key, required this.buttons, required this.onTap});

  final String buttons;
  final CallbackButtonTap onTap;

  bool _colorTextButtons() {
    return (buttons == DEL_SIGN ||
        buttons == DECIMAL_POINT_SIGN ||
        buttons == CLEAR_ALL_SIGN ||
        buttons == MODULAR_SIGN ||
        buttons == PLUS_SIGN ||
        buttons == MINUS_SIGN ||
        buttons == MULTIPLICATION_SIGN ||
        buttons == DIVISION_SIGN ||
        buttons == EXCHANGE_CALCULATOR ||
        buttons == PI ||
        buttons == SQUARE_ROOT_SIGN ||
        buttons == POWER_SIGN ||
        buttons == LN_SIGN ||
        buttons == LG_SIGN ||
        buttons == SIN_SIGN ||
        buttons == COS_SIGN ||
        buttons == TAN_SIGN ||
        buttons == RAD_SIGN ||
        buttons == DEG_SIGN ||
        buttons == ARCSIN_SIGN ||
        buttons == ARCCOS_SIGN ||
        buttons == ARCTAN_SIGN ||
        buttons == LN2_SIGN ||
        buttons == E_NUM ||
        buttons == LEFT_QUOTE_SIGN ||
        buttons == RIGHT_QUOTE_SIGN);
  }

  bool _fontSize() {
    return (buttons == LN_SIGN ||
        buttons == LG_SIGN ||
        buttons == SIN_SIGN ||
        buttons == COS_SIGN ||
        buttons == TAN_SIGN ||
        buttons == RAD_SIGN ||
        buttons == DEG_SIGN ||
        buttons == ARCSIN_SIGN ||
        buttons == ARCCOS_SIGN ||
        buttons == ARCTAN_SIGN ||
        buttons == LN2_SIGN ||
        buttons == LEFT_QUOTE_SIGN ||
        buttons == RIGHT_QUOTE_SIGN);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: SizedBox(
            height: screenWidth > 800 ? 70.h : 110.h,
            width: 100.w,
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  (buttons == EQUAL_SIGN)
                      ? Colors.deepOrangeAccent
                      : Theme.of(context).colorScheme.background,
                ),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  const EdgeInsets.symmetric(vertical: 10.0),
                ),
                foregroundColor: MaterialStateProperty.all<Color>(
                  (_colorTextButtons())
                      ? Colors.deepOrangeAccent
                      : (buttons == EQUAL_SIGN)
                          ? Theme.of(context).colorScheme.secondary
                          : Theme.of(context).colorScheme.outline,
                ),
                textStyle: MaterialStateProperty.all<TextStyle>(
                  TextStyle(fontSize: _fontSize() ? 30.sp : 30.sp),
                ),
              ),
              child: Text(buttons),
              onPressed: () => onTap(buttonText: buttons),
            ),
          ),
        ),
      ),
    );
  }
}
