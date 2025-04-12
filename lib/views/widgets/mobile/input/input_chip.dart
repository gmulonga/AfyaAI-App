import 'package:flutter/material.dart';
import 'package:afyaai/utils/constants.dart';

class InputChipsField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final List<String> items;
  final void Function(String) onAdd;
  final void Function(String) onRemove;

  const InputChipsField({
    super.key,
    required this.label,
    required this.controller,
    required this.items,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Text(label),
          ),
          Container(
            decoration: BoxDecoration(
              color: kWhite,
              border: Border.all(color: kGrey),
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: const EdgeInsets.only(left: 10, top: 2, bottom: 2),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: "Enter here",
                      hintStyle: TextStyle(color: kGrey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle, color: kGreen),
                  onPressed: () {
                    final text = controller.text.trim();
                    if (text.isNotEmpty) {
                      onAdd(text);
                      controller.clear();
                    }
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 6,
            runSpacing: -8,
            children: items.map((item) {
              return Chip(
                label: Text(item),
                backgroundColor: Colors.grey[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                deleteIcon: const Icon(Icons.cancel, size: 18),
                onDeleted: () => onRemove(item),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
