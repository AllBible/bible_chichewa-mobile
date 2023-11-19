class Highlight {
  final int id;
  final int book;
  final int chapter;
  final int verse;
  final int start;
  final int end;
  final String color;


  Highlight({
    required this.id,
    required this.book,
    required this.chapter,
    required this.verse,
    required this.start,
    required this.end,
    required this.color,
  });


  factory Highlight.fromJson(Map<String, dynamic> json) => Highlight(
        id: json['id'],
        book: json['book'],
        chapter: json['chapter'],
        verse: json['verse'],
        start: json['start'],
        end: json['end'],
        color: json['color'],
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'book': book,
      'chapter': chapter,
      'verse': verse,
      'start': start,
      'end': end,
      'color': color,
    };
  }
}
