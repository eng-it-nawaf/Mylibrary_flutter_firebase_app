import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:onboarding_app/presentation/viewmodels/book_viewmodel.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bookVM = Provider.of<BookViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('تاريخ الكتب', style: TextStyle(fontFamily: 'STC')),
      ),
      body: bookVM.isLoading
          ? const Center(child: CircularProgressIndicator())
          : bookVM.books.isEmpty
          ? const Center(
        child: Text(
          'لا توجد كتب بعد',
          style: TextStyle(fontSize: 18, fontFamily: 'STC'),
        ),
      )
          : ListView.builder(
        itemCount: bookVM.books.length,
        itemBuilder: (context, index) {
          final book = bookVM.books[index];
          return Card(
            margin: const EdgeInsets.all(8),
            elevation: 4,
            child: ListTile(
              leading: book.imagePath.isNotEmpty
                  ? Image.file(
                File(book.imagePath),
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              )
                  : Container(
                width: 50,
                height: 50,
                color: Colors.grey,
                child: const Icon(Icons.book, color: Colors.white),
              ),
              title: Text(
                book.name,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontFamily: 'STC'),
              ),
              subtitle: Text(
                '${book.author} - ${book.year}',
                style: const TextStyle(fontFamily: 'STC'),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  if (book.id != null) {
                    bookVM.deleteBook(book.id!);
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}