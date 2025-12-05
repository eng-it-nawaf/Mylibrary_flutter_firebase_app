import '../../entities/book_entity.dart';
import '../../repositories/book_repository.dart';

class AddBookUseCase {
  final BookRepository repository;

  AddBookUseCase(this.repository);

  Future<int> execute(BookEntity book) {
    return repository.addBook(book);
  }
}