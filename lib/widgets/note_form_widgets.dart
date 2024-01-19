import 'package:flutter/material.dart';

class NoteFormWidget extends StatelessWidget {
  const NoteFormWidget(
      {Key? key,
      required this.isImportant,
      required this.number,
      required this.title,
      required this.description,
      required this.onChangeIsImportant,
      required this.onChangeNumber,
      required this.onChangeTitle,
      required this.onChangeDescription})
      : super(key: key);

  final bool isImportant;
  final int number;
  final String title;
  final String description;
  final ValueChanged<bool> onChangeIsImportant;
  final ValueChanged<int> onChangeNumber;
  final ValueChanged<String> onChangeTitle;
  final ValueChanged<String> onChangeDescription;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Switch(value: isImportant, onChanged: onChangeIsImportant),
                Expanded(
                  child: Slider(
                    value: number.toDouble(),
                    onChanged: (value) => onChangeNumber(value.toInt()),
                    min: 0,
                    max: 5,
                    divisions: 5,
                  ),
                ),
              ],
            ),
            buildTitleField(),
            const SizedBox(
              height: 8,
            ),
            buildDescriptionField(),
          ],
        ),
      ),
    );
  }

  TextFormField buildTitleField() {
    return TextFormField(
      maxLines: 1,
      initialValue: title,
      decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Title',
          hintStyle: TextStyle(color: Colors.grey)),
      validator: (title) {
        return title != null && title.isEmpty
            ? 'title tidak boleh kosong'
            : null;
      },
      onChanged: onChangeTitle,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    );
  }

  TextFormField buildDescriptionField() {
    return TextFormField(
      maxLines: null,
      initialValue: description,
      decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Type Something...',
          hintStyle: TextStyle(color: Colors.grey)),
      validator: (description) {
        return description != null && description.isEmpty
            ? 'description tidak boleh kosong'
            : null;
      },
      onChanged: onChangeDescription,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    );
  }
}
