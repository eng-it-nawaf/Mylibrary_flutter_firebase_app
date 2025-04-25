import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:maktabati_app/presentation/viewmodels/book_viewmodel.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({super.key});

  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BookViewModel>().loadBooks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final bookVM = context.watch<BookViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('قائمة الكتب'),
      ),
      body: bookVM.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: bookVM.books.length,
        itemBuilder: (context, index) {
          final book = bookVM.books[index];
          return ListTile(
            title: Text(book.name),
            subtitle: Text(book.author),
            trailing: Text('${book.year}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add-book');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}