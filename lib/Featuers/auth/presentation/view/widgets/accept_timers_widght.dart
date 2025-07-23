import 'package:flutter/material.dart';
import 'package:meal_app/core/widgets/subtitel_text_widget.dart';

class AcceptTermsWidget extends StatelessWidget {
  const AcceptTermsWidget({
    super.key,
    required this.value,
    required this.onChanged,
  });
  final bool value;
  final Function(bool?) onChanged;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.orange,
        ),
        const SubtitelTextWidget(
          text: "Accept terms & Condition",
          fontSize: 12,
          color: Colors.orange,
        ),
      ],
    );
  }
}
