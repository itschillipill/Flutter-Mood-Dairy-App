import 'package:flutter/material.dart';

class TextAreaCard extends StatefulWidget {
  const TextAreaCard({
    super.key,
    required this.textEditingController,
    required this.onChanged,
  });

  final TextEditingController textEditingController;
  final VoidCallback onChanged;

  @override
  State<TextAreaCard> createState() => _TextAreaCardState();
}

class _TextAreaCardState extends State<TextAreaCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 5,
              offset: const Offset(-1, 4),
            )
          ],
          shape: BoxShape.rectangle,
        ),
        child: TextField(
          controller: widget.textEditingController,
          onChanged: (value) {
            widget.onChanged();
          },
          maxLines: 3,
          decoration: InputDecoration(
            hintText: "Введите заметку",
            border: OutlineInputBorder(borderSide: BorderSide.none),
          ),
        ),
      ),
    );
  }
}
