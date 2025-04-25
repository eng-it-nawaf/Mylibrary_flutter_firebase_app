// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:maktabati_app/database/database_helper.dart';
// import 'package:maktabati_app/models/book.dart';
//
// class HistoryScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('تاريخ الكتب'),
//         backgroundColor: Colors.teal,
//       ),
//       body: FutureBuilder<List<Book>>(
//         future: DatabaseHelper().getBooks(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('خطأ: ${snapshot.error}'));
//           } else if (snapshot.data == null || snapshot.data!.isEmpty) {
//             return Center(child: Text('لا توجد كتب.'));
//           }
//
//           final books = snapshot.data!;
//           return ListView.builder(
//             itemCount: books.length,
//             itemBuilder: (context, index) {
//               return Card(
//                 margin: EdgeInsets.all(8),
//                 elevation: 4,
//                 child: ListTile(
//                   leading: books[index].imagePath.isNotEmpty
//                       ? Image.file(
//                     File(books[index].imagePath),
//                     width: 50,
//                     height: 50,
//                     fit: BoxFit.cover,
//                   )
//                       : Container(
//                     width: 50,
//                     height: 50,
//                     color: Colors.grey,
//                     child: Icon(Icons.image, color: Colors.white),
//                   ),
//                   title: Text(
//                     books[index].name,
//                     style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
//                   ),
//                   subtitle: Text(books[index].author),
//                   trailing: Icon(Icons.arrow_forward_ios, color: Colors.teal),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
