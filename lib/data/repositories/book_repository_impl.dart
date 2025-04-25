import 'package:maktabati_app/domain/entities/book_entity.dart';
import 'package:maktabati_app/domain/repositories/book_repository.dart';
import 'package:maktabati_app/data/datasources/local/book_local_datasource.dart';
import 'package:maktabati_app/data/models/book_model.dart';

class BookRepositoryImpl implements BookRepository {
  final BookLocalDataSource localDataSource;

  BookRepositoryImpl(this.localDataSource);

  @override
  Future<List<BookEntity>> getBooks() async {
    final books = await localDataSource.getBooks();
    return books.map((book) => book.toEntity()).toList();
  }

  @override
  Future<int> addBook(BookEntity book) async {
    final bookModel = BookModel.fromEntity(book);
    return await localDataSource.insertBook(bookModel);
  }

  @override
  Future<void> deleteBook(int id) async {
    await localDataSource.deleteBook(id);
  }
}