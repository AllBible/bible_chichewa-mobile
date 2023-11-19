class Comment {
  final int book;
  final int chapter;
  final int id;
  final String title;
  final String comment;
  Comment({
    required this.id,
    required this.book,
    required this.chapter,
    required this.title,
    required this.comment,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json['id'],
        book: json['book'],
        chapter: json['chapter'],
        title: json['title'],
        comment: json['comment'],
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'book': book,
      'chapter': chapter,
      'title': title,
      'comment': comment,
    };
  }
}
