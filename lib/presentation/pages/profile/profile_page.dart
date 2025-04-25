// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io' show File;
// import 'package:flutter/foundation.dart'; // For kIsWeb
// import 'package:maktabati_app/database/database_helper.dart'; // Import DatabaseHelper
// import 'package:maktabati_app/models/book.dart'; // Import Book model
// import 'package:maktabati_app/screens/history_page.dart'; // Import HistoryScreen
//
// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({Key? key}) : super(key: key); // إضافة معلمة key هنا
//
//   @override
//   _ProfileScreenState createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController authorController = TextEditingController();
//   final TextEditingController yearController = TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();
//   String? imagePath; // Store selected image path
//
//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//     setState(() {
//       if (pickedFile != null) {
//         imagePath = pickedFile.path;
//       }
//     });
//   }
//
//   Widget _buildImageWidget() {
//     if (imagePath == null) {
//       return Container();
//     }
//
//     if (kIsWeb) {
//       // For web, use Image.network or Image.asset (if you can upload it)
//       return Image.network(imagePath!, width: 100, height: 100, fit: BoxFit.cover);
//     } else {
//       // For mobile platforms, use Image.file
//       return Image.file(File(imagePath!), width: 100, height: 100, fit: BoxFit.cover);
//     }
//   }
//
//   Future<void> _addBookToDatabase() async {
//     final String bookName = nameController.text;
//     final String authorName = authorController.text;
//     final int bookYear = int.tryParse(yearController.text) ?? 0;
//     final String description = descriptionController.text;
//
//     if (bookName.isNotEmpty && authorName.isNotEmpty && bookYear > 0) {
//       final book = Book(
//         name: bookName,
//         author: authorName,
//         year: bookYear,
//         description: description,
//         imagePath: imagePath ?? '', // Store image path or empty if not selected
//       );
//
//       // Save the book to the database
//       await DatabaseHelper().insertBook(book);
//
//       // Show a success message
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Book added successfully!')),
//       );
//
//       // Navigate to HistoryScreen after saving the book
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => HistoryScreen()),
//       );
//     } else {
//       // Show an error message if any field is invalid
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please fill all fields correctly!')),
//       );
//     }
//   }
//
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null) {
//       setState(() {
//         yearController.text = picked.year.toString(); // Update the year controller with the selected year
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add New Book'),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             TextField(
//               controller: nameController,
//               decoration: InputDecoration(
//                 labelText: 'Book Name',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 10),
//             TextField(
//               controller: authorController,
//               decoration: InputDecoration(
//                 labelText: 'Author Name',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 10),
//             GestureDetector(
//               onTap: () => _selectDate(context), // Open date picker when tapped
//               child: AbsorbPointer(
//                 child: TextField(
//                   controller: yearController,
//                   decoration: InputDecoration(
//                     labelText: 'Year',
//                     border: OutlineInputBorder(),
//                     suffixIcon: Icon(Icons.calendar_today), // Add a calendar icon
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),
//             TextField(
//               controller: descriptionController,
//               decoration: InputDecoration(
//                 labelText: 'Description',
//                 border: OutlineInputBorder(),
//               ),
//               maxLines: 3,
//             ),
//             SizedBox(height: 10),
//             _buildImageWidget(), // Call the image rendering widget
//             ElevatedButton(
//               onPressed: _pickImage,
//               child: Text('Pick Image'),
//             ),
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: _addBookToDatabase, // Call the method to add book to database
//               child: Text('Add Book'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
