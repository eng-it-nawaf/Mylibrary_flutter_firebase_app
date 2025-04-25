// import 'package:flutter/material.dart';
// import 'package:onboarding_app/domain/usecases/book/add_book_usecase.dart';
// import 'package:onboarding_app/domain/usecases/book/get_books_usecase.dart';
// import 'package:onboarding_app/data/models/book_model.dart';
//
// class BookViewModel with ChangeNotifier {
//   final GetBooksUseCase getBooksUseCase;
//   final AddBookUseCase addBookUseCase;
//
//   BookViewModel({
//     required this.getBooksUseCase,
//     required this.addBookUseCase,
//   });
//
//   List<BookModel> _books = [];
//   bool _isLoading = false;
//
//   List<BookModel> get books => _books;
//   bool get isLoading => _isLoading;
//
//   Future<void> loadBooks() async {
//     _isLoading = true;
//     notifyListeners();
//
//     try {
//       _books = await getBooksUseCase.execute();
//     } catch (e) {
//       debugPrint('Error loading books: $e');
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
//
//   Future<void> addBook(BookModel book) async {
//     try {
//       await addBookUseCase.execute(book);
//       await loadBooks(); // Refresh the list
//     } catch (e) {
//       debugPrint('Error adding book: $e');
//     }
//   }
// }

import 'package:flutter/material.dart';
import '../../../domain/entities/book_entity.dart';
import '../../../domain/usecases/book/add_book_usecase.dart';
import '../../../domain/usecases/book/get_books_usecase.dart';

class BookViewModel extends ChangeNotifier {
  final GetBooksUseCase getBooksUseCase;
  final AddBookUseCase addBookUseCase;

  BookViewModel({
    required this.getBooksUseCase,
    required this.addBookUseCase,
  });

  List<BookEntity> _books = [];
  bool _isLoading = false;

  List<BookEntity> get books => _books;
  bool get isLoading => _isLoading;

  Future<void> loadBooks() async {
    _isLoading = true;
    notifyListeners();

    try {
      _books = await getBooksUseCase.execute();
    } catch (e) {
      debugPrint('Error loading books: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addBook(BookEntity book) async {
    _isLoading = true;
    notifyListeners();

    try {
      await addBookUseCase.execute(book);
      await loadBooks();
    } catch (e) {
      debugPrint('Error adding book: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}