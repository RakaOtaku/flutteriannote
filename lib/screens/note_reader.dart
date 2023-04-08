import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/style/app_style.dart';

class NoteReaderScreen extends StatefulWidget {
  NoteReaderScreen(this.doc, {super.key});
  QueryDocumentSnapshot doc;

  @override
  State<NoteReaderScreen> createState() => _NoteReaderScreenState();
}

class _NoteReaderScreenState extends State<NoteReaderScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late int _colorId;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.doc['note_title']);
    _contentController =
        TextEditingController(text: widget.doc['note_content']);
    _colorId = widget.doc['color_id'];
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _updateNote() async {
    await FirebaseFirestore.instance
        .collection('Notes')
        .doc(widget.doc.id)
        .update({
      'note_title': _titleController.text,
      'note_content': _contentController.text,
      'color_id': _colorId,
      'updated_at': DateTime.now(),
    });
    Navigator.of(context).pop();
  }
  void _deleteNote() async {
    await FirebaseFirestore.instance
        .collection('Notes')
        .doc(widget.doc.id)
        .delete();
    Navigator.of(context).pop();
  }

  void _showColorPickerDialog() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text('Pick a color'),
          content: SingleChildScrollView(
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: List.generate(
                AppStyle.cardsColor.length,
                (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      _colorId = index;
                    });
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 32.0,
                    height: 32.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppStyle.cardsColor[index],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[_colorId],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[_colorId],
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(Icons.color_lens),
            onPressed: _showColorPickerDialog,
          ),
          IconButton(
            icon: Icon(Icons.check),
            onPressed: _updateNote,
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: _deleteNote,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'Title',
                border: InputBorder.none,
              ),
              style: AppStyle.mainTitle,
            ),
            SizedBox(height: 10.0),
            Expanded(
              child: TextField(
                controller: _contentController,
                decoration: InputDecoration(
                  hintText: 'Note',
                  border: InputBorder.none,
                ),
                style: AppStyle.mainContent,
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
