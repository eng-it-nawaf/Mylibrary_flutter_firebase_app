import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:onboarding_app/domain/entities/book_entity.dart';
import 'package:onboarding_app/presentation/viewmodels/book_viewmodel.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String? imagePath;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        imagePath = pickedFile.path;
      }
    });
  }

  Widget _buildImageWidget() {
    if (imagePath == null) {
      return Container();
    }

    if (kIsWeb) {
      return Image.network(imagePath!,
          width: 100, height: 100, fit: BoxFit.cover);
    } else {
      return Image.file(File(imagePath!),
          width: 100, height: 100, fit: BoxFit.cover);
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        yearController.text = picked.year.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bookVM = Provider.of<BookViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('إضافة كتاب جديد', style: TextStyle(fontFamily: 'STC')),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'اسم الكتاب',
                labelStyle: TextStyle(fontFamily: 'STC'),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: authorController,
              decoration: const InputDecoration(
                labelText: 'اسم المؤلف',
                labelStyle: TextStyle(fontFamily: 'STC'),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: AbsorbPointer(
                child: TextField(
                  controller: yearController,
                  decoration: const InputDecoration(
                    labelText: 'سنة النشر',
                    labelStyle: TextStyle(fontFamily: 'STC'),
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'الوصف',
                labelStyle: TextStyle(fontFamily: 'STC'),
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 10),
            _buildImageWidget(),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('اختر صورة', style: TextStyle(fontFamily: 'STC')),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    authorController.text.isNotEmpty &&
                    yearController.text.isNotEmpty) {
                  final book = BookEntity(
                    name: nameController.text,
                    author: authorController.text,
                    year: int.parse(yearController.text),
                    description: descriptionController.text,
                    imagePath: imagePath ?? '',
                  );
                  bookVM.addBook(book);
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('الرجاء ملء جميع الحقول المطلوبة'),
                    ),
                  );
                }
              },
              child: const Text('إضافة الكتاب', style: TextStyle(fontFamily: 'STC')),
            ),
          ],
        ),
      ),
    );
  }
}