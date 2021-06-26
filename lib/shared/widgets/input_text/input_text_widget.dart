import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:nlw2021/shared/themes/app_colors.dart';
import 'package:nlw2021/shared/themes/app_text_styles.dart';

class InputTextWidget extends StatelessWidget {
  final String label;
  final IconData icon;
  final String? initialValue;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function(String value) onChanged;
  final TextInputType textInputType;

  const InputTextWidget(
      {Key? key,
      required this.label,
      required this.icon,
      this.initialValue,
      this.validator,
      this.controller,
      required this.onChanged,
      this.textInputType = TextInputType.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedCard(
      direction: AnimatedCardDirection.left,
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 16,
        ),
        child: Column(
          children: [
            TextFormField(
              keyboardType: textInputType,
              controller: controller,
              onChanged: onChanged,
              initialValue: initialValue,
              validator: validator,
              style: TextStyles.input,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                labelText: label,
                labelStyle: TextStyles.input,
                icon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                      ),
                      child: Icon(
                        icon,
                        color: AppColors.primary,
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 48,
                      color: AppColors.stroke,
                    )
                  ],
                ),
                border: InputBorder.none,
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: AppColors.stroke,
            )
          ],
        ),
      ),
    );
  }
}
