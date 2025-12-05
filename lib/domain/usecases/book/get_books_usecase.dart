import '../../entities/book_entity.dart';
import '../../repositories/book_repository.dart';

class GetBooksUseCase {
  final BookRepository repository;

  GetBooksUseCase(this.repository);

  Future<List<BookEntity>> execute() {
    return repository.getBooks();
  }
}