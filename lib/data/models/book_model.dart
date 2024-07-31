class BookModel {
  final String title;
  final String bookUrl;
  final String coverageUrl;
  String savePath;
  double progress;
  bool isLoading;
  bool isDownloaded;

  BookModel({
    required this.title,
    required this.bookUrl,
    required this.coverageUrl,
    required this.savePath,
    required this.progress,
    required this.isLoading,
    required this.isDownloaded,
  });
}