import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/sermon.dart';
import '../services/bible_service.dart';
import '../services/sermon_parser.dart';
import '../theme/app_theme.dart';

class ReaderScreen extends StatefulWidget {
  const ReaderScreen({super.key});

  @override
  State<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  // Sermão completo do usuário já predefinido
  late Sermon currentSermon;

  int currentParagraphIndex = 0;
  bool focusModeActive = true;
  String? activeVerseKey;

  // Tipografia
  String fontFamily = 'Literata'; // 'Literata' ou 'Inter'
  double fontSize = 19.0;
  FontWeight fontWeight = FontWeight.w600; // Pesada / Nítida
  double lineHeight = 1.75;
  ReaderThemeMode currentTheme = ReaderThemeMode.light;

  // Traduções selecionadas para comparação múltipla
  List<String> selectedTranslations = ['ARA'];

  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _initDefaultSermon();
  }

  void _initDefaultSermon() {
    currentSermon = Sermon(
      title: 'O lar como um reflexo da glória de Deus',
      subtitle: 'Sementes que perduram',
      series: 'Série: Família Cristã',
      blocks: [
        SermonBlock(type: 'heading', text: 'Abertura:'),
        SermonBlock(
          type: 'paragraph',
          text:
              'Agradeço primeiramente a Deus por ter me resgatado das profundezas do pecado. Agradeço ao nosso Senhor pela oportunidade de compartilhar suas bem-aventuranças, mostrar o seu amor e resplandecer a sua glória.',
        ),
        SermonBlock(
          type: 'paragraph',
          text:
              'Em terceiro lugar, agradeço aos meus queridos amigos, que me convocaram para trazer o estudo de hoje. Que Deus esteja no contínuo controle e nos ajude nessa difícil mensagem.',
        ),
        SermonBlock(type: 'heading', text: 'Objetivo:'),
        SermonBlock(
          type: 'paragraph',
          text:
              'Hoje desejo reforçar a compreensão do propósito de Deus ao instituir a família e aprender atitudes práticas para transformar a dinâmica do lar em um testemunho vivo para a glória de Deus. Dando sequência aos nossos estudos que têm como base o texto de 1 Coríntios 10:31.',
          verses: ['1 Coríntios 10:31'],
          note: 'Nota de introdução: Conectar com o tema de glória de Deus no cotidiano do lar.',
        ),
        SermonBlock(type: 'heading', text: 'Tese:'),
        SermonBlock(
          type: 'paragraph',
          text:
              'O lar cristão não existe para si mesmo, mas como um palco visível da graça divina em meio a uma sociedade fragmentada.',
        ),
        SermonBlock(type: 'heading', text: '1. A Preparação Antes do Edifício:'),
        SermonBlock(
          type: 'paragraph',
          text:
              'Em Provérbios 24:27 diz: "Cuide dos seus negócios lá fora, apronte a sua lavoura no campo e, depois, edifique a sua casa." A maioria segue a lógica de quem pisa fundo no acelerador e aciona o nitro num carro que está sem freio, batendo biela e com o motor fundido. Mas Provérbios 24:27 é sobre preparar o carro antes de ir pra pista, revisar o motor antes de pisar no acelerador. Primeiro lavra e fertiliza a terra, amadurece, cria estabilidade e aprende a sustentar a sua própria vida diante de Deus; só depois você pensa em edificar uma casa! Tem muita gente sonhando em brincar de casinha sem sequer ter plantado uma semente na lavoura. A solteirice não é um showroom; é uma oficina para regular a mecânica, revisar a elétrica e dar um tapa na funilaria. A solteirice é tempo de cultivar sua maturidade espiritual, emocional e profissional antes de convidar alguém para dividir a vida com você.',
          verses: ['Provérbios 24:27'],
          note: 'Enfatizar: A maturidade deve preceder a aliança. Não queime etapas na juventude.',
        ),
        SermonBlock(type: 'heading', text: '2. A Terceirização da Responsabilidade:'),
        SermonBlock(
          type: 'paragraph',
          text:
              'Existe um processo que atualmente engloba praticamente toda a nossa sociedade, em todos os aspectos, em todas as classes sociais, e está muito difundido nas igrejas: a terceirização. Nós viramos a sociedade que terceiriza tudo: a alimentação para o iFood, o transporte para o Uber, o entretenimento para a Netflix, e o discipulado das crianças para o Ministério Infantil da igreja. A salinha do culto infantil nunca foi criada para substituir o altar da sua sala de estar.',
          note: 'Alerta pastoral: O dever de discipular os filhos é dos pais, não da igreja.',
        ),
        SermonBlock(type: 'heading', text: '3. A Instrução Bíblica no Lar:'),
        SermonBlock(
          type: 'paragraph',
          text:
              'Efésios 6:1-4 nos ensina os fundamentos práticos do relacionamento entre pais e filhos segundo a instrução do Senhor.',
          verses: ['Efésios 6:1-4'],
          note: 'Enfatizar o mandamento com promessa aos filhos e a paciência dos pais.',
        ),
        SermonBlock(
          type: 'quote',
          text:
              '"Filhos, obedecei a vossos pais no Senhor, pois isto é justo. Honra a teu pai e a tua mãe... E vós, pais, não provoqueis vossos filhos à ira, mas criai-os na disciplina e na admoestação do Senhor."',
          verses: ['Efésios 6:1-4'],
        ),
        SermonBlock(
          type: 'paragraph',
          text:
              'O marido tampouco deve oprimir sua casa. Ele deve se dispor ao sacrifício e pagar o preço sempre que necessário, assim como Cristo se entregou pela Igreja.',
          verses: ['Efésios 5:21-33'],
          note: 'Liderança sacrificial em contraste com o autoritarismo mundano.',
        ),
      ],
    );
  }

  void _selectParagraph(int index, {bool scrollToTop = true}) {
    final paragraphBlocks = currentSermon.blocks.where((b) => b.type == 'paragraph' || b.type == 'quote').toList();
    if (index < 0 || index >= paragraphBlocks.length) return;

    setState(() {
      currentParagraphIndex = index;
      final block = paragraphBlocks[index];
      if (block.verses.isNotEmpty) {
        activeVerseKey = block.verses.first;
      } else {
        activeVerseKey = null;
      }
    });

    if (scrollToTop && _scrollController.hasClients) {
      final targetOffset = index * 180.0;
      _scrollController.animateTo(
        targetOffset.clamp(0.0, _scrollController.position.maxScrollExtent),
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
      );
    }
  }

  void _onKey(KeyEvent event) {
    if (event is KeyDownEvent) {
      final paragraphBlocks = currentSermon.blocks.where((b) => b.type == 'paragraph' || b.type == 'quote').toList();
      if (event.logicalKey == LogicalKeyboardKey.arrowDown || event.logicalKey == LogicalKeyboardKey.space) {
        if (currentParagraphIndex < paragraphBlocks.length - 1) {
          _selectParagraph(currentParagraphIndex + 1);
        }
      } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
        if (currentParagraphIndex > 0) {
          _selectParagraph(currentParagraphIndex - 1);
        }
      }
    }
  }

  TextStyle _getTextStyle() {
    final base = (fontFamily == 'Literata')
        ? GoogleFonts.literata(fontSize: fontSize, fontWeight: fontWeight, height: lineHeight)
        : GoogleFonts.inter(fontSize: fontSize, fontWeight: fontWeight, height: lineHeight);
    return base;
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.getTheme(currentTheme);
    final paragraphBlocks = currentSermon.blocks.where((b) => b.type == 'paragraph' || b.type == 'quote').toList();
    final activeBlock = (currentParagraphIndex < paragraphBlocks.length) ? paragraphBlocks[currentParagraphIndex] : null;

    final isWideScreen = MediaQuery.of(context).size.width >= 900;

    return Theme(
      data: theme,
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: theme.scaffoldBackgroundColor,
          elevation: 0,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: const BoxDecoration(color: Color(0xFF52453A), shape: BoxShape.circle),
                child: const Center(child: Text('✝', style: TextStyle(color: Colors.white, fontSize: 13))),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  'Kerygma Reader',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: theme.colorScheme.onSurface),
                ),
              ),
            ],
          ),
          actions: [
            if (isWideScreen) ...[
              TextButton.icon(
                onPressed: _openFullEditor,
                icon: const Icon(Icons.edit_note_outlined, size: 18),
                label: const Text('Editar', style: TextStyle(fontSize: 12)),
              ),
              TextButton.icon(
                onPressed: _openImportDialog,
                icon: const Icon(Icons.add_circle_outline, size: 18),
                label: const Text('Importar', style: TextStyle(fontSize: 12)),
              ),
            ] else ...[
              IconButton(icon: const Icon(Icons.edit_note_outlined), tooltip: 'Editar', onPressed: _openFullEditor),
              IconButton(icon: const Icon(Icons.add_circle_outline), tooltip: 'Importar', onPressed: _openImportDialog),
            ],
            IconButton(
              icon: const Icon(Icons.text_fields_outlined),
              tooltip: 'Tipografia & Cores',
              onPressed: _openTypographyDialog,
            ),
            IconButton(
              icon: Icon(focusModeActive ? Icons.center_focus_strong : Icons.center_focus_weak),
              tooltip: 'Modo Foco',
              onPressed: () => setState(() => focusModeActive = !focusModeActive),
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: KeyboardListener(
          focusNode: _focusNode,
          autofocus: true,
          onKeyEvent: _onKey,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // COLUNA PRINCIPAL: TEXTO DO SERMÃO
              Expanded(
                flex: isWideScreen ? 7 : 12,
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 720),
                    child: ListView(
                      controller: _scrollController,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                      children: [
                        // Cabeçalho do Sermão
                        Text(currentSermon.series.toUpperCase(), style: TextStyle(fontSize: 11, letterSpacing: 1.2, fontWeight: FontWeight.bold, color: theme.colorScheme.primary)),
                        const SizedBox(height: 6),
                        Text(currentSermon.title, style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: theme.colorScheme.onSurface)),
                        if (currentSermon.subtitle.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text(currentSermon.subtitle, style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: theme.colorScheme.onSurface.withOpacity(0.7))),
                        ],
                        const SizedBox(height: 24),
                        const Divider(height: 1),
                        const SizedBox(height: 24),

                        // Renderização dos Blocos
                        ..._buildBlocks(paragraphBlocks, theme, isWideScreen),

                        const SizedBox(height: 120),
                      ],
                    ),
                  ),
                ),
              ),

              // COLUNA LATERAL FIXA (EM TELAS LARGAS)
              if (isWideScreen)
                Expanded(
                  flex: 5,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: _buildSideInspector(activeBlock, theme),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildBlocks(List<SermonBlock> paragraphBlocks, ThemeData theme, bool isWideScreen) {
    List<Widget> widgets = [];
    int pIndex = 0;

    for (var block in currentSermon.blocks) {
      if (block.type == 'heading') {
        widgets.add(Padding(
          padding: const EdgeInsets.only(top: 24, bottom: 12),
          child: Text(
            block.text,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: theme.colorScheme.onSurface),
          ),
        ));
      } else if (block.type == 'paragraph' || block.type == 'quote') {
        final thisPIndex = pIndex;
        final isActive = (thisPIndex == currentParagraphIndex);
        final opacity = isActive ? 1.0 : (focusModeActive ? 0.28 : 1.0);

        widgets.add(Opacity(
          opacity: opacity,
          child: InkWell(
            onTap: () {
              _selectParagraph(thisPIndex, scrollToTop: false);
              if (!isWideScreen && (block.verses.isNotEmpty || block.note.isNotEmpty)) {
                _openMobileBottomSheet(block);
              }
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isActive ? theme.colorScheme.primary.withOpacity(0.06) : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: block.type == 'quote' ? Border(left: BorderSide(color: theme.colorScheme.primary, width: 3)) : null,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        block.type == 'quote' ? '❝ ' : '§ ${thisPIndex + 1} ',
                        style: TextStyle(fontSize: 11, fontFamily: 'monospace', color: theme.colorScheme.onSurface.withOpacity(0.4)),
                      ),
                      Expanded(
                        child: Text(
                          block.text,
                          style: _getTextStyle().copyWith(color: theme.colorScheme.onSurface),
                        ),
                      ),
                    ],
                  ),
                  if (block.verses.isNotEmpty || block.note.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        ...block.verses.map((v) => ActionChip(
                              avatar: const Icon(Icons.menu_book, size: 14),
                              label: Text(v, style: const TextStyle(fontSize: 11)),
                              onPressed: () {
                                setState(() => activeVerseKey = v);
                                if (!isWideScreen) _openMobileBottomSheet(block);
                              },
                            )),
                        IconButton(
                          icon: Icon(Icons.edit_outlined, size: 16, color: block.note.isNotEmpty ? Colors.amber.shade800 : null),
                          tooltip: 'Editar parágrafo, versículos e anotações',
                          onPressed: () => _openParagraphEditor(block, thisPIndex),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ));
        pIndex++;
      }
    }

    return widgets;
  }

  // WIDGET DO INSPETOR LATERAL (ACOMPANHA E FICA EM BRANCO SE VAZIO)
  Widget _buildSideInspector(SermonBlock? activeBlock, ThemeData theme) {
    final hasVerse = activeVerseKey != null;
    final hasNote = activeBlock != null && activeBlock.note.trim().isNotEmpty;

    // Se NÃO tiver versículo nem anotação: DEIXA EM BRANCO!
    if (!hasVerse && !hasNote) {
      return const SizedBox.shrink();
    }

    final verseTranslations = hasVerse ? BibleService.getTranslationsFor(activeVerseKey!) : null;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card de Versículos
          if (hasVerse && verseTranslations != null)
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: theme.colorScheme.outline),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(activeVerseKey!.toUpperCase(), style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: theme.colorScheme.primary)),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(color: theme.colorScheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(4)),
                          child: const Text('OFFLINE LOCAL', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text('Comparar Traduções:', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 6,
                      children: ['ARA', 'NAA', 'NVT', 'NVI', 'ARC'].map((tr) {
                        final isSelected = selectedTranslations.contains(tr);
                        return FilterChip(
                          label: Text(tr, style: const TextStyle(fontSize: 11)),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                selectedTranslations.add(tr);
                              } else {
                                selectedTranslations.remove(tr);
                                if (selectedTranslations.isEmpty) selectedTranslations.add('ARA');
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 14),
                    ...selectedTranslations.map((tr) {
                      final text = verseTranslations[tr] ?? verseTranslations['ARA'] ?? '';
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: theme.colorScheme.outline.withOpacity(0.5)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(tr, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: theme.colorScheme.primary)),
                            const SizedBox(height: 4),
                            Text('"$text"', style: GoogleFonts.literata(fontSize: 13, height: 1.5, color: theme.colorScheme.onSurface)),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),

          if (hasVerse && hasNote) const SizedBox(height: 16),

          // Card de Anotações
          if (hasNote)
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: theme.colorScheme.outline),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('ANOTAÇÃO PASTORAL', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1)),
                        IconButton(
                          icon: const Icon(Icons.edit, size: 14),
                          onPressed: () => _openParagraphEditor(activeBlock, currentParagraphIndex),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      activeBlock.note,
                      style: GoogleFonts.literata(fontSize: 13, fontStyle: FontStyle.italic, height: 1.5, color: Colors.amber.shade900),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  // BOTTOM SHEET MOBILE
  void _openMobileBottomSheet(SermonBlock block) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.shade400, borderRadius: BorderRadius.circular(2)))),
              const SizedBox(height: 16),
              if (activeVerseKey != null) ...[
                Text(activeVerseKey!, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(BibleService.getTranslationsFor(activeVerseKey!)['ARA'] ?? '', style: GoogleFonts.literata(fontSize: 14)),
              ],
              if (block.note.isNotEmpty) ...[
                const SizedBox(height: 12),
                const Divider(),
                const Text('Anotação:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                Text(block.note, style: const TextStyle(fontStyle: FontStyle.italic)),
              ],
            ],
          ),
        );
      },
    );
  }

  // DIÁLOGO PARA EDITAR PARÁGRAFO, VERSÍCULOS E ANOTAÇÃO
  void _openParagraphEditor(SermonBlock block, int index) {
    final textController = TextEditingController(text: block.text);
    final noteController = TextEditingController(text: block.note);
    final newVerseController = TextEditingController();
    List<String> verses = List.from(block.verses);

    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text('Editar Parágrafo § ${index + 1}'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: textController,
                      maxLines: 4,
                      decoration: const InputDecoration(labelText: 'Texto do Parágrafo', border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 6,
                      children: verses
                          .map((v) => Chip(
                                label: Text(v),
                                onDeleted: () => setDialogState(() => verses.remove(v)),
                              ))
                          .toList(),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: newVerseController,
                            decoration: const InputDecoration(hintText: 'Ex: Provérbios 24:27'),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            if (newVerseController.text.trim().isNotEmpty) {
                              setDialogState(() {
                                verses.add(newVerseController.text.trim());
                                newVerseController.clear();
                              });
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: noteController,
                      maxLines: 2,
                      decoration: const InputDecoration(labelText: 'Anotação Pastoral', border: OutlineInputBorder()),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancelar')),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      block.text = textController.text.trim();
                      block.note = noteController.text.trim();
                      block.verses = verses;
                      if (verses.isNotEmpty) activeVerseKey = verses.first;
                    });
                    Navigator.pop(ctx);
                  },
                  child: const Text('Salvar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // DIÁLOGO PARA EDITAR TEXTO COMPLETO DO SERMÃO
  void _openFullEditor() {
    final titleController = TextEditingController(text: currentSermon.title);
    final subtitleController = TextEditingController(text: currentSermon.subtitle);
    final contentController = TextEditingController(
      text: currentSermon.blocks.map((b) => (b.type == 'heading' ? '## ${b.text}' : b.text)).join('\n\n'),
    );

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Editar Texto do Sermão'),
          content: SizedBox(
            width: 600,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(controller: titleController, decoration: const InputDecoration(labelText: 'Título')),
                  const SizedBox(height: 8),
                  TextField(controller: subtitleController, decoration: const InputDecoration(labelText: 'Subtítulo / Série')),
                  const SizedBox(height: 12),
                  TextField(controller: contentController, maxLines: 12, decoration: const InputDecoration(labelText: 'Conteúdo do Esboço', border: OutlineInputBorder())),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancelar')),
            ElevatedButton(
              onPressed: () {
                final parsedBlocks = SermonParser.parseRawText(contentController.text);
                setState(() {
                  currentSermon = Sermon(
                    title: titleController.text.trim(),
                    subtitle: subtitleController.text.trim(),
                    series: currentSermon.series,
                    blocks: parsedBlocks,
                  );
                  currentParagraphIndex = 0;
                });
                Navigator.pop(ctx);
              },
              child: const Text('Salvar Alterações'),
            ),
          ],
        );
      },
    );
  }

  // DIÁLOGO DE IMPORTAR / COLAR
  void _openImportDialog() {
    final rawController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Importar / Colar Sermão'),
          content: SizedBox(
            width: 500,
            child: TextField(
              controller: rawController,
              maxLines: 10,
              decoration: const InputDecoration(hintText: 'Cole o texto do seu sermão aqui (Ctrl+V)...', border: OutlineInputBorder()),
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancelar')),
            ElevatedButton(
              onPressed: () {
                if (rawController.text.trim().isNotEmpty) {
                  final blocks = SermonParser.parseRawText(rawController.text);
                  setState(() {
                    currentSermon = Sermon(
                      title: blocks.isNotEmpty ? blocks.first.text : 'Sermão',
                      subtitle: '',
                      series: 'Sermão Importado',
                      blocks: blocks,
                    );
                    currentParagraphIndex = 0;
                  });
                  Navigator.pop(ctx);
                }
              },
              child: const Text('Analisar e Abrir'),
            ),
          ],
        );
      },
    );
  }

  // DIÁLOGO DE TIPOGRAFIA
  void _openTypographyDialog() {
    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Tipografia & Tema'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButton<String>(
                    value: fontFamily,
                    isExpanded: true,
                    items: const [
                      DropdownMenuItem(value: 'Literata', child: Text('Serifada (Literata)')),
                      DropdownMenuItem(value: 'Inter', child: Text('Sem Serifa (Inter)')),
                    ],
                    onChanged: (val) {
                      if (val != null) {
                        setDialogState(() => fontFamily = val);
                        setState(() => fontFamily = val);
                      }
                    },
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Espessura da Fonte:'),
                      ChoiceChip(
                        label: const Text('Normal'),
                        selected: fontWeight == FontWeight.w400,
                        onSelected: (_) {
                          setDialogState(() => fontWeight = FontWeight.w400);
                          setState(() => fontWeight = FontWeight.w400);
                        },
                      ),
                      ChoiceChip(
                        label: const Text('Pesada'),
                        selected: fontWeight == FontWeight.w600,
                        onSelected: (_) {
                          setDialogState(() => fontWeight = FontWeight.w600);
                          setState(() => fontWeight = FontWeight.w600);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Tamanho:'),
                      Slider(
                        min: 14,
                        max: 28,
                        value: fontSize,
                        onChanged: (val) {
                          setDialogState(() => fontSize = val);
                          setState(() => fontSize = val);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildThemeCircle(ReaderThemeMode.light, const Color(0xFFFBF9F5), setDialogState),
                      _buildThemeCircle(ReaderThemeMode.sepia, const Color(0xFFF4ECD8), setDialogState),
                      _buildThemeCircle(ReaderThemeMode.dark, const Color(0xFF18181B), setDialogState),
                      _buildThemeCircle(ReaderThemeMode.oled, Colors.black, setDialogState),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Fechar')),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildThemeCircle(ReaderThemeMode mode, Color color, StateSetter setDialogState) {
    return InkWell(
      onTap: () {
        setDialogState(() => currentTheme = mode);
        setState(() => currentTheme = mode);
      },
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: currentTheme == mode ? Colors.amber : Colors.grey.shade400, width: 2),
        ),
      ),
    );
  }
}
