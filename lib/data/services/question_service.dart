import 'package:razor_mind/data/models/challenge_mode.dart';
import 'package:razor_mind/data/models/question.dart';

class QuestionService {
  static const List<Question> _allQuestions = [
    Question(id: 'hist_001', categoryId: 'history', type: 'multiple_choice', text: '¿En qué año llegó Cristóbal Colón a América?', options: ['1488','1492','1502','1510'], correctAnswer: '1492', explanation: 'Cristóbal Colón llegó a América el 12 de octubre de 1492, cuando divisó la isla de Guanahaní en el Caribe.', difficulty: 1, xpReward: 10),
    Question(id: 'hist_002', categoryId: 'history', type: 'multiple_choice', text: '¿Qué civilización construyó las pirámides de Guiza?', options: ['Los mayas','Los romanos','Los egipcios','Los griegos'], correctAnswer: 'Los egipcios', explanation: 'Las pirámides de Guiza fueron construidas por los egipcios hace más de 4500 años, como tumbas para sus faraones.', difficulty: 1, xpReward: 10),
    Question(id: 'hist_003', categoryId: 'history', type: 'multiple_choice', text: '¿Quién fue el primer emperador de Roma?', options: ['Julio César','Marco Aurelio','Augusto','Nerón'], correctAnswer: 'Augusto', explanation: 'Augusto, sobrino nieto de Julio César, se convirtió en el primer emperador romano en el año 27 a.C., iniciando el Imperio Romano.', difficulty: 2, xpReward: 25),
    Question(id: 'hist_004', categoryId: 'history', type: 'true_false', text: 'La Segunda Guerra Mundial comenzó en 1939 con la invasión de Polonia por Alemania.', options: ['Verdadero','Falso'], correctAnswer: 'Verdadero', explanation: 'La Segunda Guerra Mundial comenzó el 1 de septiembre de 1939 cuando la Alemania nazi invadió Polonia, lo que llevó a Francia y Reino Unido a declararle la guerra a Alemania.', difficulty: 1, xpReward: 10),
    Question(id: 'hist_005', categoryId: 'history', type: 'multiple_choice', text: '¿Qué civilización mesoamericana construyó Tenochtitlán?', options: ['Los mayas','Los aztecas','Los olmecas','Los toltecas'], correctAnswer: 'Los aztecas', explanation: 'Los aztecas fundaron Tenochtitlán en 1325 sobre una isla en el lago Texcoco; hoy es la Ciudad de México.', difficulty: 1, xpReward: 10),
    Question(id: 'hist_006', categoryId: 'history', type: 'multiple_choice', text: '¿Cuál fue la batalla que marcó el fin de Napoleón Bonaparte?', options: ['Batalla de Austerlitz','Batalla de Trafalgar','Batalla de Waterloo','Batalla de Leipzig'], correctAnswer: 'Batalla de Waterloo', explanation: 'En la Batalla de Waterloo (1815), Napoleón fue derrotado definitivamente por las fuerzas aliadas lideradas por el Duque de Wellington y el mariscal Blücher.', difficulty: 2, xpReward: 25),
    Question(id: 'hist_007', categoryId: 'history', type: 'multiple_choice', text: '¿Cuántos años duró la Guerra de los Cien Años entre Francia e Inglaterra?', options: ['72 años','100 años','116 años','88 años'], correctAnswer: '116 años', explanation: 'A pesar de su nombre, la Guerra de los Cien Años duró 116 años (1337-1453), siendo uno de los conflictos más largos de la historia medieval.', difficulty: 3, xpReward: 50),
    Question(id: 'hist_008', categoryId: 'history', type: 'multiple_choice', text: '¿Qué faraona egipcia tuvo relaciones políticas con Julio César y Marco Antonio?', options: ['Nefertiti','Cleopatra VII','Hatshepsut','Nefertari'], correctAnswer: 'Cleopatra VII', explanation: 'Cleopatra VII fue la última reina del Egipto ptolemaico. Tuvo relaciones con Julio César, con quien tuvo un hijo, y con Marco Antonio, con quien tuvo tres hijos.', difficulty: 1, xpReward: 10),
    Question(id: 'hist_009', categoryId: 'history', type: 'multiple_choice', text: '¿En qué año cayó el Muro de Berlín?', options: ['1987','1989','1991','1993'], correctAnswer: '1989', explanation: 'El Muro de Berlín cayó el 9 de noviembre de 1989, marcando el fin de la Guerra Fría y la reunificación de Alemania.', difficulty: 1, xpReward: 10),
    Question(id: 'hist_010', categoryId: 'history', type: 'multiple_choice', text: '¿Qué pueblo antiguo inventó el sistema de escritura cuneiforme?', options: ['Los egipcios','Los griegos','Los sumerios','Los persas'], correctAnswer: 'Los sumerios', explanation: 'Los sumerios de Mesopotamia inventaron la escritura cuneiforme alrededor del 3100 a.C., uno de los primeros sistemas de escritura del mundo.', difficulty: 2, xpReward: 25),
    Question(id: 'hist_011', categoryId: 'history', type: 'true_false', text: 'Simón Bolívar nació en Venezuela y liberó a cinco países sudamericanos de la dominación española.', options: ['Verdadero','Falso'], correctAnswer: 'Verdadero', explanation: 'Simón Bolívar nació en Caracas en 1783 y lideró la independencia de Venezuela, Colombia, Ecuador, Perú y Bolivia.', difficulty: 1, xpReward: 10),
    Question(id: 'hist_012', categoryId: 'history', type: 'multiple_choice', text: '¿Cuál fue el nombre del proyecto secreto que desarrolló la bomba atómica en la Segunda Guerra Mundial?', options: ['Proyecto Fénix','Proyecto Manhattan','Proyecto Apolo','Proyecto Tormenta'], correctAnswer: 'Proyecto Manhattan', explanation: 'El Proyecto Manhattan fue el programa secreto de investigación que desarrolló las primeras bombas atómicas durante la Segunda Guerra Mundial, con centros en Los Álamos, Oak Ridge y Hanford.', difficulty: 2, xpReward: 25),
    Question(id: 'hist_013', categoryId: 'history', type: 'multiple_choice', text: '¿Qué civilización maya construyó la ciudad de Chichén Itzá?', options: ['Los olmecas','Los toltecas-mayas','Los aztecas','Los zapotecas'], correctAnswer: 'Los toltecas-mayas', explanation: 'Chichén Itzá fue una gran ciudad maya en la Península de Yucatán que alcanzó su apogeo bajo influencia tolteca entre los siglos X y XIII d.C.', difficulty: 3, xpReward: 50),
    Question(id: 'hist_014', categoryId: 'history', type: 'multiple_choice', text: '¿En qué año se produjo la Revolución Francesa?', options: ['1776','1789','1804','1815'], correctAnswer: '1789', explanation: 'La Revolución Francesa comenzó en 1789 con la toma de la Bastilla el 14 de julio, transformando para siempre la política y la sociedad europea.', difficulty: 1, xpReward: 10),
    Question(id: 'hist_015', categoryId: 'history', type: 'multiple_choice', text: '¿Qué imperio fue el más extenso de la historia en términos de superficie?', options: ['El Imperio Romano','El Imperio Mongol','El Imperio Británico','El Imperio Español'], correctAnswer: 'El Imperio Británico', explanation: 'El Imperio Británico fue el más extenso de la historia, llegando a cubrir el 24% de la superficie terrestre en su apogeo durante el siglo XIX y principios del XX.', difficulty: 2, xpReward: 25),
    Question(id: 'hist_016', categoryId: 'history', type: 'multiple_choice', text: '¿Cuál fue el primer país en conceder el derecho al voto a las mujeres?', options: ['Estados Unidos','Reino Unido','Francia','Nueva Zelanda'], correctAnswer: 'Nueva Zelanda', explanation: 'Nueva Zelanda fue el primer país en reconocer el derecho al voto femenino en 1893, siendo un hito histórico en la lucha por la igualdad de género.', difficulty: 3, xpReward: 50),
    Question(id: 'hist_017', categoryId: 'history', type: 'multiple_choice', text: '¿Cuál era el nombre de la capital del Imperio Azteca?', options: ['Teotihuacán','Tenochtitlán','Chichén Itzá','Tula'], correctAnswer: 'Tenochtitlán', explanation: 'Tenochtitlán, fundada en 1325, era la magnífica capital del Imperio Azteca, situada en una isla del lago Texcoco. A su conquista en 1521, Hernán Cortés la transformó en la actual Ciudad de México.', difficulty: 1, xpReward: 10),
    Question(id: 'hist_018', categoryId: 'history', type: 'multiple_choice', text: '¿Qué líder mongol fundó el mayor imperio continental de la historia?', options: ['Kublai Khan','Tamerlán','Gengis Khan','Ögedei Khan'], correctAnswer: 'Gengis Khan', explanation: 'Gengis Khan fundó el Imperio Mongol en 1206 y lo expandió desde el Pacífico hasta Europa Central, convirtiéndolo en el mayor imperio continuo de la historia con más de 24 millones de km².', difficulty: 1, xpReward: 10),
    Question(id: 'hist_019', categoryId: 'history', type: 'multiple_choice', text: '¿En qué año fue fundada Constantinopla, la capital del Imperio Otomano, tras su conquista?', options: ['1299','1453','1517','1566'], correctAnswer: '1453', explanation: 'En 1453, el sultán Mehmed II conquistó Constantinopla, poniendo fin al Imperio Bizantino. Renombrada Estambul, se convirtió en la capital del Imperio Otomano hasta la proclamación de la República Turca en 1923.', difficulty: 2, xpReward: 25),
    Question(id: 'hist_020', categoryId: 'history', type: 'multiple_choice', text: '¿Quién fue el mecenas más influyente del Renacimiento italiano y gobernante de Florencia?', options: ['Francesco Sforza','Lorenzo de Médici','Cesare Borgia','Filippo Brunelleschi'], correctAnswer: 'Lorenzo de Médici', explanation: 'Lorenzo de Médici, conocido como "el Magnífico", gobernó Florencia entre 1469 y 1492 y fue el mayor mecenas del Renacimiento, financiando a artistas como Botticelli y el joven Miguel Ángel.', difficulty: 2, xpReward: 25),
    Question(id: 'hist_021', categoryId: 'history', type: 'multiple_choice', text: '¿Qué invento de James Watt impulsó la Revolución Industrial en el siglo XVIII?', options: ['El motor a vapor mejorado','La locomotora de vapor','El telégrafo eléctrico','El telar mecánico'], correctAnswer: 'El motor a vapor mejorado', explanation: 'James Watt perfeccionó el motor de vapor en 1769, añadiendo un condensador separado que lo hizo mucho más eficiente. Su motor impulsó fábricas, minas y transportes, siendo el corazón de la Revolución Industrial.', difficulty: 2, xpReward: 25),
    Question(id: 'hist_022', categoryId: 'history', type: 'multiple_choice', text: '¿Qué evento marcó el inicio de la Guerra Fría entre EE.UU. y la URSS?', options: ['La caída de Berlín en 1945','La división de Alemania y el Telón de Acero tras la Segunda Guerra Mundial','La crisis de los misiles en Cuba en 1962','La guerra de Corea en 1950'], correctAnswer: 'La división de Alemania y el Telón de Acero tras la Segunda Guerra Mundial', explanation: 'La Guerra Fría comenzó con el fin de la Segunda Guerra Mundial (1945), cuando el mundo quedó dividido entre el bloque occidental liderado por EE.UU. y el bloque soviético. Churchill acuñó el término "Telón de Acero" en 1946.', difficulty: 2, xpReward: 25),
    Question(id: 'hist_023', categoryId: 'history', type: 'multiple_choice', text: '¿Cuántos años estuvo Nelson Mandela encarcelado antes de convertirse en presidente de Sudáfrica?', options: ['18 años','23 años','27 años','32 años'], correctAnswer: '27 años', explanation: 'Nelson Mandela estuvo preso 27 años (1964-1990), principalmente en la prisión de Robben Island, condenado por su lucha contra el apartheid. En 1994 se convirtió en el primer presidente negro de Sudáfrica.', difficulty: 2, xpReward: 25),
    Question(id: 'hist_024', categoryId: 'history', type: 'multiple_choice', text: '¿Qué método de resistencia pacífica popularizó Gandhi para lograr la independencia de India?', options: ['La huelga general armada','La desobediencia civil no violenta','El boicot económico militar','La resistencia parlamentaria'], correctAnswer: 'La desobediencia civil no violenta', explanation: 'Gandhi desarrolló la "satyagraha" (fuerza de la verdad), método de resistencia pasiva y desobediencia civil no violenta. Su Marcha de la Sal en 1930 es uno de los ejemplos más célebres de esta táctica.', difficulty: 1, xpReward: 10),
    Question(id: 'hist_025', categoryId: 'history', type: 'multiple_choice', text: '¿Cuáles fueron los elementos radiactivos descubiertos por Marie Curie?', options: ['Uranio y torio','Radio y polonio','Radón y francio','Cesio y bario'], correctAnswer: 'Radio y polonio', explanation: 'Marie Curie y su esposo Pierre descubrieron el polonio (nombrado en honor a Polonia) y el radio en 1898. Marie fue la primera persona en ganar dos Premios Nobel en disciplinas distintas.', difficulty: 2, xpReward: 25),
    Question(id: 'hist_026', categoryId: 'history', type: 'multiple_choice', text: '¿Qué documento firmado en 1215 limitó el poder absoluto del rey inglés por primera vez?', options: ['El Estatuto de Oxford','La Carta Magna','El Bill of Rights','La Petición de Derechos'], correctAnswer: 'La Carta Magna', explanation: 'La Carta Magna fue firmada por el rey Juan de Inglaterra en 1215, limitando por primera vez el poder real y reconociendo ciertos derechos a los barones. Es considerada la base del derecho constitucional moderno.', difficulty: 2, xpReward: 25),
    Question(id: 'hist_027', categoryId: 'history', type: 'multiple_choice', text: '¿En qué año se firmó la Declaración de Independencia de los Estados Unidos?', options: ['1773','1776','1781','1787'], correctAnswer: '1776', explanation: 'La Declaración de Independencia de los Estados Unidos fue adoptada el 4 de julio de 1776 por el Congreso Continental, separando formalmente las 13 colonias de la Corona Británica.', difficulty: 1, xpReward: 10),
    Question(id: 'hist_028', categoryId: 'history', type: 'multiple_choice', text: '¿Cuánto tiempo duró el Imperio Bizantino desde la caída de Roma Occidental hasta su fin?', options: ['400 años','600 años','800 años','1 000 años'], correctAnswer: '1 000 años', explanation: 'El Imperio Bizantino (Imperio Romano de Oriente) sobrevivió aproximadamente 1 000 años tras la caída de Roma Occidental en 476 d.C., hasta la conquista de Constantinopla por los otomanos en 1453.', difficulty: 3, xpReward: 50),
    Question(id: 'hist_029', categoryId: 'history', type: 'true_false', text: 'El Imperio Mongol fue el mayor imperio de la historia en términos de superficie terrestre continua.', options: ['Verdadero','Falso'], correctAnswer: 'Verdadero', explanation: 'El Imperio Mongol alcanzó su máxima extensión en 1279, con más de 24 millones de km² contiguos, siendo el mayor imperio continental de la historia. El Imperio Británico fue mayor en total pero no era continuo.', difficulty: 2, xpReward: 25),
    Question(id: 'hist_030', categoryId: 'history', type: 'multiple_choice', text: '¿Qué evento desencadenó directamente la Primera Guerra Mundial en 1914?', options: ['La invasión alemana de Bélgica','El asesinato del Archiduque Francisco Fernando en Sarajevo','La declaración de guerra austro-húngara a Serbia','El hundimiento del Lusitania'], correctAnswer: 'El asesinato del Archiduque Francisco Fernando en Sarajevo', explanation: 'El 28 de junio de 1914, el Archiduque Francisco Fernando de Austria fue asesinado en Sarajevo por el nacionalista serbio Gavrilo Princip. Este detonante activó las alianzas europeas y desembocó en la Primera Guerra Mundial.', difficulty: 2, xpReward: 25),
  ];

  List<Question> getAll() => List.unmodifiable(_allQuestions);
  List<Question> getByCategory(String categoryId) => _allQuestions.where((q) => q.categoryId == categoryId).toList();
  List<Question> getByDifficulty(int difficulty) => _allQuestions.where((q) => q.difficulty == difficulty).toList();
  Question? getById(String id) { try { return _allQuestions.firstWhere((q) => q.id == id); } catch (_) { return null; } }

  List<Question> getDailyChallenge(List<String> preferredCategories) {
    final today = DateTime.now();
    final seed = today.year * 10000 + today.month * 100 + today.day;
    final easy = _seededShuffle(getByDifficulty(1), seed).take(3).toList();
    final medium = _seededShuffle(getByDifficulty(2), seed + 1).take(4).toList();
    final hard = _seededShuffle(getByDifficulty(3), seed + 2).take(3).toList();
    final combined = [...easy, ...medium, ...hard];
    return _seededShuffle(combined, seed + 3);
  }

  List<Question> getAdaptiveQuestions({required String categoryId, required int count, double accuracy = 0.5, int totalAttempted = 0, int categoryXP = 0}) {
    final categoryQuestions = getByCategory(categoryId);
    if (categoryQuestions.isEmpty) return [];
    List<Question> pool;
    if (accuracy > 0.70 || categoryXP > 200) {
      final hard = categoryQuestions.where((q) => q.difficulty == 3).toList();
      final medium = categoryQuestions.where((q) => q.difficulty == 2).toList();
      pool = [...hard, ...medium];
      if (pool.length < count) { pool.addAll(categoryQuestions.where((q) => q.difficulty == 1)); }
    } else if (accuracy < 0.40 && totalAttempted > 5) {
      final easy = categoryQuestions.where((q) => q.difficulty == 1).toList();
      final medium = categoryQuestions.where((q) => q.difficulty == 2).toList();
      pool = [...easy, ...medium];
      if (pool.length < count) { pool.addAll(categoryQuestions.where((q) => q.difficulty == 3)); }
    } else {
      pool = List.of(categoryQuestions);
    }
    final seed = DateTime.now().millisecondsSinceEpoch ~/ 60000;
    final shuffled = _seededShuffle(pool, seed);
    return shuffled.take(count).toList();
  }

  List<Question> getForMode(ChallengeMode mode, List<String> preferredCategories, {String? categoryId}) {
    switch (mode) {
      case ChallengeMode.daily: return getDailyChallenge(preferredCategories);
      case ChallengeMode.speed: return _getSpeedModeQuestions(preferredCategories);
      case ChallengeMode.survival: return _getSurvivalModeQuestions(preferredCategories);
      case ChallengeMode.marathon: return categoryId != null ? getByCategory(categoryId) : getAll();
    }
  }

  List<Question> _getSpeedModeQuestions(List<String> preferredCategories) {
    final seed = DateTime.now().millisecondsSinceEpoch ~/ 60000;
    final easy = _seededShuffle(getByDifficulty(1), seed).take(7).toList();
    final medium = _seededShuffle(getByDifficulty(2), seed + 1).take(8).toList();
    final combined = [...easy, ...medium];
    return _seededShuffle(combined, seed + 2).take(15).toList();
  }

  List<Question> _getSurvivalModeQuestions(List<String> preferredCategories) {
    final seed = DateTime.now().millisecondsSinceEpoch ~/ 60000;
    final easy = _seededShuffle(getByDifficulty(1), seed);
    final medium = _seededShuffle(getByDifficulty(2), seed + 1);
    final hard = _seededShuffle(getByDifficulty(3), seed + 2);
    return [...easy, ...medium, ...hard];
  }

  List<Question> _seededShuffle(List<Question> input, int seed) {
    final list = List<Question>.of(input);
    var rng = seed;
    for (int i = list.length - 1; i > 0; i--) {
      rng = (rng * 1664525 + 1013904223) & 0xFFFFFFFF;
      final j = rng % (i + 1);
      final tmp = list[i];
      list[i] = list[j];
      list[j] = tmp;
    }
    return list;
  }
}
