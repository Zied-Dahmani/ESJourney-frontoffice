import 'package:esjourney/utils/screen_size.dart';
import 'package:esjourney/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  DatePicker({Key? key,this.title, this.updateValue})
      : super(key: key);

  var title;
  final updateValue;

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime(1999, 08, 31),
          firstDate: DateTime(1970),
          lastDate: DateTime(DateTime.now().year - 10),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: theme.colorScheme.primary, // header background color
                  onPrimary: theme.colorScheme.onPrimary, // header text color
                  onSurface: theme.colorScheme.onSurface, // body text color
                ),
                dialogBackgroundColor: theme.colorScheme.surface,
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor:
                        theme.colorScheme.primary, // button text color
                  ),
                ),
              ),
              child: child!,
            );
          },
        );

        if (pickedDate != null) {
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          setState(() {
            widget.title = formattedDate;
            widget.updateValue(formattedDate);
          });
        }
      },
      child: Container(
        height: AppSizes.kbuttonHeight + 10,
        width: ScreenSize.width(context),
        padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.kbigSpace, vertical: AppSizes.kbigSpace),
        decoration: BoxDecoration(
          color: theme.colorScheme.background,
          borderRadius: BorderRadius.circular(AppSizes.kradius),
          border: Border.all(
            color: theme.colorScheme.tertiary,
          ),
        ),
        child: Text(widget.title),
      ),
    );
  }
}
