import '../models/sermon.dart';

class SermonParser {
  static final RegExp bibleRegex = RegExp(
    r'\b(G[eê]n(?:esis)?|Ex(?:odo|[êe]x)?|Lev(?:[ií]tico)?|N[uú]m(?:eros)?|Deut(?:eron[ôo]mio)?|Dt|Js|Josu[eé]|Ju[ií]zes|Jz|Rute|Rt|1\s*Sm|2\s*Sm|1\s*Rs|2\s*Rs|1\s*Cr|2\s*Cr|Esd|Ne|Et|Ester|J[oó]|Salmos?|Sl|Prov[eé]rbios?|Pv|Ecl(?:esiastes)?|Ct|Cantares|Is(?:a[ií]as)?|Jr|Jeremias|Lm|Lamenta[çc][õo]es|Ez(?:equiel)?|Dn|Daniel|Os(?:[eé]ias)?|Jl|Joel|Am(?:[oó]s)?|Ob|Obadias|Jn|Jonas|Mq|Miqu[eé]ias|Na|Naum|Hc|Habacuque|Sf|Sofonias|Ag|Ageu|Zc|Zacarias|Ml|Malaquias|Mt|Mateus|Mc|Marcos|Lc|Lucas|Jo(?:[aã]o)?|At(?:os)?|Rm|Romanos|1\s*Co(?:r[ií]ntios)?|2\s*Co(?:r[ií]ntios)?|Gl|G[aá]latas|Ef|Ef[eé]sios|Fp|Filipenses|Cl|Colossenses|1\s*Ts|2\s*Ts|1\s*Tm|2\s*Tm|Tt|Tito|Fm|Filemon|Hb|Hebreus|Tg|Tiago|1\s*Pe|2\s*Pe|1\s*Jo|2\s*Jo|3\s*Jo|Jd|Judas|Ap(?:ocalipse)?)\.?\s*(\d+)(?:[:\.](\d+)(?:[-–](\d+))?)?',
    caseSensitive: false,
  );

  static List<SermonBlock> parseRawText(String text) {
    final lines = text
        .split(RegExp(r'\n+'))
        .map((l) => l.trim())
        .where((l) => l.isNotEmpty)
        .toList();

    List<SermonBlock> blocks = [];

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];
      final matches = bibleRegex.allMatches(line);
      final verses = matches.map((m) => m.group(0)!.trim()).toSet().toList();

      if (i == 0 && line.length < 80 && !RegExp(r'^[0-9I|V|X]+\.').hasMatch(line)) {
        blocks.add(SermonBlock(type: 'title', text: line, verses: verses));
      } else if (i == 1 && line.length < 60 && !line.contains(':')) {
        blocks.add(SermonBlock(type: 'subtitle', text: line, verses: verses));
      } else if (line.endsWith(':') ||
          RegExp(r'^[I|V|X]+\.').hasMatch(line) ||
          RegExp(r'^[0-9]+\.').hasMatch(line) ||
          (line.length < 40 && line == line.toUpperCase() && line.length > 3)) {
        blocks.add(SermonBlock(type: 'heading', text: line, verses: verses));
      } else if (line.startsWith('"') || line.startsWith('“')) {
        blocks.add(SermonBlock(type: 'quote', text: line, verses: verses));
      } else {
        blocks.add(SermonBlock(type: 'paragraph', text: line, verses: verses));
      }
    }

    return blocks;
  }
}
