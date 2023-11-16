class Verse {
  final String book;
  final int chapter;
  final int verse;
  final String text;
  final int? start;
  final int? end;
  Verse(
      {required this.book,
      required this.chapter,
      required this.verse,
      required this.text,
      this.start,
      this.end});

  String getRef() {
    return "$book $chapter:$verse";
  }
}
