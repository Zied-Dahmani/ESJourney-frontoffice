import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:esjourney/utils/screen_size.dart';
import 'package:esjourney/utils/theme.dart';
import 'package:flutter/material.dart';

class DropDownButton extends StatefulWidget {
  const DropDownButton(
      {Key? key, this.items, this.title, this.updateValue})
      : super(key: key);

  final items, title, updateValue;
  @override
  State<DropDownButton> createState() => _DropDownButtonState();
}

class _DropDownButtonState extends State<DropDownButton> {

  late List<String> items;
  String? selectedItem;

  @override
  void initState() {
    super.initState();
    items = widget.items;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        hint: Text(
          widget.title,
          style: theme.textTheme.bodyMedium,
          overflow: TextOverflow.ellipsis,
        ),
        items: items
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: theme.textTheme.bodyMedium,
                  ),
                ))
            .toList(),
        value: selectedItem,
        onChanged: (value) {
          setState(() {
            selectedItem = value;
            widget.updateValue(value);
          });
        },
        icon: const Icon(
          Icons.arrow_drop_down_rounded,
        ),
        iconEnabledColor: theme.colorScheme.primary,
        buttonHeight: AppSizes.kbuttonHeight + 10,
        buttonWidth: ScreenSize.width(context),
        buttonPadding:
            const EdgeInsets.symmetric(horizontal: AppSizes.kbigSpace),
        buttonDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.kradius),
          border: Border.all(
            color: theme.colorScheme.tertiary,
          ),
          color: theme.colorScheme.background,
        ),
        itemHeight: 40,
        dropdownMaxHeight: ScreenSize.height(context) / 3,
        dropdownWidth: ScreenSize.width(context) - AppSizes.kbigSpace * 2,
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.kradius),
          color: theme.colorScheme.background,
        ),
      ),
    );
  }
}
