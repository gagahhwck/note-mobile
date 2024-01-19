import 'package:flutter/material.dart';
import 'package:note_app/database/note_database.dart';
import 'package:note_app/model/note.dart';
import 'package:note_app/pages/note_page.dart';
import 'package:note_app/widgets/note_form_widgets.dart';

class AddEditNotePage extends StatefulWidget {
  final Note? note;
  const AddEditNotePage({super.key, this.note});

  @override
  State<AddEditNotePage> createState() => _AddEditNotePageState();
}

class _AddEditNotePageState extends State<AddEditNotePage> {
  late bool isImportant;
  late int number;
  late String title;
  late String description;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isImportant = widget.note?.isImportant ?? false;
    number = widget.note?.number ?? 0;
    title = widget.note?.title ?? "";
    description = widget.note?.description ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add Edit Note'),
        actions: [_buildButtonSave()],
      ),
      body: Form(
        key: _formKey,
        child: NoteFormWidget(
            isImportant: isImportant,
            number: number,
            title: title,
            description: description,
            onChangeIsImportant: (value) {
              setState(() {
                isImportant = value;
              });
            },
            onChangeNumber: (value) {
              setState(() {
                number = value;
              });
            },
            onChangeTitle: (value) {
              title = value;
            },
            onChangeDescription: (value) {
              description = value;
            }),
      ),
    );
  }

  _buildButtonSave() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        onPressed: () async {
          final isValid = _formKey.currentState!.validate();
          if (isValid) {
            if (widget.note != null) {
              // update
              await updateNote();
              // Navigator.pop(context);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => NotePage()),
                  (route) => false);
            } else {
              // Tambah data
              await addNote();
              // kembali ke page sebelumnya
              Navigator.pop(context);
            }
          }
        },
        child: const Icon(Icons.save_alt),
      ),
    );
  }

  Future addNote() async {
    final note = Note(
        isImportant: isImportant,
        number: number,
        title: title,
        description: description,
        createdTime: DateTime.now());
    await NoteDatabase.instance.create(note);
  }

  Future updateNote() async {
    final note = widget.note?.copy(
      isImportant: isImportant,
      number: number,
      title: title,
      description: description,
      createdTime: DateTime.now(),
    );
    await NoteDatabase.instance.udateNote(note!);
  }
}
