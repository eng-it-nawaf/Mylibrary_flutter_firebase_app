// lib/presentation/viewmodels/book_viewmodel.dart
import 'package:flutter/material.dart';
import 'package:onboarding_app/domain/entities/book_entity.dart';
import 'package:onboarding_app/domain/usecases/book/add_book_usecase.dart';
import 'package:onboarding_app/domain/usecases/book/get_books_usecase.dart';
import 'package:onboarding_app/domain/usecases/book/delete_book_usecase.dart';

class BookViewModel extends ChangeNotifier {
  final GetBooksUseCase getBooksUseCase;
  final AddBookUseCase addBookUseCase;
  final DeleteBookUseCase deleteBookUseCase;

  BookViewModel({
    required this.getBooksUseCase,
    required this.addBookUseCase,
    required this.deleteBookUseCase,
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

  Future<void> deleteBook(int id) async {
    _isLoading = true;
    notifyListeners();

    try {
      await deleteBookUseCase.execute(id);
      await loadBooks();
    } catch (e) {
      debugPrint('Error deleting book: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}