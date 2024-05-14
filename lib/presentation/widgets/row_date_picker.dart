import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localpharm/core/extensions/extensions.dart';

class RowDatePicker extends StatefulWidget {
  final Function dateSelected;
  final DateTime? expiryDate;
  const RowDatePicker({
    super.key,
    required this.dateSelected,
    this.expiryDate,
  });

  @override
  State<RowDatePicker> createState() => _RowDatePickerState();
}

class _RowDatePickerState extends State<RowDatePicker> {
  late DateTime expiryDate;
  @override
  void initState() {
    super.initState();
    expiryDate = widget.expiryDate ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final size = context.deviceSize;
    return Container(
      width: size.width,
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: context.colorScheme.outline,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              DateFormat.yM().format(expiryDate),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          IconButton(
            onPressed: () async {
              final date = await showDatePicker(
                context: context,
                firstDate: DateTime.now(),
                lastDate: DateTime(DateTime.now().year + 10),
              );
              if (date == null) {
                return;
              }
              setState(() {
                expiryDate = date;
              });
              widget.dateSelected(expiryDate);
            },
            icon: const Icon(
              Icons.calendar_month_outlined,
            ),
          )
        ],
      ),
    );
  }
}
