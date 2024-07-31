part of 'book_bloc.dart';

sealed class BookEvents {}

final class GetBooks extends BookEvents {}

final class DownloadFile extends BookEvents {
  final BookModel book;

  DownloadFile({required this.book});
}

final class OpenFile extends BookEvents {
  final String path;

  OpenFile({required this.path});
}

final class UploadFile extends BookEvents {
  final String path;

  UploadFile({
    required this.path,
  });
}

final class SearchBookEvent extends BookEvents {
  final String query;

  SearchBookEvent({required this.query});
}