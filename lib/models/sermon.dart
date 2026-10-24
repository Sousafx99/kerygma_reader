class SermonBlock {
  String type; // 'title', 'subtitle', 'heading', 'paragraph', 'quote'
  String text;
  List<String> verses;
  String note;

  SermonBlock({
    required this.type,
    required this.text,
    List<String>? verses,
    this.note = '',
  }) : verses = verses ?? [];

  Map<String, dynamic> toJson() => {
    'type': type,
    'text': text,
    'verses': verses,
    'note': note,
  };

  factory SermonBlock.fromJson(Map<String, dynamic> json) => SermonBlock(
    type: json['type'] ?? 'paragraph',
    text: json['text'] ?? '',
    verses: (json['verses'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
    note: json['note'] ?? '',
  );
}

class Sermon {
  String title;
  String subtitle;
  String series;
  List<SermonBlock> blocks;

  Sermon({
    required this.title,
    this.subtitle = '',
    this.series = '',
    required this.blocks,
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'subtitle': subtitle,
    'series': series,
    'blocks': blocks.map((b) => b.toJson()).toList(),
  };

  factory Sermon.fromJson(Map<String, dynamic> json) => Sermon(
    title: json['title'] ?? 'Sermão',
    subtitle: json['subtitle'] ?? '',
    series: json['series'] ?? '',
    blocks: (json['blocks'] as List<dynamic>?)
            ?.map((e) => SermonBlock.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
  );
}
