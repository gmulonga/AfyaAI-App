import 'package:flutter/material.dart';
import 'package:afyaai/utils/constants.dart';

class CustomDropdown extends StatelessWidget {
  final String label;
  final String? value;
  final List<String> items;
  final Function(String?) onChanged;

  const CustomDropdown({
    Key? key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          DropdownButtonFormField<String>(
            value: value,
            items:
            items
                .map(
                  (choice) => DropdownMenuItem<String>(
                value: choice,
                child: Text(choice),
              ),
            )
                .toList(),
            onChanged: onChanged,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 15.0,
                horizontal: 10,
              ),
              hintText: items.isNotEmpty ? items[0] : '',
              hintStyle: const TextStyle(color: kGrey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Colors.grey, width: 1.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: kGreen, width: 1.0),
              ),
            ),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
            icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
          ),
        ],
      ),
    );
  }
}