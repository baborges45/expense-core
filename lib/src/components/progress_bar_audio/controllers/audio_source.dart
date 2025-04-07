class ProgressBarAudioSource {
  int id;
  String url;
  String title;
  String author;
  String? imageUrl;

  ProgressBarAudioSource({
    required this.id,
    required this.url,
    required this.title,
    required this.author,
    this.imageUrl,
  });
}
