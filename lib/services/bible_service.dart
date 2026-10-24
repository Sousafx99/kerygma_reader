class BibleService {
  static final Map<String, Map<String, String>> _verses = {
    'Provérbios 24:27': {
      'ARA': 'Cuida dos teus negócios lá fora, apronta a lavoura no campo e, depois, edifica a tua casa.',
      'NAA': 'Cuide dos seus negócios lá fora, prepare o seu trabalho no campo e, depois, edifique a sua casa.',
      'NVT': 'Desenvolva seus negócios no campo antes de construir a sua casa.',
      'NVI': 'Termine primeiro o seu trabalho a céu aberto; deixe pronta a sua lavoura. Depois construa a sua casa.',
      'ARC': 'Prepara de fora a tua obra, e aparelha-a no campo, e depois edifica a tua casa.',
    },
    'Pv 24:27': {
      'ARA': 'Cuida dos teus negócios lá fora, apronta a lavoura no campo e, depois, edifica a tua casa.',
      'NAA': 'Cuide dos seus negócios lá fora, prepare o seu trabalho no campo e, depois, edifique a sua casa.',
      'NVT': 'Desenvolva seus negócios no campo antes de construir a sua casa.',
      'NVI': 'Termine primeiro o seu trabalho a céu aberto; deixe pronta a sua lavoura. Depois construa a sua casa.',
      'ARC': 'Prepara de fora a tua obra, e aparelha-a no campo, e depois edifica a tua casa.',
    },
    '1 Coríntios 10:31': {
      'ARA': 'Portanto, quer comais, quer bebais ou façais outra coisa qualquer, fazei tudo para a glória de Deus.',
      'NAA': 'Portanto, quer vocês comam, quer bebam ou façam qualquer outra coisa, façam tudo para a glória de Deus.',
      'NVT': 'Portanto, quer vocês comam, bebam ou façam qualquer outra coisa, façam tudo para a glória de Deus.',
      'NVI': 'Assim, quer vocês comam, bebam ou façam qualquer outra coisa, façam tudo para a glória de Deus.',
      'ARC': 'Portanto, quer comais, quer bebais ou façais outra qualquer coisa, fazei tudo para a glória de Deus.',
    },
    '1 Co 10:31': {
      'ARA': 'Portanto, quer comais, quer bebais ou façais outra coisa qualquer, fazei tudo para a glória de Deus.',
      'NAA': 'Portanto, quer vocês comam, quer bebam ou façam qualquer outra coisa, façam tudo para a glória de Deus.',
      'NVT': 'Portanto, quer vocês comam, bebam ou façam qualquer outra coisa, façam tudo para a glória de Deus.',
      'NVI': 'Assim, quer vocês comam, bebam ou façam qualquer outra coisa, façam tudo para a glória de Deus.',
      'ARC': 'Portanto, quer comais, quer bebais ou façais outra qualquer coisa, fazei tudo para a glória de Deus.',
    },
    'Efésios 6:1-4': {
      'ARA': 'Filhos, obedecei a vossos pais no Senhor, pois isto é justo. Honra a teu pai e a tua mãe (que é o primeiro mandamento com promessa), para que te vá bem, e sejas de longa vida sobre a terra. E vós, pais, não provoqueis vossos filhos à ira, mas criai-os na disciplina e na admoestação do Senhor.',
      'NAA': 'Filhos, obedeçam a seus pais no Senhor, pois isso é justo. "Honre seu pai e sua mãe", que é o primeiro mandamento com promessa, "para que tudo lhe vá bem e você tenha uma longa vida sobre a terra." E vocês, pais, não provoquem os seus filhos à ira, mas criem-nos na disciplina e na admoestação do Senhor.',
      'NVT': 'Filhos, obedeçam a seus pais no Senhor, pois isso é o que é justo. "Honre seu pai e sua mãe." Este é o primeiro mandamento com promessa: "Para que tudo lhe vá bem e você tenha vida longa na terra." Pais, não irritem seus filhos. Pelo contrário, criem-nos com a disciplina e a instrução que vêm do Senhor.',
      'NVI': 'Filhos, obedeçam a seus pais no Senhor, pois isso é justo. "Honra teu pai e tua mãe" — este é o primeiro mandamento com promessa — "para que tudo te corra bem e tenhas longa vida sobre a terra". Pais, não irritem seus filhos; antes criem-nos segundo a instrução e o conselho do Senhor.',
      'ARC': 'Vós, filhos, sede obedientes a vossos pais no Senhor, porque isto é justo. Honra a teu pai e a tua mãe, que é o primeiro mandamento com promessa, para que te vá bem, e vivas muito tempo sobre a terra. E vós, pais, não provoqueis a ira a vossos filhos, mas criai-os na doutrina e admoestação do Senhor.',
    },
    'Efésios 5:21-33': {
      'ARA': 'Sujeitando-vos uns aos outros no temor de Cristo. As mulheres sejam submissas ao seu próprio marido, como ao Senhor... Maridos, amai vossa mulher, como também Cristo amou a igreja e a si mesmo se entregou por ela.',
      'NAA': 'Sujeitem-se uns aos outros no temor de Cristo. Esposas, que cada uma de vocês seja submissa ao seu próprio marido, como ao Senhor... Maridos, que cada um de vocês ame a sua esposa, assim como Cristo amou a igreja.',
      'NVT': 'Sujeitem-se uns aos outros por temor a Cristo. As esposas devem se sujeitar ao marido, como ao Senhor... E vocês, maridos, amem suas esposas, assim como Cristo amou a igreja.',
      'NVI': 'Sujeitem-se uns aos outros, por temor a Cristo. Mulheres, sujeite-se cada uma a seu marido, como ao Senhor... Maridos, ame cada um a sua mulher, assim como Cristo amou a igreja e entregou-se por ela.',
      'ARC': 'Sujeitando-vos uns aos outros no temor de Deus. Vós, mulheres, sujeitai-vos a vosso marido, como ao Senhor... Vós, maridos, amai vossa mulher, como também Cristo amou a igreja e a si mesmo se entregou por ela.',
    },
    'Gênesis 2:24': {
      'ARA': 'Por isso, deixa o homem pai e mãe e se une à sua mulher, tornando-se os dois uma só carne.',
      'NAA': 'Por isso o homem deixa o seu pai e a sua mãe para se unir à sua mulher, tornando-se os dois uma só carne.',
      'NVT': 'Por essa razão, o homem deixa pai e mãe e se une à sua mulher, e eles se tornam uma só carne.',
      'NVI': 'Por essa razão, o homem deixará pai e mãe e se unirá à sua mulher, e eles se tornarão uma só carne.',
      'ARC': 'Portanto, deixará o varão o seu pai e a sua mãe e apegar-se-á à sua mulher, e serão ambos uma carne.',
    },
    'Salmos 127:1-3': {
      'ARA': 'Se o SENHOR não edificar a casa, em vão trabalham os que a edificam; se o SENHOR não guardar a cidade, em vão vigia a sentinela. Herança do SENHOR são os filhos; o fruto do ventre, seu galardão.',
      'NAA': 'Se o SENHOR não edificar a casa, em vão trabalham os que a constroem. Se o SENHOR não guardar a cidade, em vão vigia a sentinela.',
      'NVT': 'Se o SENHOR não construir a casa, o trabalho dos construtores será inútil. Se o SENHOR não proteger a cidade, de nada adiantará a sentinela ficar de guarda.',
      'NVI': 'Se o Senhor não edificar a casa, em vão trabalham os que a constroem. Se o Senhor não guardar a cidade, em vão vigia a sentinela.',
      'ARC': 'Se o Senhor não edificar a casa, em vão trabalham os que a edificam; se o Senhor não guardar a cidade, em vão vigia a sentinela.',
    },
    'Romanos 8:28': {
      'ARA': 'Sabemos que todas as coisas cooperam para o bem daqueles que amam a Deus, daqueles que são chamados segundo o seu propósito.',
      'NAA': 'Sabemos que todas as coisas cooperam para o bem daqueles que amam a Deus, daqueles que são chamados segundo o seu propósito.',
      'NVT': 'E sabemos que Deus faz todas as coisas cooperarem para o bem daqueles que o amam e que são chamados de acordo com seu propósito.',
      'NVI': 'Sabemos que Deus age em todas as coisas para o bem daqueles que o amam, dos que foram chamados de acordo com o seu propósito.',
      'ARC': 'E sabemos que todas as coisas contribuem juntamente para o bem daqueles que amam a Deus, daqueles que são chamados por seu decreto.',
    },
    'Habacuque 3:17-19': {
      'ARA': 'Ainda que a figueira não floresça, nem haja fruto na vide; o produto da oliveira minta... todavia, eu me alegrarei no SENHOR.',
      'NAA': 'Mesmo que a figueira não floresça, nem haja fruto na videira; mesmo que a colheita da azeitona decepcione... todavia eu me alegrarei no SENHOR.',
      'NVT': 'Mesmo que a figueira não floresça e não haja uvas nas videiras... ainda assim me alegrarei no SENHOR!',
      'NVI': 'Mesmo não florescendo a figueira, e não havendo uvas nas videiras... todavia eu me alegrarei no Senhor.',
      'ARC': 'Porquanto, ainda que a figueira não floresça, nem haja fruto na vide... todavia eu me alegrarei no Senhor.',
    },
    'Jó 1:21': {
      'ARA': 'O SENHOR o deu e o SENHOR o tomou; bendito seja o nome do SENHOR.',
      'NAA': 'O SENHOR o deu e o SENHOR o tomou; bendito seja o nome do SENHOR!',
      'NVT': 'O SENHOR me deu e o SENHOR tomou; bendito seja o nome do SENHOR!.',
      'NVI': 'O Senhor deu, o Senhor o levou; louvado seja o nome do Senhor.',
      'ARC': 'O Senhor o deu e o Senhor o tomou; bendito seja o nome do Senhor.',
    },
    'Filipenses 4:13': {
      'ARA': 'Tudo posso naquele que me fortalece.',
      'NAA': 'Tudo posso naquele que me fortalece.',
      'NVT': 'Posso todas as coisas por meio de Cristo, que me dá forças.',
      'NVI': 'Tudo posso naquele que me fortalece.',
      'ARC': 'Posso todas as coisas naquele que me fortalece.',
    },
  };

  static Map<String, String> getTranslationsFor(String ref) {
    if (_verses.containsKey(ref)) {
      return _verses[ref]!;
    }

    // Procura por aproximação de chave
    for (var key in _verses.keys) {
      if (key.toLowerCase() == ref.toLowerCase()) {
        return _verses[key]!;
      }
    }

    // Fallback gracioso
    return {
      'ARA': 'Texto de $ref pronto para exibição offline.',
      'NAA': 'Texto de $ref pronto para exibição offline.',
      'NVT': 'Texto de $ref pronto para exibição offline.',
      'NVI': 'Texto de $ref pronto para exibição offline.',
      'ARC': 'Texto de $ref pronto para exibição offline.',
    };
  }

  static void addCustomVerse(String ref, Map<String, String> texts) {
    _verses[ref] = texts;
  }
}
