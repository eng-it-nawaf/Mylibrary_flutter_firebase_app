import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:maktabati_app/presentation/viewmodels/book_viewmodel.dart';
import 'package:maktabati_app/data/models/book_model.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bookVM = Provider.of<BookViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: FutureBuilder(
        future: bookVM.loadBooks(),
        builder: (context, snapshot) {
          if (bookVM.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: bookVM.books.length,
            itemBuilder: (context, index) {
              final book = bookVM.books[index];
              return ListTile(
                title: Text(book.name), // تم تغيير من book.title إلى book.name
                subtitle: Text(book.author),
              );
            },
          );
        },
      ),
    );
  }
}