import 'package:flutter/material.dart';
import 'package:nlw2021/shared/themes/app_colors.dart';
import 'package:nlw2021/shared/themes/app_text_styles.dart';
import 'package:nlw2021/shared/widgets/divider_vertical/divider_vertical_widget.dart';
import 'package:nlw2021/shared/widgets/label_button/label_button.dart';

class SetLabelButtons extends StatelessWidget {
  final String primaryLabel;
  final VoidCallback primaryPressed;
  final String secondaryLabel;
  final VoidCallback secondaryPressed;
  final bool enablePrimaryColor;

  const SetLabelButtons({
    Key? key,
    required this.primaryLabel,
    required this.primaryPressed,
    required this.secondaryLabel,
    required this.secondaryPressed,
    this.enablePrimaryColor = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.shape,
      height: 56,
      child: Row(
        children: [
          Expanded(
            child: LabelButton(
                label: primaryLabel,
                onPressed: primaryPressed,
                style: enablePrimaryColor ? TextStyles.buttonPrimary : null),
          ),
          DividerVerticalWidget(),
          Expanded(
            child: LabelButton(
              label: secondaryLabel,
              onPressed: secondaryPressed,
            ),
          ),
        ],
      ),
    );
  }
}
