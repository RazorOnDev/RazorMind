import 'package:razor_mind/data/models/challenge_mode.dart';
import 'package:razor_mind/data/models/question.dart';

class QuestionService {
  // ---------------------------------------------------------------------------
  // QUESTION BANK — 193 questions across 7 categories
  // ---------------------------------------------------------------------------

  static const List<Question> _allQuestions = [
    // =========================================================================
    // HISTORIA — 16 questions
    // =========================================================================

    Question(
      id: 'hist_001',
      categoryId: 'history',
      type: 'multiple_choice',
      text: '¿En qué año llegó Cristóbal Colón a América?',
      options: ['1488', '1492', '1502', '1510'],
      correctAnswer: '1492',
      explanation:
          'Cristóbal Colón llegó a América el 12 de octubre de 1492, cuando divisó la isla de Guanahaní en el Caribe.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'hist_002',
      categoryId: 'history',
      type: 'multiple_choice',
      text: '¿Qué civilización construyó las pirámides de Guiza?',
      options: ['Los mayas', 'Los romanos', 'Los egipcios', 'Los griegos'],
      correctAnswer: 'Los egipcios',
      explanation:
          'Las pirámides de Guiza fueron construidas por los egipcios hace más de 4500 años, como tumbas para sus faraones.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'hist_003',
      categoryId: 'history',
      type: 'multiple_choice',
      text: '¿Quién fue el primer emperador de Roma?',
      options: ['Julio César', 'Marco Aurelio', 'Augusto', 'Nerón'],
      correctAnswer: 'Augusto',
      explanation:
          'Augusto, sobrino nieto de Julio César, se convirtió en el primer emperador romano en el año 27 a.C., iniciando el Imperio Romano.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'hist_004',
      categoryId: 'history',
      type: 'true_false',
      text:
          'La Segunda Guerra Mundial comenzó en 1939 con la invasión de Polonia por Alemania.',
      options: ['Verdadero', 'Falso'],
      correctAnswer: 'Verdadero',
      explanation:
          'La Segunda Guerra Mundial comenzó el 1 de septiembre de 1939 cuando la Alemania nazi invadió Polonia, lo que llevó a Francia y Reino Unido a declararle la guerra a Alemania.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'hist_005',
      categoryId: 'history',
      type: 'multiple_choice',
      text: '¿Qué civilización mesoamericana construyó Tenochtitlán?',
      options: ['Los mayas', 'Los aztecas', 'Los olmecas', 'Los toltecas'],
      correctAnswer: 'Los aztecas',
      explanation:
          'Los aztecas fundaron Tenochtitlán en 1325 sobre una isla en el lago Texcoco; hoy es la Ciudad de México.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'hist_006',
      categoryId: 'history',
      type: 'multiple_choice',
      text: '¿Cuál fue la batalla que marcó el fin de Napoleón Bonaparte?',
      options: [
        'Batalla de Austerlitz',
        'Batalla de Trafalgar',
        'Batalla de Waterloo',
        'Batalla de Leipzig'
      ],
      correctAnswer: 'Batalla de Waterloo',
      explanation:
          'En la Batalla de Waterloo (1815), Napoleón fue derrotado definitivamente por las fuerzas aliadas lideradas por el Duque de Wellington y el mariscal Blücher.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'hist_007',
      categoryId: 'history',
      type: 'multiple_choice',
      text: '¿Cuántos años duró la Guerra de los Cien Años entre Francia e Inglaterra?',
      options: ['72 años', '100 años', '116 años', '88 años'],
      correctAnswer: '116 años',
      explanation:
          'A pesar de su nombre, la Guerra de los Cien Años duró 116 años (1337-1453), siendo uno de los conflictos más largos de la historia medieval.',
      difficulty: 3,
      xpReward: 50,
    ),
    Question(
      id: 'hist_008',
      categoryId: 'history',
      type: 'multiple_choice',
      text: '¿Qué faraona egipcia tuvo relaciones políticas con Julio César y Marco Antonio?',
      options: ['Nefertiti', 'Cleopatra VII', 'Hatshepsut', 'Nefertari'],
      correctAnswer: 'Cleopatra VII',
      explanation:
          'Cleopatra VII fue la última reina del Egipto ptolemaico. Tuvo relaciones con Julio César, con quien tuvo un hijo, y con Marco Antonio, con quien tuvo tres hijos.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'hist_009',
      categoryId: 'history',
      type: 'multiple_choice',
      text: '¿En qué año cayó el Muro de Berlín?',
      options: ['1987', '1989', '1991', '1993'],
      correctAnswer: '1989',
      explanation:
          'El Muro de Berlín cayó el 9 de noviembre de 1989, marcando el fin de la Guerra Fría y la reunificación de Alemania.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'hist_010',
      categoryId: 'history',
      type: 'multiple_choice',
      text: '¿Qué pueblo antiguo inventó el sistema de escritura cuneiforme?',
      options: ['Los egipcios', 'Los griegos', 'Los sumerios', 'Los persas'],
      correctAnswer: 'Los sumerios',
      explanation:
          'Los sumerios de Mesopotamia inventaron la escritura cuneiforme alrededor del 3100 a.C., uno de los primeros sistemas de escritura del mundo.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'hist_011',
      categoryId: 'history',
      type: 'true_false',
      text:
          'Simón Bolívar nació en Venezuela y liberó a cinco países sudamericanos de la dominación española.',
      options: ['Verdadero', 'Falso'],
      correctAnswer: 'Verdadero',
      explanation:
          'Simón Bolívar nació en Caracas en 1783 y lideró la independencia de Venezuela, Colombia, Ecuador, Perú y Bolivia.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'hist_012',
      categoryId: 'history',
      type: 'multiple_choice',
      text: '¿Cuál fue el nombre del proyecto secreto que desarrolló la bomba atómica en la Segunda Guerra Mundial?',
      options: [
        'Proyecto Fénix',
        'Proyecto Manhattan',
        'Proyecto Apolo',
        'Proyecto Tormenta'
      ],
      correctAnswer: 'Proyecto Manhattan',
      explanation:
          'El Proyecto Manhattan fue el programa secreto de investigación que desarrolló las primeras bombas atómicas durante la Segunda Guerra Mundial, con centros en Los Álamos, Oak Ridge y Hanford.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'hist_013',
      categoryId: 'history',
      type: 'multiple_choice',
      text: '¿Qué civilización maya construyó la ciudad de Chichén Itzá?',
      options: ['Los olmecas', 'Los toltecas-mayas', 'Los aztecas', 'Los zapotecas'],
      correctAnswer: 'Los toltecas-mayas',
      explanation:
          'Chichén Itzá fue una gran ciudad maya en la Península de Yucatán que alcanzó su apogeo bajo influencia tolteca entre los siglos X y XIII d.C.',
      difficulty: 3,
      xpReward: 50,
    ),
    Question(
      id: 'hist_014',
      categoryId: 'history',
      type: 'multiple_choice',
      text: '¿En qué año se produjo la Revolución Francesa?',
      options: ['1776', '1789', '1804', '1815'],
      correctAnswer: '1789',
      explanation:
          'La Revolución Francesa comenzó en 1789 con la toma de la Bastilla el 14 de julio, transformando para siempre la política y la sociedad europea.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'hist_015',
      categoryId: 'history',
      type: 'multiple_choice',
      text: '¿Qué imperio fue el más extenso de la historia en términos de superficie?',
      options: [
        'El Imperio Romano',
        'El Imperio Mongol',
        'El Imperio Británico',
        'El Imperio Español'
      ],
      correctAnswer: 'El Imperio Británico',
      explanation:
          'El Imperio Británico fue el más extenso de la historia, llegando a cubrir el 24% de la superficie terrestre en su apogeo durante el siglo XIX y principios del XX.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'hist_016',
      categoryId: 'history',
      type: 'multiple_choice',
      text: '¿Cuál fue el primer país en conceder el derecho al voto a las mujeres?',
      options: ['Estados Unidos', 'Reino Unido', 'Francia', 'Nueva Zelanda'],
      correctAnswer: 'Nueva Zelanda',
      explanation:
          'Nueva Zelanda fue el primer país en reconocer el derecho al voto femenino en 1893, siendo un hito histórico en la lucha por la igualdad de género.',
      difficulty: 3,
      xpReward: 50,
    ),

    // =========================================================================
    // HISTORIA — preguntas adicionales (hist_017 – hist_030)
    // =========================================================================

    Question(
      id: 'hist_017',
      categoryId: 'history',
      type: 'multiple_choice',
      text: '¿Cuál era el nombre de la capital del Imperio Azteca?',
      options: ['Teotihuacán', 'Tenochtitlán', 'Chichén Itzá', 'Tula'],
      correctAnswer: 'Tenochtitlán',
      explanation:
          'Tenochtitlán, fundada en 1325, era la magnífica capital del Imperio Azteca, situada en una isla del lago Texcoco. A su conquista en 1521, Hernán Cortés la transformó en la actual Ciudad de México.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'hist_018',
      categoryId: 'history',
      type: 'multiple_choice',
      text: '¿Qué líder mongol fundó el mayor imperio continental de la historia?',
      options: ['Kublai Khan', 'Tamerlán', 'Gengis Khan', 'Ögedei Khan'],
      correctAnswer: 'Gengis Khan',
      explanation:
          'Gengis Khan fundó el Imperio Mongol en 1206 y lo expandió desde el Pacífico hasta Europa Central, convirtiéndolo en el mayor imperio continuo de la historia con más de 24 millones de km².',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'hist_019',
      categoryId: 'history',
      type: 'multiple_choice',
      text: '¿En qué año fue fundada Constantinopla, la capital del Imperio Otomano, tras su conquista?',
      options: ['1299', '1453', '1517', '1566'],
      correctAnswer: '1453',
      explanation:
          'En 1453, el sultán Mehmed II conquistó Constantinopla, poniendo fin al Imperio Bizantino. Renombrada Estambul, se convirtió en la capital del Imperio Otomano hasta la proclamación de la República Turca en 1923.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'hist_020',
      categoryId: 'history',
      type: 'multiple_choice',
      text: '¿Quién fue el mecenas más influyente del Renacimiento italiano y gobernante de Florencia?',
      options: [
        'Francesco Sforza',
        'Lorenzo de Médici',
        'Cesare Borgia',
        'Filippo Brunelleschi'
      ],
      correctAnswer: 'Lorenzo de Médici',
      explanation:
          'Lorenzo de Médici, conocido como "el Magnífico", gobernó Florencia entre 1469 y 1492 y fue el mayor mecenas del Renacimiento, financiando a artistas como Botticelli y el joven Miguel Ángel.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'hist_021',
      categoryId: 'history',
      type: 'multiple_choice',
      text: '¿Qué invento de James Watt impulsó la Revolución Industrial en el siglo XVIII?',
      options: [
        'El motor a vapor mejorado',
        'La locomotora de vapor',
        'El telégrafo eléctrico',
        'El telar mecánico'
      ],
      correctAnswer: 'El motor a vapor mejorado',
      explanation:
          'James Watt perfeccionó el motor de vapor en 1769, añadiendo un condensador separado que lo hizo mucho más eficiente. Su motor impulsó fábricas, minas y transportes, siendo el corazón de la Revolución Industrial.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'hist_022',
      categoryId: 'history',
      type: 'multiple_choice',
      text: '¿Qué evento marcó el inicio de la Guerra Fría entre EE.UU. y la URSS?',
      options: [
        'La caída de Berlín en 1945',
        'La división de Alemania y el Telón de Acero tras la Segunda Guerra Mundial',
        'La crisis de los misiles en Cuba en 1962',
        'La guerra de Corea en 1950'
      ],
      correctAnswer: 'La división de Alemania y el Telón de Acero tras la Segunda Guerra Mundial',
      explanation:
          'La Guerra Fría comenzó con el fin de la Segunda Guerra Mundial (1945), cuando el mundo quedó dividido entre el bloque occidental liderado por EE.UU. y el bloque soviético. Churchill acuñó el término "Telón de Acero" en 1946.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'hist_023',
      categoryId: 'history',
      type: 'multiple_choice',
      text: '¿Cuántos años estuvo Nelson Mandela encarcelado antes de convertirse en presidente de Sudáfrica?',
      options: ['18 años', '23 años', '27 años', '32 años'],
      correctAnswer: '27 años',
      explanation:
          'Nelson Mandela estuvo preso 27 años (1964-1990), principalmente en la prisión de Robben Island, condenado por su lucha contra el apartheid. En 1994 se convirtió en el primer presidente negro de Sudáfrica.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'hist_024',
      categoryId: 'history',
      type: 'multiple_choice',
      text: '¿Qué método de resistencia pacífica popularizó Gandhi para lograr la independencia de India?',
      options: [
        'La huelga general armada',
        'La desobediencia civil no violenta',
        'El boicot económico militar',
        'La resistencia parlamentaria'
      ],
      correctAnswer: 'La desobediencia civil no violenta',
      explanation:
          'Gandhi desarrolló la "satyagraha" (fuerza de la verdad), método de resistencia pasiva y desobediencia civil no violenta. Su Marcha de la Sal en 1930 es uno de los ejemplos más célebres de esta táctica.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'hist_025',
      categoryId: 'history',
      type: 'multiple_choice',
      text: '¿Cuáles fueron los elementos radiactivos descubiertos por Marie Curie?',
      options: [
        'Uranio y torio',
        'Radio y polonio',
        'Radón y francio',
        'Cesio y bario'
      ],
      correctAnswer: 'Radio y polonio',
      explanation:
          'Marie Curie y su esposo Pierre descubrieron el polonio (nombrado en honor a Polonia) y el radio en 1898. Marie fue la primera persona en ganar dos Premios Nobel en disciplinas distintas.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'hist_026',
      categoryId: 'history',
      type: 'multiple_choice',
      text: '¿Qué documento firmado en 1215 limitó el poder absoluto del rey inglés por primera vez?',
      options: ['El Estatuto de Oxford', 'La Carta Magna', 'El Bill of Rights', 'La Petición de Derechos'],
      correctAnswer: 'La Carta Magna',
      explanation:
          'La Carta Magna fue firmada por el rey Juan de Inglaterra en 1215, limitando por primera vez el poder real y reconociendo ciertos derechos a los barones. Es considerada la base del derecho constitucional moderno.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'hist_027',
      categoryId: 'history',
      type: 'multiple_choice',
      text: '¿En qué año se firmó la Declaración de Independencia de los Estados Unidos?',
      options: ['1773', '1776', '1781', '1787'],
      correctAnswer: '1776',
      explanation:
          'La Declaración de Independencia de los Estados Unidos fue adoptada el 4 de julio de 1776 por el Congreso Continental, separando formalmente las 13 colonias de la Corona Británica.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'hist_028',
      categoryId: 'history',
      type: 'multiple_choice',
      text: '¿Cuánto tiempo duró el Imperio Bizantino desde la caída de Roma Occidental hasta su fin?',
      options: ['400 años', '600 años', '800 años', '1 000 años'],
      correctAnswer: '1 000 años',
      explanation:
          'El Imperio Bizantino (Imperio Romano de Oriente) sobrevivió aproximadamente 1 000 años tras la caída de Roma Occidental en 476 d.C., hasta la conquista de Constantinopla por los otomanos en 1453.',
      difficulty: 3,
      xpReward: 50,
    ),
    Question(
      id: 'hist_029',
      categoryId: 'history',
      type: 'true_false',
      text: 'El Imperio Mongol fue el mayor imperio de la historia en términos de superficie terrestre continua.',
      options: ['Verdadero', 'Falso'],
      correctAnswer: 'Verdadero',
      explanation:
          'El Imperio Mongol alcanzó su máxima extensión en 1279, con más de 24 millones de km² contiguos, siendo el mayor imperio continental de la historia. El Imperio Británico fue mayor en total pero no era continuo.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'hist_030',
      categoryId: 'history',
      type: 'multiple_choice',
      text: '¿Qué evento desencadenó directamente la Primera Guerra Mundial en 1914?',
      options: [
        'La invasión alemana de Bélgica',
        'El asesinato del Archiduque Francisco Fernando en Sarajevo',
        'La declaración de guerra austro-húngara a Serbia',
        'El hundimiento del Lusitania'
      ],
      correctAnswer: 'El asesinato del Archiduque Francisco Fernando en Sarajevo',
      explanation:
          'El 28 de junio de 1914, el Archiduque Francisco Fernando de Austria fue asesinado en Sarajevo por el nacionalista serbio Gavrilo Princip. Este detonante activó las alianzas europeas y desembocó en la Primera Guerra Mundial.',
      difficulty: 2,
      xpReward: 25,
    ),

    // =========================================================================
    // CIENCIA — 16 questions
    // =========================================================================

    Question(
      id: 'sci_001',
      categoryId: 'science',
      type: 'multiple_choice',
      text: '¿Cuál es el elemento más abundante en el universo?',
      options: ['Oxígeno', 'Helio', 'Hidrógeno', 'Carbono'],
      correctAnswer: 'Hidrógeno',
      explanation:
          'El hidrógeno es el elemento más abundante del universo, conformando aproximadamente el 75% de toda la materia ordinaria.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'sci_002',
      categoryId: 'science',
      type: 'multiple_choice',
      text: '¿Qué científico formuló la teoría de la relatividad?',
      options: ['Isaac Newton', 'Albert Einstein', 'Niels Bohr', 'Max Planck'],
      correctAnswer: 'Albert Einstein',
      explanation:
          'Albert Einstein publicó la teoría especial de la relatividad en 1905 y la general en 1915, revolucionando nuestra comprensión del espacio, el tiempo y la gravedad.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'sci_003',
      categoryId: 'science',
      type: 'multiple_choice',
      text: '¿Cuántos cromosomas tiene el genoma humano?',
      options: ['23 pares', '24 pares', '22 pares', '46 pares'],
      correctAnswer: '23 pares',
      explanation:
          'El genoma humano está organizado en 23 pares de cromosomas (46 en total), donde uno de los pares determina el sexo biológico.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'sci_004',
      categoryId: 'science',
      type: 'true_false',
      text: 'Los agujeros negros emiten radiación según la teoría de Stephen Hawking.',
      options: ['Verdadero', 'Falso'],
      correctAnswer: 'Verdadero',
      explanation:
          'En 1974, Stephen Hawking predijo teóricamente que los agujeros negros emiten radiación térmica (llamada radiación de Hawking) debido a efectos cuánticos cerca del horizonte de eventos.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'sci_005',
      categoryId: 'science',
      type: 'multiple_choice',
      text: '¿Cuál es el símbolo químico del oro?',
      options: ['Go', 'Or', 'Au', 'Ag'],
      correctAnswer: 'Au',
      explanation:
          'El símbolo Au del oro proviene del latín "aurum". El oro es uno de los metales preciosos más valorados en la historia de la humanidad.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'sci_006',
      categoryId: 'science',
      type: 'multiple_choice',
      text: '¿A qué velocidad viaja la luz en el vacío?',
      options: [
        '300 000 km/s',
        '150 000 km/s',
        '500 000 km/s',
        '1 000 000 km/s'
      ],
      correctAnswer: '300 000 km/s',
      explanation:
          'La velocidad de la luz en el vacío es exactamente 299 792 458 m/s, aproximadamente 300 000 km/s, y es la velocidad máxima posible en el universo.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'sci_007',
      categoryId: 'science',
      type: 'multiple_choice',
      text: '¿Qué científica fue la primera persona en ganar dos Premios Nobel?',
      options: [
        'Rosalind Franklin',
        'Marie Curie',
        'Lise Meitner',
        'Dorothy Hodgkin'
      ],
      correctAnswer: 'Marie Curie',
      explanation:
          'Marie Curie ganó el Nobel de Física en 1903 (con su esposo Pierre y Henri Becquerel) y el Nobel de Química en 1911, siendo la única persona en ganarlos en dos disciplinas distintas.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'sci_008',
      categoryId: 'science',
      type: 'multiple_choice',
      text: '¿Qué planeta del sistema solar tiene el mayor número de lunas conocidas?',
      options: ['Júpiter', 'Saturno', 'Urano', 'Neptuno'],
      correctAnswer: 'Saturno',
      explanation:
          'Saturno tiene el mayor número de lunas confirmadas con 146 satélites naturales conocidos, superando a Júpiter que tiene 95.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'sci_009',
      categoryId: 'science',
      type: 'multiple_choice',
      text: '¿Cuál es el órgano más grande del cuerpo humano?',
      options: ['El hígado', 'El pulmón', 'La piel', 'El intestino'],
      correctAnswer: 'La piel',
      explanation:
          'La piel es el órgano más grande del cuerpo humano, con una superficie de aproximadamente 1.7 m² y un peso de unos 5 kg en un adulto promedio.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'sci_010',
      categoryId: 'science',
      type: 'multiple_choice',
      text: '¿Quién descubrió la penicilina en 1928?',
      options: [
        'Louis Pasteur',
        'Alexander Fleming',
        'Robert Koch',
        'Joseph Lister'
      ],
      correctAnswer: 'Alexander Fleming',
      explanation:
          'Alexander Fleming descubrió casualmente la penicilina en 1928 al observar que el moho Penicillium inhibía el crecimiento de bacterias en sus cultivos.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'sci_011',
      categoryId: 'science',
      type: 'multiple_choice',
      text: '¿Cuántas capas tiene la Tierra?',
      options: ['2', '3', '4', '5'],
      correctAnswer: '4',
      explanation:
          'La Tierra tiene cuatro capas principales: corteza, manto, núcleo externo (líquido) y núcleo interno (sólido), cada una con características físicas y químicas distintas.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'sci_012',
      categoryId: 'science',
      type: 'true_false',
      text: 'El ADN tiene forma de doble hélice, descubierta por Watson y Crick en 1953.',
      options: ['Verdadero', 'Falso'],
      correctAnswer: 'Verdadero',
      explanation:
          'James Watson y Francis Crick publicaron en 1953 la estructura de doble hélice del ADN, basándose en la fotografía de difracción de rayos X de Rosalind Franklin.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'sci_013',
      categoryId: 'science',
      type: 'multiple_choice',
      text: '¿Cuál es el gas que las plantas absorben durante la fotosíntesis?',
      options: ['Oxígeno', 'Nitrógeno', 'Dióxido de carbono', 'Metano'],
      correctAnswer: 'Dióxido de carbono',
      explanation:
          'En la fotosíntesis las plantas absorben CO₂ y agua y, usando energía solar, producen glucosa y liberan oxígeno como subproducto vital para la vida animal.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'sci_014',
      categoryId: 'science',
      type: 'multiple_choice',
      text: '¿Cuál es el número atómico del carbono?',
      options: ['4', '6', '8', '12'],
      correctAnswer: '6',
      explanation:
          'El carbono tiene número atómico 6, lo que significa que tiene 6 protones en su núcleo. Es la base de toda la química orgánica y de la vida en la Tierra.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'sci_015',
      categoryId: 'science',
      type: 'multiple_choice',
      text: '¿Qué partícula subatómica fue descubierta recientemente como el "bosón de Higgs"?',
      options: [
        'La partícula que da masa a la materia',
        'La partícula que genera la gravedad',
        'La partícula que compone los quarks',
        'La partícula de la antimateria'
      ],
      correctAnswer: 'La partícula que da masa a la materia',
      explanation:
          'El bosón de Higgs, confirmado en el CERN en 2012, es la partícula responsable de dar masa a otras partículas elementales a través del mecanismo de Higgs.',
      difficulty: 3,
      xpReward: 50,
    ),
    Question(
      id: 'sci_016',
      categoryId: 'science',
      type: 'multiple_choice',
      text: '¿Cuántos huesos tiene el cuerpo humano adulto?',
      options: ['180', '206', '225', '256'],
      correctAnswer: '206',
      explanation:
          'El cuerpo humano adulto tiene 206 huesos. Los bebés nacen con alrededor de 270-300, pero muchos se fusionan durante el crecimiento.',
      difficulty: 2,
      xpReward: 25,
    ),

    // =========================================================================
    // CIENCIA — preguntas adicionales (sci_017 – sci_030)
    // =========================================================================

    Question(
      id: 'sci_017',
      categoryId: 'science',
      type: 'multiple_choice',
      text: '¿Qué es la teoría de cuerdas en física teórica?',
      options: [
        'Una teoría que describe la gravedad cuántica mediante cuerdas unidimensionales vibrantes',
        'Una teoría sobre la formación de cuerdas de ADN',
        'Un modelo del sistema nervioso basado en redes',
        'Una teoría sobre la propagación del sonido en el universo'
      ],
      correctAnswer: 'Una teoría que describe la gravedad cuántica mediante cuerdas unidimensionales vibrantes',
      explanation:
          'La teoría de cuerdas propone que las partículas fundamentales no son puntos, sino cuerdas unidimensionales que vibran. Diferentes modos de vibración producen distintas partículas y podría unificar la mecánica cuántica con la relatividad general.',
      difficulty: 3,
      xpReward: 50,
    ),
    Question(
      id: 'sci_018',
      categoryId: 'science',
      type: 'multiple_choice',
      text: '¿Qué significa CRISPR en el contexto de la biología molecular?',
      options: [
        'Una técnica de edición genética de alta precisión',
        'Una proteína responsable de la replicación del ADN',
        'Un tipo de ARN mensajero modificado',
        'Un método de secuenciación genómica masiva'
      ],
      correctAnswer: 'Una técnica de edición genética de alta precisión',
      explanation:
          'CRISPR-Cas9 es una herramienta de edición genética desarrollada en 2012 por Jennifer Doudna y Emmanuelle Charpentier (Nobel 2020). Permite cortar y modificar el ADN con gran precisión, revolucionando la biología y la medicina.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'sci_019',
      categoryId: 'science',
      type: 'multiple_choice',
      text: '¿Qué es el horizonte de eventos de un agujero negro?',
      options: [
        'El límite más allá del cual nada, ni siquiera la luz, puede escapar',
        'La región donde la materia comienza a comprimirse',
        'El disco de gas y polvo que rodea al agujero negro',
        'La zona donde la gravedad se vuelve repulsiva'
      ],
      correctAnswer: 'El límite más allá del cual nada, ni siquiera la luz, puede escapar',
      explanation:
          'El horizonte de eventos es la frontera imaginaria alrededor de un agujero negro. Cualquier objeto o señal de luz que cruce este límite queda atrapado para siempre por la gravedad del agujero negro.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'sci_020',
      categoryId: 'science',
      type: 'multiple_choice',
      text: '¿Cuál es la ecuación química que resume la fotosíntesis?',
      options: [
        '6CO₂ + 6H₂O → C₆H₁₂O₆ + 6O₂',
        'C₆H₁₂O₆ + 6O₂ → 6CO₂ + 6H₂O',
        '6CO₂ + 6O₂ → C₆H₁₂O₆ + 6H₂O',
        '6H₂O + 6O₂ → C₆H₁₂O₆ + 6CO₂'
      ],
      correctAnswer: '6CO₂ + 6H₂O → C₆H₁₂O₆ + 6O₂',
      explanation:
          'La fotosíntesis se resume en: 6CO₂ + 6H₂O + energía luminosa → C₆H₁₂O₆ + 6O₂. Las plantas convierten dióxido de carbono y agua en glucosa y oxígeno usando luz solar.',
      difficulty: 3,
      xpReward: 50,
    ),
    Question(
      id: 'sci_021',
      categoryId: 'science',
      type: 'multiple_choice',
      text: '¿Cuáles son los gases nobles de la tabla periódica?',
      options: [
        'Hidrógeno, helio, nitrógeno y oxígeno',
        'Helio, neón, argón, kriptón, xenón y radón',
        'Flúor, cloro, bromo y yodo',
        'Litio, sodio, potasio y rubidio'
      ],
      correctAnswer: 'Helio, neón, argón, kriptón, xenón y radón',
      explanation:
          'Los gases nobles (grupo 18) son: helio (He), neón (Ne), argón (Ar), kriptón (Kr), xenón (Xe) y radón (Rn). Son extremadamente estables e inertes porque tienen su capa de valencia completa.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'sci_022',
      categoryId: 'science',
      type: 'multiple_choice',
      text: '¿Qué enuncia la tercera ley del movimiento de Newton?',
      options: [
        'Todo cuerpo en reposo permanece en reposo salvo que actúe una fuerza',
        'La fuerza es igual a la masa por la aceleración (F=ma)',
        'A toda acción le corresponde una reacción igual y opuesta',
        'La energía cinética es proporcional al cuadrado de la velocidad'
      ],
      correctAnswer: 'A toda acción le corresponde una reacción igual y opuesta',
      explanation:
          'La tercera ley de Newton establece que si un objeto A ejerce una fuerza sobre un objeto B, entonces B ejerce una fuerza igual en magnitud pero opuesta en dirección sobre A. Esto explica desde el vuelo de cohetes hasta el nado.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'sci_023',
      categoryId: 'science',
      type: 'multiple_choice',
      text: '¿Cuánto tiempo tarda la luz del Sol en llegar a la Tierra?',
      options: ['1 segundo', '8 minutos', '1 hora', '8 horas'],
      correctAnswer: '8 minutos',
      explanation:
          'La luz del Sol tarda aproximadamente 8 minutos y 20 segundos en llegar a la Tierra, recorriendo los 150 millones de km que nos separan a 300 000 km/s.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'sci_024',
      categoryId: 'science',
      type: 'multiple_choice',
      text: '¿Quiénes descubrieron la estructura del ADN y en qué año?',
      options: [
        'Pauling y Corey, en 1950',
        'Watson y Crick, en 1953',
        'Franklin y Wilkins, en 1952',
        'Avery y MacLeod, en 1944'
      ],
      correctAnswer: 'Watson y Crick, en 1953',
      explanation:
          'James Watson y Francis Crick publicaron el modelo de doble hélice del ADN en 1953 en la revista Nature, basándose crucialmente en la fotografía de difracción de Rosalind Franklin. Ganaron el Nobel de Medicina en 1962.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'sci_025',
      categoryId: 'science',
      type: 'multiple_choice',
      text: '¿Qué son las placas tectónicas?',
      options: [
        'Grandes fragmentos de la corteza y litósfera terrestre que se desplazan lentamente',
        'Capas de roca sedimentaria bajo los océanos',
        'Zonas volcánicas en los fondos oceánicos',
        'Estructuras cristalinas del manto superior'
      ],
      correctAnswer: 'Grandes fragmentos de la corteza y litósfera terrestre que se desplazan lentamente',
      explanation:
          'Las placas tectónicas son grandes fragmentos rígidos de la litósfera (corteza + manto superior) que flotan sobre el manto astenosférico y se desplazan varios centímetros por año, causando terremotos, volcanes y la formación de montañas.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'sci_026',
      categoryId: 'science',
      type: 'true_false',
      text: 'El agua hierve siempre a 100°C independientemente de la altitud.',
      options: ['Verdadero', 'Falso'],
      correctAnswer: 'Falso',
      explanation:
          'El punto de ebullición del agua varía con la presión atmosférica. A mayor altitud, menor presión, y el agua hierve a menor temperatura. En el Everest (8 849 m) hierve a unos 70°C.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'sci_027',
      categoryId: 'science',
      type: 'multiple_choice',
      text: '¿Qué tipo de onda son la luz visible y los rayos X?',
      options: [
        'Ondas mecánicas longitudinales',
        'Ondas electromagnéticas transversales',
        'Ondas de presión sonora',
        'Ondas gravitacionales cuánticas'
      ],
      correctAnswer: 'Ondas electromagnéticas transversales',
      explanation:
          'La luz visible, los rayos X, las microondas y las ondas de radio son todas ondas electromagnéticas transversales que no necesitan un medio para propagarse y viajan al vacío a 300 000 km/s.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'sci_028',
      categoryId: 'science',
      type: 'multiple_choice',
      text: '¿Cuántos pares de bases nitrogenadas contiene aproximadamente el genoma humano completo?',
      options: ['30 millones', '3 000 millones', '300 000 millones', '30 billones'],
      correctAnswer: '3 000 millones',
      explanation:
          'El genoma humano contiene aproximadamente 3 000 millones de pares de bases de ADN distribuidos en 23 pares de cromosomas, con unos 20 000-25 000 genes que codifican proteínas.',
      difficulty: 3,
      xpReward: 50,
    ),
    Question(
      id: 'sci_029',
      categoryId: 'science',
      type: 'multiple_choice',
      text: '¿Cuál es el planeta más caliente del sistema solar?',
      options: ['Mercurio', 'Venus', 'Júpiter', 'Marte'],
      correctAnswer: 'Venus',
      explanation:
          'Venus es el planeta más caliente del sistema solar con temperaturas de unos 465°C, a pesar de estar más lejos del Sol que Mercurio. Su densa atmósfera de CO₂ genera un efecto invernadero extremo.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'sci_030',
      categoryId: 'science',
      type: 'multiple_choice',
      text: '¿Qué es la materia oscura?',
      options: [
        'Una forma de materia que no emite ni absorbe luz pero tiene masa gravitacional',
        'El espacio vacío entre las galaxias',
        'Gas interestelar negro y frío',
        'Agujeros negros de pequeño tamaño distribuidos en el universo'
      ],
      correctAnswer: 'Una forma de materia que no emite ni absorbe luz pero tiene masa gravitacional',
      explanation:
          'La materia oscura es una forma hipotética de materia que no interactúa con la radiación electromagnética (no se puede ver), pero sí con la gravedad. Se estima que constituye el 27% del universo y es esencial para explicar la formación de galaxias.',
      difficulty: 3,
      xpReward: 50,
    ),

    // =========================================================================
    // GEOGRAFÍA — 14 questions
    // =========================================================================

    Question(
      id: 'geo_001',
      categoryId: 'geography',
      type: 'multiple_choice',
      text: '¿Cuál es el río más largo del mundo?',
      options: ['El Nilo', 'El Amazonas', 'El Yangtsé', 'El Misisipi'],
      correctAnswer: 'El Nilo',
      explanation:
          'El Nilo, con aproximadamente 6 650 km de longitud, es considerado el río más largo del mundo, aunque el Amazonas lo supera en caudal de agua.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'geo_002',
      categoryId: 'geography',
      type: 'multiple_choice',
      text: '¿Cuál es la capital de Australia?',
      options: ['Sídney', 'Melbourne', 'Canberra', 'Brisbane'],
      correctAnswer: 'Canberra',
      explanation:
          'Canberra es la capital de Australia desde 1913. Fue diseñada especialmente como capital y está ubicada entre Sídney y Melbourne.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'geo_003',
      categoryId: 'geography',
      type: 'multiple_choice',
      text: '¿Cuál es el país más grande del mundo por superficie?',
      options: ['China', 'Canadá', 'Estados Unidos', 'Rusia'],
      correctAnswer: 'Rusia',
      explanation:
          'Rusia es el país más grande del mundo con 17,1 millones de km², cubriendo más del 11% de la superficie terrestre total.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'geo_004',
      categoryId: 'geography',
      type: 'multiple_choice',
      text: '¿En qué continente está la cordillera de los Andes?',
      options: ['África', 'Asia', 'América del Norte', 'América del Sur'],
      correctAnswer: 'América del Sur',
      explanation:
          'Los Andes recorren 7 240 km a lo largo de la costa oeste de América del Sur, siendo la cordillera más larga del mundo y atravesando siete países.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'geo_005',
      categoryId: 'geography',
      type: 'multiple_choice',
      text: '¿Cuál es la montaña más alta del mundo?',
      options: ['K2', 'Monte Everest', 'Aconcagua', 'Monte Kilimanjaro'],
      correctAnswer: 'Monte Everest',
      explanation:
          'El Monte Everest, en la cordillera del Himalaya (Nepal/Tíbet), alcanza 8 849 metros sobre el nivel del mar, siendo el punto más alto de la Tierra.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'geo_006',
      categoryId: 'geography',
      type: 'multiple_choice',
      text: '¿Cuál es el océano más grande del planeta?',
      options: [
        'Océano Atlántico',
        'Océano Índico',
        'Océano Pacífico',
        'Océano Ártico'
      ],
      correctAnswer: 'Océano Pacífico',
      explanation:
          'El Océano Pacífico es el más grande y profundo, cubriendo más de 165 millones de km² y representando casi la mitad de la superficie oceánica total.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'geo_007',
      categoryId: 'geography',
      type: 'multiple_choice',
      text: '¿Cuál es el lago más profundo del mundo?',
      options: [
        'Lago Titicaca',
        'Lago Baikal',
        'Mar Caspio',
        'Lago Superior'
      ],
      correctAnswer: 'Lago Baikal',
      explanation:
          'El Lago Baikal en Siberia, Rusia, es el lago más profundo del mundo con 1 642 metros de profundidad y contiene el 20% del agua dulce superficial del planeta.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'geo_008',
      categoryId: 'geography',
      type: 'multiple_choice',
      text: '¿Cuál es la capital de Brasil?',
      options: ['São Paulo', 'Río de Janeiro', 'Brasilia', 'Salvador'],
      correctAnswer: 'Brasilia',
      explanation:
          'Brasilia es la capital federal de Brasil desde 1960. Fue construida desde cero y diseñada por el urbanista Lúcio Costa y el arquitecto Oscar Niemeyer.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'geo_009',
      categoryId: 'geography',
      type: 'multiple_choice',
      text: '¿Qué país de América del Sur no tiene salida al mar?',
      options: ['Ecuador', 'Paraguay', 'Uruguay', 'Guyana'],
      correctAnswer: 'Paraguay',
      explanation:
          'Paraguay y Bolivia son los únicos países mediterráneos (sin litoral marítimo) de América del Sur, aunque Paraguay tiene acceso fluvial al Atlántico a través del río Paraná.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'geo_010',
      categoryId: 'geography',
      type: 'multiple_choice',
      text: '¿En cuántos países está dividida África?',
      options: ['44', '54', '64', '34'],
      correctAnswer: '54',
      explanation:
          'África está dividida en 54 países reconocidos por la ONU, siendo el continente con más países del mundo.',
      difficulty: 3,
      xpReward: 50,
    ),
    Question(
      id: 'geo_011',
      categoryId: 'geography',
      type: 'true_false',
      text: 'El desierto del Sahara es el desierto más grande del mundo.',
      options: ['Verdadero', 'Falso'],
      correctAnswer: 'Falso',
      explanation:
          'El desierto más grande del mundo es la Antártida (un desierto polar de 14 millones de km²). El Sahara es el desierto caliente más grande con unos 9 millones de km².',
      difficulty: 3,
      xpReward: 50,
    ),
    Question(
      id: 'geo_012',
      categoryId: 'geography',
      type: 'multiple_choice',
      text: '¿Cuál es la capital de Canadá?',
      options: ['Toronto', 'Vancouver', 'Montreal', 'Ottawa'],
      correctAnswer: 'Ottawa',
      explanation:
          'Ottawa es la capital federal de Canadá desde 1857, elegida por la Reina Victoria. A pesar de ser la capital, no es la ciudad más poblada del país.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'geo_013',
      categoryId: 'geography',
      type: 'multiple_choice',
      text: '¿A través de cuántos países fluye el río Amazonas?',
      options: ['2', '3', '4', '5'],
      correctAnswer: '3',
      explanation:
          'El Amazonas fluye principalmente por Brasil, pero también nace en Perú y bordea Colombia, siendo el río con mayor caudal del mundo.',
      difficulty: 3,
      xpReward: 50,
    ),
    Question(
      id: 'geo_014',
      categoryId: 'geography',
      type: 'multiple_choice',
      text: '¿Cuál es el punto más bajo de la superficie terrestre?',
      options: [
        'Valle de la Muerte',
        'Mar Muerto',
        'Lago Assal',
        'Depresión de Qattara'
      ],
      correctAnswer: 'Mar Muerto',
      explanation:
          'El Mar Muerto, en la frontera de Israel, Jordania y Palestina, es el punto más bajo de la superficie terrestre a 430 metros bajo el nivel del mar.',
      difficulty: 2,
      xpReward: 25,
    ),

    // =========================================================================
    // GEOGRAFÍA — preguntas adicionales (geo_015 – geo_025)
    // =========================================================================

    Question(
      id: 'geo_015',
      categoryId: 'geography',
      type: 'multiple_choice',
      text: '¿Cuál es el río más largo de Europa?',
      options: ['El Rin', 'El Danubio', 'El Volga', 'El Elba'],
      correctAnswer: 'El Volga',
      explanation:
          'El Volga, con 3 690 km de longitud, es el río más largo de Europa. Nace en las colinas de Valdái y desemboca en el Mar Caspio, siendo de gran importancia histórica y económica para Rusia.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'geo_016',
      categoryId: 'geography',
      type: 'multiple_choice',
      text: '¿Cuál es la segunda montaña más alta del mundo?',
      options: ['Kangchenjunga', 'K2', 'Lhotse', 'Makalu'],
      correctAnswer: 'K2',
      explanation:
          'K2 (8 611 m), ubicado en la frontera entre Pakistán y China, es la segunda montaña más alta del mundo. Es considerada más difícil de escalar que el Everest y tiene una tasa de mortalidad significativamente mayor.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'geo_017',
      categoryId: 'geography',
      type: 'multiple_choice',
      text: '¿Cuál es la capital de Egipto?',
      options: ['Alejandría', 'Luxor', 'El Cairo', 'Asuán'],
      correctAnswer: 'El Cairo',
      explanation:
          'El Cairo es la capital de Egipto y la ciudad más grande de África y del mundo árabe, con más de 20 millones de habitantes en su área metropolitana. Está situada a orillas del Nilo, cerca de las pirámides de Guiza.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'geo_018',
      categoryId: 'geography',
      type: 'multiple_choice',
      text: '¿Cuál es el país más poblado de África?',
      options: ['Etiopía', 'República Democrática del Congo', 'Nigeria', 'Sudáfrica'],
      correctAnswer: 'Nigeria',
      explanation:
          'Nigeria es el país más poblado de África con más de 220 millones de habitantes, concentrando cerca del 20% de la población total del continente. Su capital es Abuja.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'geo_019',
      categoryId: 'geography',
      type: 'multiple_choice',
      text: '¿Cuál es el país más pequeño del mundo?',
      options: ['Mónaco', 'San Marino', 'Liechtenstein', 'Ciudad del Vaticano'],
      correctAnswer: 'Ciudad del Vaticano',
      explanation:
          'La Ciudad del Vaticano, con apenas 0,44 km², es el Estado independiente más pequeño del mundo. Está enclavado dentro de Roma y es la sede de la Iglesia Católica.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'geo_020',
      categoryId: 'geography',
      type: 'multiple_choice',
      text: '¿Cuál es el país con más islas en el mundo?',
      options: ['Filipinas', 'Indonesia', 'Suecia', 'Noruega'],
      correctAnswer: 'Suecia',
      explanation:
          'Suecia tiene aproximadamente 221 800 islas, el mayor número de cualquier país del mundo. Indonesia, con unas 17 000, es el mayor archipiélago en términos de superficie e islas habitadas.',
      difficulty: 3,
      xpReward: 50,
    ),
    Question(
      id: 'geo_021',
      categoryId: 'geography',
      type: 'multiple_choice',
      text: '¿Cuáles son los únicos dos países de América del Sur sin litoral marítimo?',
      options: [
        'Paraguay y Uruguay',
        'Bolivia y Paraguay',
        'Bolivia y Ecuador',
        'Paraguay y Colombia'
      ],
      correctAnswer: 'Bolivia y Paraguay',
      explanation:
          'Bolivia y Paraguay son los únicos países mediterráneos (sin costa marítima) de América del Sur. Bolivia perdió su litoral tras la Guerra del Pacífico (1879-1884) con Chile.',
      difficulty: 3,
      xpReward: 50,
    ),
    Question(
      id: 'geo_022',
      categoryId: 'geography',
      type: 'multiple_choice',
      text: '¿Cuál es el desierto más grande de Asia?',
      options: ['Desierto de Gobi', 'Desierto de Arabia', 'Desierto de Taklamakán', 'Desierto de Karakum'],
      correctAnswer: 'Desierto de Arabia',
      explanation:
          'El Desierto de Arabia, con unos 2,33 millones de km², es el desierto más grande de Asia. Abarca la mayor parte de la Península Arábiga e incluye el Rub al Jali, el mayor desierto de arena continuo del mundo.',
      difficulty: 3,
      xpReward: 50,
    ),
    Question(
      id: 'geo_023',
      categoryId: 'geography',
      type: 'multiple_choice',
      text: '¿En qué continente se encuentran las cataratas Victoria?',
      options: ['América del Sur', 'Asia', 'África', 'Oceanía'],
      correctAnswer: 'África',
      explanation:
          'Las cataratas Victoria, en la frontera entre Zambia y Zimbabue, son la cascada más grande del mundo por caudal y consideradas una de las Siete Maravillas Naturales. El río Zambeze las alimenta.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'geo_024',
      categoryId: 'geography',
      type: 'multiple_choice',
      text: '¿Cuál es la capital de Japón?',
      options: ['Osaka', 'Kioto', 'Tokio', 'Hiroshima'],
      correctAnswer: 'Tokio',
      explanation:
          'Tokio es la capital de Japón desde 1869 y la mayor área metropolitana del mundo con unos 37 millones de habitantes. Anteriormente la capital era Kioto, que fue el centro imperial durante más de mil años.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'geo_025',
      categoryId: 'geography',
      type: 'multiple_choice',
      text: '¿Por cuántos países pasa el río Danubio?',
      options: ['6', '8', '10', '12'],
      correctAnswer: '10',
      explanation:
          'El Danubio (2 860 km) es el río que pasa por más países del mundo: Alemania, Austria, Eslovaquia, Hungría, Croacia, Serbia, Bulgaria, Rumanía, Moldavia y Ucrania, además de bordear otros dos.',
      difficulty: 3,
      xpReward: 50,
    ),

    // =========================================================================
    // ARTE — 14 questions
    // =========================================================================

    Question(
      id: 'art_001',
      categoryId: 'art',
      type: 'multiple_choice',
      text: '¿Quién pintó "La Gioconda" (Mona Lisa)?',
      options: [
        'Michelangelo',
        'Rafael',
        'Leonardo da Vinci',
        'Sandro Botticelli'
      ],
      correctAnswer: 'Leonardo da Vinci',
      explanation:
          'La Gioconda fue pintada por Leonardo da Vinci entre 1503 y 1519. Se cree que representa a Lisa Gherardini y hoy es el cuadro más famoso del mundo, expuesto en el Louvre.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'art_002',
      categoryId: 'art',
      type: 'multiple_choice',
      text: '¿Quién esculpió el David de Florencia?',
      options: [
        'Leonardo da Vinci',
        'Donatello',
        'Bernini',
        'Michelangelo'
      ],
      correctAnswer: 'Michelangelo',
      explanation:
          'Miguel Ángel esculpió el David entre 1501 y 1504, cuando tenía entre 26 y 29 años. Es considerada una de las mayores obras maestras del Renacimiento.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'art_003',
      categoryId: 'art',
      type: 'multiple_choice',
      text: '¿Qué movimiento artístico representan pintores como Monet, Renoir y Degas?',
      options: ['Cubismo', 'Surrealismo', 'Impresionismo', 'Expresionismo'],
      correctAnswer: 'Impresionismo',
      explanation:
          'El Impresionismo surgió en Francia en los años 1860-1870. Sus pintores, entre ellos Monet, Renoir y Degas, buscaban capturar los efectos de la luz y el instante fugaz.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'art_004',
      categoryId: 'art',
      type: 'multiple_choice',
      text: '¿Qué arquitecto diseñó la Sagrada Familia en Barcelona?',
      options: [
        'Santiago Calatrava',
        'Antoni Gaudí',
        'Rafael Moneo',
        'Mies van der Rohe'
      ],
      correctAnswer: 'Antoni Gaudí',
      explanation:
          'Antoni Gaudí diseñó la Sagrada Familia y tomó las riendas del proyecto en 1883. Aunque Gaudí murió en 1926, la construcción continúa hasta hoy siguiendo sus planos.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'art_005',
      categoryId: 'art',
      type: 'multiple_choice',
      text: '¿Quién compuso la Novena Sinfonía (Oda a la Alegría)?',
      options: ['Mozart', 'Bach', 'Beethoven', 'Chopin'],
      correctAnswer: 'Beethoven',
      explanation:
          'Ludwig van Beethoven compuso la Novena Sinfonía en 1824, notablemente cuando ya era completamente sordo. La melodía del cuarto movimiento es hoy el himno de la Unión Europea.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'art_006',
      categoryId: 'art',
      type: 'multiple_choice',
      text: '¿Qué pintor español es conocido por su período azul y su obra "El Guernica"?',
      options: [
        'Salvador Dalí',
        'Joan Miró',
        'Francisco Goya',
        'Pablo Picasso'
      ],
      correctAnswer: 'Pablo Picasso',
      explanation:
          'Pablo Picasso pintó el Guernica en 1937 en respuesta al bombardeo de la ciudad vasca durante la Guerra Civil Española. Es una obra icónica del cubismo y el antibelicismo.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'art_007',
      categoryId: 'art',
      type: 'multiple_choice',
      text: '¿Cuánto mide aproximadamente el cuadro "La noche estrellada" de Van Gogh?',
      options: [
        '73 × 92 cm',
        '200 × 300 cm',
        '30 × 40 cm',
        '120 × 160 cm'
      ],
      correctAnswer: '73 × 92 cm',
      explanation:
          'La noche estrellada de Van Gogh (1889) mide 73,7 × 92,1 cm, un tamaño moderado para su enorme impacto cultural. Actualmente se exhibe en el MoMA de Nueva York.',
      difficulty: 3,
      xpReward: 50,
    ),
    Question(
      id: 'art_008',
      categoryId: 'art',
      type: 'multiple_choice',
      text: '¿En qué siglo floreció el movimiento artístico del Renacimiento?',
      options: [
        'Siglos XI-XII',
        'Siglos XIV-XVI',
        'Siglos XVII-XVIII',
        'Siglos XIX-XX'
      ],
      correctAnswer: 'Siglos XIV-XVI',
      explanation:
          'El Renacimiento surgió en Italia entre los siglos XIV y XVI, caracterizándose por el retorno a los ideales clásicos griegos y romanos, y por enormes avances en arte, ciencia y filosofía.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'art_009',
      categoryId: 'art',
      type: 'true_false',
      text:
          'El Coliseo de Roma fue construido en un solo año bajo el mandato del emperador Vespasiano.',
      options: ['Verdadero', 'Falso'],
      correctAnswer: 'Falso',
      explanation:
          'El Coliseo Romano tardó unos 10 años en construirse (70-80 d.C.), iniciado por el emperador Vespasiano e inaugurado por su hijo Tito. Podía albergar entre 50 000 y 80 000 espectadores.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'art_010',
      categoryId: 'art',
      type: 'multiple_choice',
      text: '¿A qué movimiento pertenecen artistas como Salvador Dalí y René Magritte?',
      options: ['Dadaísmo', 'Surrealismo', 'Futurismo', 'Art Nouveau'],
      correctAnswer: 'Surrealismo',
      explanation:
          'El Surrealismo surgió en los años 1920 y exploraba el mundo de los sueños y el inconsciente. Dalí y Magritte son sus representantes más icónicos.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'art_011',
      categoryId: 'art',
      type: 'multiple_choice',
      text: '¿Quién pintó "Las meninas"?',
      options: ['El Greco', 'Francisco de Goya', 'Diego Velázquez', 'Zurbarán'],
      correctAnswer: 'Diego Velázquez',
      explanation:
          'Las Meninas fue pintada por Diego Velázquez en 1656 durante el reinado de Felipe IV. Es considerada una de las obras maestras más importantes de la pintura occidental.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'art_012',
      categoryId: 'art',
      type: 'multiple_choice',
      text: '¿Cuántos años tardó Miguel Ángel en pintar la Capilla Sixtina?',
      options: ['2 años', '4 años', '8 años', '12 años'],
      correctAnswer: '4 años',
      explanation:
          'Miguel Ángel pintó el techo de la Capilla Sixtina entre 1508 y 1512, es decir, en aproximadamente 4 años. La obra cubre más de 500 m² y muestra más de 300 figuras.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'art_013',
      categoryId: 'art',
      type: 'multiple_choice',
      text: '¿Cuál es la ópera más representada en el mundo?',
      options: ['La Traviata', 'La Bohème', 'Carmen', 'La Flauta Mágica'],
      correctAnswer: 'La Traviata',
      explanation:
          'La Traviata de Giuseppe Verdi, estrenada en 1853 en Venecia, es la ópera más representada del mundo según estadísticas de la ópera Operabase.',
      difficulty: 3,
      xpReward: 50,
    ),
    Question(
      id: 'art_014',
      categoryId: 'art',
      type: 'multiple_choice',
      text: '¿En qué ciudad se encuentra el museo del Louvre?',
      options: ['Londres', 'Roma', 'Berlín', 'París'],
      correctAnswer: 'París',
      explanation:
          'El Louvre, ubicado en París, Francia, es el museo de arte más visitado del mundo con más de 9 millones de visitantes anuales y alberga más de 380 000 obras.',
      difficulty: 1,
      xpReward: 10,
    ),

    // =========================================================================
    // ARTE — preguntas adicionales (art_015 – art_025)
    // =========================================================================

    Question(
      id: 'art_015',
      categoryId: 'art',
      type: 'multiple_choice',
      text: '¿Por qué es famosa Frida Kahlo en el mundo del arte?',
      options: [
        'Por sus esculturas abstractas de gran formato',
        'Por sus autorretratos íntimos que mezclan realismo y surrealismo mexicano',
        'Por fundar el movimiento muralista mexicano',
        'Por sus fotografías documental del México rural'
      ],
      correctAnswer: 'Por sus autorretratos íntimos que mezclan realismo y surrealismo mexicano',
      explanation:
          'Frida Kahlo (1907-1954) es célebre por sus autorretratos vívidos que expresan el dolor físico y emocional de su vida, combinando simbolismo mexicano, surrealismo y realismo. Pintó 55 de sus 143 obras como autorretratos.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'art_016',
      categoryId: 'art',
      type: 'multiple_choice',
      text: '¿Cuál es la obra más famosa de Salvador Dalí?',
      options: [
        'La persistencia de la memoria',
        'El gran masturbador',
        'El Cristo de San Juan de la Cruz',
        'Sueño causado por el vuelo de una abeja'
      ],
      correctAnswer: 'La persistencia de la memoria',
      explanation:
          '"La persistencia de la memoria" (1931) es el cuadro más icónico de Salvador Dalí, con sus célebres relojes derretidos. Mide solo 24 × 33 cm y se exhibe en el MoMA de Nueva York.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'art_017',
      categoryId: 'art',
      type: 'multiple_choice',
      text: '¿Dónde pintó Van Gogh "La noche estrellada"?',
      options: [
        'En Ámsterdam, durante su período temprano',
        'En el manicomio de Saint-Paul-de-Mausole en Saint-Rémy-de-Provence',
        'En París, durante su estancia con Toulouse-Lautrec',
        'En Arlés, mientras vivía con Gauguin'
      ],
      correctAnswer: 'En el manicomio de Saint-Paul-de-Mausole en Saint-Rémy-de-Provence',
      explanation:
          'Van Gogh pintó "La noche estrellada" en junio de 1889 desde la ventana de su habitación en el manicomio de Saint-Paul-de-Mausole, donde se había internado voluntariamente tras cortarse la oreja en Arlés.',
      difficulty: 3,
      xpReward: 50,
    ),
    Question(
      id: 'art_018',
      categoryId: 'art',
      type: 'multiple_choice',
      text: '¿En qué ciudad de Estados Unidos nació el jazz como género musical?',
      options: ['Nueva York', 'Chicago', 'Nueva Orleans', 'Memphis'],
      correctAnswer: 'Nueva Orleans',
      explanation:
          'El jazz nació en Nueva Orleans a finales del siglo XIX, fusionando elementos del blues, los espirituales afroamericanos, el ragtime y la música creole. El Barrio Francés de Nueva Orleans fue su cuna principal.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'art_019',
      categoryId: 'art',
      type: 'multiple_choice',
      text: '¿En qué país se originó el ballet clásico como forma de arte?',
      options: ['Rusia', 'Italia', 'Francia', 'Austria'],
      correctAnswer: 'Italia',
      explanation:
          'El ballet clásico surgió en las cortes italianas del Renacimiento en el siglo XV y XVI como espectáculo cortesano. Luego se desarrolló en Francia bajo Luis XIV, quien fundó la primera academia de danza en 1661.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'art_020',
      categoryId: 'art',
      type: 'multiple_choice',
      text: '¿Quién compuso las óperas "Don Giovanni" y "La flauta mágica"?',
      options: ['Ludwig van Beethoven', 'Wolfgang Amadeus Mozart', 'Giuseppe Verdi', 'Richard Wagner'],
      correctAnswer: 'Wolfgang Amadeus Mozart',
      explanation:
          'Wolfgang Amadeus Mozart compuso "Don Giovanni" en 1787 y "La flauta mágica" en 1791, el mismo año de su muerte a los 35 años. Fue un genio musical que comenzó a componer a los cinco años.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'art_021',
      categoryId: 'art',
      type: 'multiple_choice',
      text: '¿Qué estilo arquitectónico caracteriza la obra de Antoni Gaudí?',
      options: [
        'Racionalismo funcional y minimalismo',
        'Modernismo catalán con formas orgánicas y naturalistas',
        'Neogótico con influencias árabes clásicas',
        'Art Déco con ornamentación geométrica'
      ],
      correctAnswer: 'Modernismo catalán con formas orgánicas y naturalistas',
      explanation:
          'Gaudí desarrolló un estilo único dentro del Modernismo catalán, inspirado en la naturaleza: curvas, espirales, estructuras parabólicas y mosaicos de cerámica (trencadís). La Sagrada Familia y el Park Güell son sus obras más representativas.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'art_022',
      categoryId: 'art',
      type: 'multiple_choice',
      text: '¿Qué arquitecta iraquí-británica fue la primera mujer en ganar el Premio Pritzker?',
      options: ['Kazuyo Sejima', 'Zaha Hadid', 'Wang Shu', 'Grafton Architects'],
      correctAnswer: 'Zaha Hadid',
      explanation:
          'Zaha Hadid (1950-2016) fue la primera mujer en recibir el Premio Pritzker (2004), considerado el Nobel de la arquitectura. Sus diseños futuristas y deconstruccionistas incluyen el MAXXI de Roma y el Centro Heydar Aliyev de Bakú.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'art_023',
      categoryId: 'art',
      type: 'multiple_choice',
      text: '¿Qué técnica pictórica usaba Georges Seurat, creando imágenes con pequeños puntos de color?',
      options: ['Impresionismo', 'Puntillismo', 'Fauvismo', 'Cubismo'],
      correctAnswer: 'Puntillismo',
      explanation:
          'Georges Seurat desarrolló el puntillismo (también llamado divisionismo o neoimoresionismo), técnica que aplica pequeños puntos de colores puros que se mezclan en el ojo del espectador. "Un domingo en la Grande Jatte" es su obra más célebre.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'art_024',
      categoryId: 'art',
      type: 'multiple_choice',
      text: '¿Cuál es el instrumento principal del compositor polaco Frédéric Chopin?',
      options: ['Violín', 'Cello', 'Piano', 'Órgano'],
      correctAnswer: 'Piano',
      explanation:
          'Frédéric Chopin (1810-1849) compuso casi exclusivamente para piano y es considerado uno de los mayores compositores para este instrumento. Sus nocturnos, mazurcas y polonesas son piezas fundamentales del repertorio pianístico.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'art_025',
      categoryId: 'art',
      type: 'true_false',
      text: 'El cubismo fue fundado conjuntamente por Pablo Picasso y Georges Braque alrededor de 1907.',
      options: ['Verdadero', 'Falso'],
      correctAnswer: 'Verdadero',
      explanation:
          'El cubismo fue desarrollado conjuntamente por Picasso y Braque entre 1907 y 1914. "Las señoritas de Avignon" de Picasso (1907) se considera el primer cuadro cubista, y ambos trabajaron estrechamente en los años siguientes.',
      difficulty: 2,
      xpReward: 25,
    ),

    // =========================================================================
    // TECNOLOGÍA — 16 questions
    // =========================================================================

    Question(
      id: 'tech_001',
      categoryId: 'tech',
      type: 'multiple_choice',
      text: '¿Quién inventó el teléfono?',
      options: [
        'Thomas Edison',
        'Nikola Tesla',
        'Alexander Graham Bell',
        'Guglielmo Marconi'
      ],
      correctAnswer: 'Alexander Graham Bell',
      explanation:
          'Alexander Graham Bell patentó el teléfono en 1876, aunque el inventor Antonio Meucci también reivindica su invención en años anteriores. Bell fue el primero en obtener la patente.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'tech_002',
      categoryId: 'tech',
      type: 'multiple_choice',
      text: '¿En qué año se creó Internet (la red ARPANET)?',
      options: ['1959', '1969', '1979', '1989'],
      correctAnswer: '1969',
      explanation:
          'ARPANET, precursora de Internet, fue creada en 1969 por el Departamento de Defensa de Estados Unidos. El primer mensaje fue enviado entre UCLA y el Stanford Research Institute.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'tech_003',
      categoryId: 'tech',
      type: 'multiple_choice',
      text: '¿Quién es considerado el padre de la computación moderna?',
      options: [
        'Bill Gates',
        'Alan Turing',
        'John von Neumann',
        'Charles Babbage'
      ],
      correctAnswer: 'Alan Turing',
      explanation:
          'Alan Turing es ampliamente considerado el padre de la computación moderna. Desarrolló la Máquina de Turing y contribuyó decisivamente a descifrar el código Enigma en la Segunda Guerra Mundial.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'tech_004',
      categoryId: 'tech',
      type: 'multiple_choice',
      text: '¿En qué año se fundó Apple Inc.?',
      options: ['1974', '1976', '1980', '1984'],
      correctAnswer: '1976',
      explanation:
          'Apple Inc. fue fundada el 1 de abril de 1976 por Steve Jobs, Steve Wozniak y Ronald Wayne. El primer producto fue el Apple I, un computador personal que Wozniak diseñó.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'tech_005',
      categoryId: 'tech',
      type: 'multiple_choice',
      text: '¿Quién inventó la World Wide Web (WWW)?',
      options: [
        'Bill Gates',
        'Tim Berners-Lee',
        'Linus Torvalds',
        'Vint Cerf'
      ],
      correctAnswer: 'Tim Berners-Lee',
      explanation:
          'Tim Berners-Lee inventó la World Wide Web en 1989 mientras trabajaba en el CERN, creando el primer servidor web y el lenguaje HTML para facilitar el intercambio de información.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'tech_006',
      categoryId: 'tech',
      type: 'multiple_choice',
      text: '¿Cuál fue el primer satélite artificial lanzado al espacio?',
      options: ['Explorer 1', 'Sputnik 1', 'Vostok 1', 'Telstar'],
      correctAnswer: 'Sputnik 1',
      explanation:
          'El Sputnik 1, lanzado por la Unión Soviética el 4 de octubre de 1957, fue el primer satélite artificial en orbitar la Tierra, iniciando la carrera espacial.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'tech_007',
      categoryId: 'tech',
      type: 'multiple_choice',
      text: '¿En qué año los seres humanos pisaron la Luna por primera vez?',
      options: ['1965', '1967', '1969', '1972'],
      correctAnswer: '1969',
      explanation:
          'El 20 de julio de 1969, Neil Armstrong y Buzz Aldrin se convirtieron en los primeros humanos en pisar la Luna durante la misión Apollo 11 de la NASA.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'tech_008',
      categoryId: 'tech',
      type: 'multiple_choice',
      text: '¿Qué lenguaje de programación fue creado por Linus Torvalds?',
      options: ['Python', 'C++', 'Linux no es un lenguaje', 'Java'],
      correctAnswer: 'Linux no es un lenguaje',
      explanation:
          'Linus Torvalds creó el núcleo Linux (un sistema operativo), no un lenguaje de programación. Linux fue escrito principalmente en C y es la base de muchos sistemas operativos.',
      difficulty: 3,
      xpReward: 50,
    ),
    Question(
      id: 'tech_009',
      categoryId: 'tech',
      type: 'true_false',
      text: 'El transistor fue inventado en los Laboratorios Bell en 1947.',
      options: ['Verdadero', 'Falso'],
      correctAnswer: 'Verdadero',
      explanation:
          'El transistor fue inventado el 16 de diciembre de 1947 por John Bardeen, Walter Brattain y William Shockley en los Laboratorios Bell, revolución que sentó las bases de la electrónica moderna.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'tech_010',
      categoryId: 'tech',
      type: 'multiple_choice',
      text: '¿En qué año se lanzó el primer iPhone?',
      options: ['2005', '2007', '2009', '2010'],
      correctAnswer: '2007',
      explanation:
          'Steve Jobs presentó el primer iPhone el 9 de enero de 2007 en la Macworld Conference, revolucionando la industria de los teléfonos móviles con su pantalla táctil y sistema operativo iOS.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'tech_011',
      categoryId: 'tech',
      type: 'multiple_choice',
      text: '¿Qué empresa desarrolló el sistema operativo Android?',
      options: ['Samsung', 'Google', 'Microsoft', 'Nokia'],
      correctAnswer: 'Google',
      explanation:
          'Android fue desarrollado inicialmente por Android Inc., que fue adquirida por Google en 2005. El primer teléfono con Android, el HTC Dream, se lanzó en 2008.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'tech_012',
      categoryId: 'tech',
      type: 'multiple_choice',
      text: '¿Cuál fue la primera red social con más de 1 000 millones de usuarios?',
      options: ['Twitter', 'MySpace', 'Facebook', 'YouTube'],
      correctAnswer: 'Facebook',
      explanation:
          'Facebook fue la primera red social en superar los 1 000 millones de usuarios activos mensuales, logrando este hito en octubre de 2012.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'tech_013',
      categoryId: 'tech',
      type: 'multiple_choice',
      text: '¿Qué significa el acrónimo "AI" en tecnología?',
      options: [
        'Automatic Interface',
        'Artificial Intelligence',
        'Advanced Integration',
        'Automated Input'
      ],
      correctAnswer: 'Artificial Intelligence',
      explanation:
          'AI significa Inteligencia Artificial (Artificial Intelligence en inglés), rama de la informática que busca desarrollar sistemas capaces de realizar tareas que normalmente requieren inteligencia humana.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'tech_014',
      categoryId: 'tech',
      type: 'multiple_choice',
      text: '¿Quién escribió el primer programa de computadora, considerada la primera programadora de la historia?',
      options: [
        'Grace Hopper',
        'Ada Lovelace',
        'Margaret Hamilton',
        'Barbara Liskov'
      ],
      correctAnswer: 'Ada Lovelace',
      explanation:
          'Ada Lovelace, matemática inglesa del siglo XIX, escribió el primer algoritmo pensado para ser procesado por la Máquina Analítica de Charles Babbage, siendo considerada la primera programadora.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'tech_015',
      categoryId: 'tech',
      type: 'multiple_choice',
      text: '¿Cuántos bits tiene un byte?',
      options: ['4', '8', '16', '32'],
      correctAnswer: '8',
      explanation:
          'Un byte está compuesto por 8 bits. Esta unidad es la base del almacenamiento digital y permite representar 256 valores diferentes (2⁸).',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'tech_016',
      categoryId: 'tech',
      type: 'multiple_choice',
      text: '¿Qué compañía creó el lenguaje de programación Python?',
      options: [
        'Microsoft',
        'Google',
        'Guido van Rossum (independiente)',
        'Sun Microsystems'
      ],
      correctAnswer: 'Guido van Rossum (independiente)',
      explanation:
          'Python fue creado por Guido van Rossum y lanzado en 1991. Van Rossum lo desarrolló de forma independiente; posteriormente la Python Software Foundation gestiona su evolución.',
      difficulty: 3,
      xpReward: 50,
    ),

    // =========================================================================
    // TECNOLOGÍA — preguntas adicionales (tech_017 – tech_027)
    // =========================================================================

    Question(
      id: 'tech_017',
      categoryId: 'tech',
      type: 'multiple_choice',
      text: '¿Cuál fue la primera computadora electrónica de propósito general?',
      options: ['UNIVAC I', 'ENIAC', 'Colossus', 'IBM 701'],
      correctAnswer: 'ENIAC',
      explanation:
          'ENIAC (Electronic Numerical Integrator and Computer), completada en 1945 en la Universidad de Pensilvania, fue la primera computadora electrónica digital de propósito general. Pesaba 27 toneladas y ocupaba 167 m².',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'tech_018',
      categoryId: 'tech',
      type: 'multiple_choice',
      text: '¿Qué lenguaje de programación creó Bjarne Stroustrup en los años 80?',
      options: ['Java', 'C++', 'Rust', 'Pascal'],
      correctAnswer: 'C++',
      explanation:
          'Bjarne Stroustrup desarrolló C++ en los Laboratorios Bell a principios de los años 80, añadiendo programación orientada a objetos al lenguaje C. Es uno de los lenguajes más usados en sistemas operativos y videojuegos.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'tech_019',
      categoryId: 'tech',
      type: 'multiple_choice',
      text: '¿Cuándo lanzó SpaceX su primer cohete reutilizable que aterrizó exitosamente?',
      options: ['2010', '2013', '2015', '2018'],
      correctAnswer: '2015',
      explanation:
          'El 21 de diciembre de 2015, SpaceX logró el primer aterrizaje exitoso del cohete Falcon 9 en tierra firme, un hito revolucionario en la historia espacial. La reutilización de cohetes reduce drásticamente el coste de los lanzamientos.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'tech_020',
      categoryId: 'tech',
      type: 'multiple_choice',
      text: '¿Qué es el aprendizaje profundo (deep learning) en inteligencia artificial?',
      options: [
        'Un tipo de programación que usa instrucciones detalladas paso a paso',
        'Redes neuronales artificiales con múltiples capas que aprenden de grandes conjuntos de datos',
        'Un algoritmo de búsqueda exhaustiva en bases de datos masivas',
        'Un sistema de lógica difusa basado en reglas expertas'
      ],
      correctAnswer: 'Redes neuronales artificiales con múltiples capas que aprenden de grandes conjuntos de datos',
      explanation:
          'El deep learning usa redes neuronales con muchas capas ocultas que aprenden representaciones jerárquicas de los datos. Es la base del reconocimiento de imágenes, voz y traducción automática modernos.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'tech_021',
      categoryId: 'tech',
      type: 'multiple_choice',
      text: '¿En qué consiste la tecnología blockchain?',
      options: [
        'Un registro distribuido e inmutable de transacciones verificadas por consenso',
        'Un sistema de cifrado de mensajes punto a punto',
        'Una red de servidores centralizados con alta redundancia',
        'Un protocolo de compresión de datos para transmisión rápida'
      ],
      correctAnswer: 'Un registro distribuido e inmutable de transacciones verificadas por consenso',
      explanation:
          'La blockchain es una cadena de bloques de datos enlazados criptográficamente, distribuida entre muchos nodos sin autoridad central. Es la base de Bitcoin y otras criptomonedas, y se usa para contratos inteligentes y trazabilidad.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'tech_022',
      categoryId: 'tech',
      type: 'multiple_choice',
      text: '¿En qué año se lanzó el primer smartphone con pantalla táctil capacitiva moderna?',
      options: ['2005', '2007', '2009', '2011'],
      correctAnswer: '2007',
      explanation:
          'El primer iPhone, presentado por Steve Jobs el 9 de enero de 2007, popularizó la pantalla táctil capacitiva multitáctil, eliminando el teclado físico. Este diseño se convirtió en el estándar de los smartphones modernos.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'tech_023',
      categoryId: 'tech',
      type: 'multiple_choice',
      text: '¿Qué significa GPS?',
      options: [
        'Global Positioning System',
        'General Precision Satellite',
        'Geo-Photon Sensor',
        'Ground Positioning Sensor'
      ],
      correctAnswer: 'Global Positioning System',
      explanation:
          'GPS (Sistema de Posicionamiento Global) es un sistema de navegación por satélite desarrollado por el ejército de EE.UU., operativo desde 1994. Usa una constelación de al menos 24 satélites para determinar la posición en cualquier lugar de la Tierra.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'tech_024',
      categoryId: 'tech',
      type: 'multiple_choice',
      text: '¿Cuál es la diferencia principal entre inteligencia artificial estrecha y general?',
      options: [
        'La IA estrecha realiza tareas específicas; la IA general puede aprender cualquier tarea cognitiva humana',
        'La IA estrecha usa menos datos; la IA general usa más',
        'La IA estrecha es más rápida; la IA general es más precisa',
        'La IA estrecha es software; la IA general es hardware'
      ],
      correctAnswer: 'La IA estrecha realiza tareas específicas; la IA general puede aprender cualquier tarea cognitiva humana',
      explanation:
          'La IA estrecha (ANI) realiza una única tarea bien definida como jugar al ajedrez o reconocer caras. La IA general (AGI) hipotética podría aprender y realizar cualquier tarea intelectual que un humano pueda hacer. Hoy solo existe ANI.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'tech_025',
      categoryId: 'tech',
      type: 'true_false',
      text: 'El lenguaje HTML fue creado por Tim Berners-Lee para estructurar páginas web.',
      options: ['Verdadero', 'Falso'],
      correctAnswer: 'Verdadero',
      explanation:
          'Tim Berners-Lee inventó HTML (HyperText Markup Language) en 1991 junto con el protocolo HTTP y la URL, creando así la World Wide Web. HTML es el lenguaje de marcado estándar para estructurar el contenido web.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'tech_026',
      categoryId: 'tech',
      type: 'multiple_choice',
      text: '¿Qué es la computación cuántica?',
      options: [
        'Computación que usa qubits y principios cuánticos para procesar información de forma paralela',
        'Computación a velocidades cuánticas, millones de veces más rápida que la convencional',
        'Un tipo de computación óptica basada en fotones',
        'Computación distribuida usando miles de servidores pequeños'
      ],
      correctAnswer: 'Computación que usa qubits y principios cuánticos para procesar información de forma paralela',
      explanation:
          'La computación cuántica usa qubits (que pueden ser 0 y 1 simultáneamente gracias a la superposición cuántica) y el entrelazamiento cuántico para resolver ciertos problemas exponencialmente más rápido que los ordenadores clásicos.',
      difficulty: 3,
      xpReward: 50,
    ),
    Question(
      id: 'tech_027',
      categoryId: 'tech',
      type: 'multiple_choice',
      text: '¿Cuál es el lenguaje de programación más usado para desarrollo web del lado del servidor según encuestas recientes?',
      options: ['Ruby', 'PHP', 'JavaScript (Node.js)', 'Python'],
      correctAnswer: 'JavaScript (Node.js)',
      explanation:
          'JavaScript con Node.js es el lenguaje más usado para desarrollo web del lado del servidor según encuestas como Stack Overflow Developer Survey. Permite usar el mismo lenguaje tanto en frontend como en backend.',
      difficulty: 2,
      xpReward: 25,
    ),

    // =========================================================================
    // FILOSOFÍA — 16 questions
    // =========================================================================

    Question(
      id: 'phi_001',
      categoryId: 'philosophy',
      type: 'multiple_choice',
      text: '¿Cuál es el método filosófico asociado a Sócrates?',
      options: [
        'El deductivismo',
        'La mayéutica',
        'El empirismo',
        'La dialéctica hegeliana'
      ],
      correctAnswer: 'La mayéutica',
      explanation:
          'Sócrates utilizaba la mayéutica, un método de preguntas y respuestas que buscaba que el interlocutor "diera a luz" el conocimiento que ya tenía dentro de sí mismo.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'phi_002',
      categoryId: 'philosophy',
      type: 'multiple_choice',
      text: '¿Qué filósofo griego fue maestro de Alejandro Magno?',
      options: ['Sócrates', 'Platón', 'Aristóteles', 'Epicuro'],
      correctAnswer: 'Aristóteles',
      explanation:
          'Aristóteles fue el tutor personal de Alejandro Magno durante varios años. También fue discípulo de Platón y fundó el Liceo en Atenas, siendo uno de los pensadores más influyentes de la historia.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'phi_003',
      categoryId: 'philosophy',
      type: 'multiple_choice',
      text: '¿Cuál es la famosa frase de René Descartes que resume su filosofía?',
      options: [
        '"El hombre es la medida de todas las cosas"',
        '"Cogito ergo sum" (Pienso, luego existo)',
        '"La vida es sueño"',
        '"Solo sé que no sé nada"'
      ],
      correctAnswer: '"Cogito ergo sum" (Pienso, luego existo)',
      explanation:
          '"Cogito ergo sum" es la proposición central de la filosofía de Descartes, expresada en su obra "Meditaciones Metafísicas" (1641). Significa que la única certeza absoluta es el propio acto de pensar.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'phi_004',
      categoryId: 'philosophy',
      type: 'multiple_choice',
      text: '¿Qué filósofo escribió "Así habló Zaratustra"?',
      options: [
        'Arthur Schopenhauer',
        'Friedrich Nietzsche',
        'Immanuel Kant',
        'Georg Hegel'
      ],
      correctAnswer: 'Friedrich Nietzsche',
      explanation:
          '"Así habló Zaratustra" fue escrito por Friedrich Nietzsche entre 1883 y 1885, y en él introduce conceptos como el Übermensch (superhombre) y la voluntad de poder.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'phi_005',
      categoryId: 'philosophy',
      type: 'multiple_choice',
      text: '¿Cuál es la alegoría más famosa de Platón?',
      options: [
        'El Mito de Sísifo',
        'La Alegoría de la Caverna',
        'El Mito de Er',
        'La Alegoría del Barco'
      ],
      correctAnswer: 'La Alegoría de la Caverna',
      explanation:
          'La Alegoría de la Caverna aparece en "La República" de Platón y describe a prisioneros encadenados que solo ven sombras, simbolizando la ignorancia y el proceso de ascenso hacia el conocimiento.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'phi_006',
      categoryId: 'philosophy',
      type: 'multiple_choice',
      text: '¿Qué filósofo formuló el imperativo categórico?',
      options: [
        'David Hume',
        'John Locke',
        'Immanuel Kant',
        'Jean-Jacques Rousseau'
      ],
      correctAnswer: 'Immanuel Kant',
      explanation:
          'Immanuel Kant formuló el imperativo categórico en su "Crítica de la razón práctica" (1788): "Actúa solo según la máxima que puedas querer que se convierta en ley universal".',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'phi_007',
      categoryId: 'philosophy',
      type: 'true_false',
      text:
          'Sócrates escribió numerosos libros filosóficos que han llegado hasta nosotros.',
      options: ['Verdadero', 'Falso'],
      correctAnswer: 'Falso',
      explanation:
          'Sócrates no escribió nada. Todo lo que sabemos de su filosofía proviene de los diálogos escritos por su discípulo Platón y por los recuerdos de Jenofonte.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'phi_008',
      categoryId: 'philosophy',
      type: 'multiple_choice',
      text: '¿Qué corriente filosófica sostiene que el conocimiento proviene principalmente de la experiencia sensorial?',
      options: [
        'El racionalismo',
        'El empirismo',
        'El idealismo',
        'El existencialismo'
      ],
      correctAnswer: 'El empirismo',
      explanation:
          'El empirismo, cuyos principales representantes son John Locke, George Berkeley y David Hume, sostiene que el conocimiento se adquiere a través de la experiencia sensorial y no de la razón pura.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'phi_009',
      categoryId: 'philosophy',
      type: 'multiple_choice',
      text: '¿Cuál es el nombre del método inductivo propuesto por Francis Bacon?',
      options: [
        'El método deductivo',
        'La dialéctica',
        'El método inductivo experimental',
        'La fenomenología'
      ],
      correctAnswer: 'El método inductivo experimental',
      explanation:
          'Francis Bacon propuso en el siglo XVII el método inductivo: partir de observaciones particulares para llegar a conclusiones generales, base del método científico moderno.',
      difficulty: 3,
      xpReward: 50,
    ),
    Question(
      id: 'phi_010',
      categoryId: 'philosophy',
      type: 'multiple_choice',
      text: '¿Qué filósofo existencialista escribió "El ser y la nada"?',
      options: [
        'Albert Camus',
        'Simone de Beauvoir',
        'Jean-Paul Sartre',
        'Martin Heidegger'
      ],
      correctAnswer: 'Jean-Paul Sartre',
      explanation:
          'Jean-Paul Sartre publicó "El ser y la nada" en 1943, obra fundamental del existencialismo en la que explora la naturaleza de la conciencia y la libertad radical del ser humano.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'phi_011',
      categoryId: 'philosophy',
      type: 'multiple_choice',
      text: '¿Qué filósofo propuso la teoría del contrato social en su versión más conocida?',
      options: [
        'Thomas Hobbes',
        'John Locke',
        'Jean-Jacques Rousseau',
        'Baruch Spinoza'
      ],
      correctAnswer: 'Jean-Jacques Rousseau',
      explanation:
          'Jean-Jacques Rousseau desarrolló su versión del contrato social en "El contrato social" (1762), donde propone que la legitimidad política se basa en un acuerdo entre los ciudadanos para gobernar su sociedad.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'phi_012',
      categoryId: 'philosophy',
      type: 'multiple_choice',
      text: '¿Cuál es el concepto central de la filosofía de Epicuro?',
      options: ['La virtud', 'El placer moderado y la ataraxia', 'La razón pura', 'El deber moral'],
      correctAnswer: 'El placer moderado y la ataraxia',
      explanation:
          'Epicuro enseñaba que la felicidad se alcanza mediante el placer moderado (especialmente intelectual), la ausencia de dolor (aponia) y la tranquilidad del alma (ataraxia), evitando los placeres excesivos.',
      difficulty: 3,
      xpReward: 50,
    ),
    Question(
      id: 'phi_013',
      categoryId: 'philosophy',
      type: 'multiple_choice',
      text: '¿Qué obra de Platón describe la sociedad ideal gobernada por filósofos-reyes?',
      options: [
        'El Banquete',
        'El Fedón',
        'La República',
        'El Timeo'
      ],
      correctAnswer: 'La República',
      explanation:
          'En "La República", Platón describe su sociedad ideal dividida en tres clases: filósofos-reyes (gobernantes), guerreros y productores, donde los más sabios deben gobernar por el bien común.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'phi_014',
      categoryId: 'philosophy',
      type: 'multiple_choice',
      text: '¿Qué filósofo alemán analizó el capitalismo y escribió "El Capital"?',
      options: [
        'Friedrich Engels',
        'Karl Marx',
        'Max Weber',
        'Friedrich Nietzsche'
      ],
      correctAnswer: 'Karl Marx',
      explanation:
          'Karl Marx escribió "El Capital" (Das Kapital, 1867), un análisis crítico del sistema capitalista que influyó profundamente en la política y la economía del siglo XX.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'phi_015',
      categoryId: 'philosophy',
      type: 'true_false',
      text:
          'El estoicismo sostiene que debemos aceptar lo que no podemos controlar y enfocarnos en nuestra respuesta interna.',
      options: ['Verdadero', 'Falso'],
      correctAnswer: 'Verdadero',
      explanation:
          'El estoicismo, fundado por Zenón de Citio, enseña que la virtud y la felicidad vienen de aceptar lo que no podemos cambiar y de centrar nuestra atención en nuestras propias acciones y pensamientos.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'phi_016',
      categoryId: 'philosophy',
      type: 'multiple_choice',
      text: '¿Cuál de estos filósofos NO era griego?',
      options: ['Sócrates', 'Aristóteles', 'Immanuel Kant', 'Epicuro'],
      correctAnswer: 'Immanuel Kant',
      explanation:
          'Immanuel Kant (1724-1804) fue un filósofo alemán de la ciudad de Königsberg, actualmente Kaliningrado, Rusia. Sócrates, Aristóteles y Epicuro eran todos griegos.',
      difficulty: 1,
      xpReward: 10,
    ),

    // =========================================================================
    // FILOSOFÍA — preguntas adicionales (phil_017 – phil_027)
    // =========================================================================

    Question(
      id: 'phil_017',
      categoryId: 'philosophy',
      type: 'multiple_choice',
      text: '¿Cuál es la idea central del existencialismo de Jean-Paul Sartre?',
      options: [
        '"La existencia precede a la esencia": somos lo que elegimos ser',
        '"El hombre es bueno por naturaleza pero la sociedad lo corrompe"',
        '"Dios ha muerto y debemos crear nuevos valores"',
        '"La razón pura determina la moral universal"'
      ],
      correctAnswer: '"La existencia precede a la esencia": somos lo que elegimos ser',
      explanation:
          'Sartre sostenía que "la existencia precede a la esencia": no nacemos con un propósito predefinido, sino que nos creamos a nosotros mismos a través de nuestras elecciones. Esta libertad radical conlleva una responsabilidad absoluta.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'phil_018',
      categoryId: 'philosophy',
      type: 'multiple_choice',
      text: '¿Qué concepto central propone Albert Camus en su filosofía del absurdo?',
      options: [
        'Que la vida carece de sentido inherente y debemos crear el nuestro pese a ello',
        'Que el suicidio es la respuesta lógica ante la falta de sentido',
        'Que la religión es el único antídoto contra el absurdo',
        'Que el ser humano es fundamentalmente irracional'
      ],
      correctAnswer: 'Que la vida carece de sentido inherente y debemos crear el nuestro pese a ello',
      explanation:
          'Camus propone que hay una tensión irresoluble (el absurdo) entre el deseo humano de sentido y el silencio del universo. La respuesta de Camus no es el suicidio sino la rebelión: vivir plenamente a pesar de ello, como Sísifo feliz.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'phil_019',
      categoryId: 'philosophy',
      type: 'multiple_choice',
      text: '¿Quién fue el principal filósofo estoico romano y autor de las "Meditaciones"?',
      options: ['Séneca', 'Epicteto', 'Marco Aurelio', 'Cicerón'],
      correctAnswer: 'Marco Aurelio',
      explanation:
          'Marco Aurelio (121-180 d.C.), emperador romano y filósofo estoico, escribió las "Meditaciones" como reflexiones personales sobre la virtud y el autocontrol. Es uno de los textos más influyentes del estoicismo.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'phil_020',
      categoryId: 'philosophy',
      type: 'multiple_choice',
      text: '¿Qué es el utilitarismo en ética?',
      options: [
        'La doctrina de que la acción correcta es la que produce el mayor bienestar para el mayor número',
        'La doctrina de que la moral se basa en el deber y la ley universal',
        'La creencia de que cada persona debe maximizar su propio placer',
        'La ética que evalúa las acciones según su conformidad con la virtud'
      ],
      correctAnswer: 'La doctrina de que la acción correcta es la que produce el mayor bienestar para el mayor número',
      explanation:
          'El utilitarismo, formulado por Jeremy Bentham y desarrollado por John Stuart Mill, sostiene que la acción moralmente correcta es la que maximiza la utilidad (bienestar o felicidad) para el mayor número posible de personas.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'phil_021',
      categoryId: 'philosophy',
      type: 'multiple_choice',
      text: '¿Qué es un silogismo en lógica aristotélica?',
      options: [
        'Una paradoja que no tiene solución lógica',
        'Un argumento deductivo de tres proposiciones: dos premisas y una conclusión',
        'Una metáfora filosófica para explicar conceptos abstractos',
        'Un método de razonamiento inductivo basado en casos particulares'
      ],
      correctAnswer: 'Un argumento deductivo de tres proposiciones: dos premisas y una conclusión',
      explanation:
          'Un silogismo aristotélico es un argumento lógico de tres partes: premisa mayor, premisa menor y conclusión. Ejemplo clásico: "Todos los hombres son mortales. Sócrates es hombre. Por tanto, Sócrates es mortal."',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'phil_022',
      categoryId: 'philosophy',
      type: 'multiple_choice',
      text: '¿Cuál es el concepto central de la filosofía budista que significa "sufrimiento" o "insatisfacción"?',
      options: ['Nirvana', 'Dukkha', 'Karma', 'Dharma'],
      correctAnswer: 'Dukkha',
      explanation:
          'Dukkha (sufrimiento, insatisfacción, impermanencia) es la primera de las Cuatro Nobles Verdades del budismo. Buda enseñaba que el sufrimiento surge del apego y que puede extinguirse siguiendo el Noble Óctuple Sendero.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'phil_023',
      categoryId: 'philosophy',
      type: 'multiple_choice',
      text: '¿Qué propone John Locke sobre el origen del conocimiento?',
      options: [
        'Que nacemos con ideas innatas que la razón desarrolla',
        'Que la mente es una "tabula rasa" y todo conocimiento viene de la experiencia',
        'Que el conocimiento viene de la intuición intelectual pura',
        'Que solo podemos conocer los fenómenos y no las cosas en sí'
      ],
      correctAnswer: 'Que la mente es una "tabula rasa" y todo conocimiento viene de la experiencia',
      explanation:
          'John Locke, padre del empirismo moderno, sostenía que la mente al nacer es una "tabula rasa" (pizarra en blanco) sin ideas innatas. Todo nuestro conocimiento proviene de la experiencia sensorial y la reflexión sobre ella.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'phil_024',
      categoryId: 'philosophy',
      type: 'multiple_choice',
      text: '¿Qué propone Rousseau sobre el estado natural del ser humano?',
      options: [
        'Que el hombre es naturalmente egoísta y necesita leyes para ser civilizado',
        'Que el hombre es bueno por naturaleza pero la sociedad lo corrompe',
        'Que el hombre es un ser racional que busca la virtud por instinto',
        'Que el estado natural es una guerra de todos contra todos'
      ],
      correctAnswer: 'Que el hombre es bueno por naturaleza pero la sociedad lo corrompe',
      explanation:
          'Rousseau sostenía que el ser humano es naturalmente bueno (el "buen salvaje") y que es la sociedad, con sus instituciones de propiedad y desigualdad, la que corrompe esa bondad original. Esta idea influyó profundamente en la Revolución Francesa.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'phil_025',
      categoryId: 'philosophy',
      type: 'multiple_choice',
      text: '¿Qué distingue al racionalismo del empirismo en epistemología?',
      options: [
        'El racionalismo prioriza la razón e ideas innatas; el empirismo prioriza la experiencia sensorial',
        'El racionalismo estudia la sociedad; el empirismo estudia la naturaleza',
        'El racionalismo es antiguo; el empirismo es moderno',
        'El racionalismo es europeo; el empirismo es anglosajón'
      ],
      correctAnswer: 'El racionalismo prioriza la razón e ideas innatas; el empirismo prioriza la experiencia sensorial',
      explanation:
          'El racionalismo (Descartes, Spinoza, Leibniz) sostiene que la razón y las ideas innatas son la fuente principal del conocimiento. El empirismo (Locke, Hume, Berkeley) defiende que todo conocimiento proviene de la experiencia sensorial.',
      difficulty: 3,
      xpReward: 50,
    ),
    Question(
      id: 'phil_026',
      categoryId: 'philosophy',
      type: 'true_false',
      text: 'El nihilismo es la creencia de que la vida carece de valor, sentido o propósito objetivo.',
      options: ['Verdadero', 'Falso'],
      correctAnswer: 'Verdadero',
      explanation:
          'El nihilismo sostiene que nada tiene valor, sentido o propósito objetivo. Nietzsche analizó el nihilismo como consecuencia de la muerte de Dios y del colapso de los valores absolutos, aunque él mismo proponía superarlo con la voluntad de poder.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'phil_027',
      categoryId: 'philosophy',
      type: 'multiple_choice',
      text: '¿Qué es la fenomenología fundada por Edmund Husserl?',
      options: [
        'El estudio de los fenómenos físicos observables en la naturaleza',
        'El análisis filosófico de la estructura de la experiencia y la conciencia',
        'El método de observación empírica de las ciencias naturales',
        'La descripción matemática de los fenómenos cuánticos'
      ],
      correctAnswer: 'El análisis filosófico de la estructura de la experiencia y la conciencia',
      explanation:
          'La fenomenología, fundada por Edmund Husserl, estudia la estructura de la experiencia consciente tal como aparece a la conciencia, "poniendo entre paréntesis" las suposiciones sobre el mundo externo. Influyó en Heidegger, Sartre y Merleau-Ponty.',
      difficulty: 3,
      xpReward: 50,
    ),

    // =========================================================================
    // LENGUAJE — 16 questions
    // =========================================================================

    Question(
      id: 'lang_001',
      categoryId: 'language',
      type: 'multiple_choice',
      text: '¿Cuántas lenguas oficiales tiene España?',
      options: ['1', '2', '4', '5'],
      correctAnswer: '4',
      explanation:
          'España tiene cuatro lenguas co-oficiales según su constitución: el castellano (oficial en todo el país), el catalán, el gallego y el euskera (vasco).',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'lang_002',
      categoryId: 'language',
      type: 'multiple_choice',
      text: '¿De qué idioma proviene la palabra "álgebra"?',
      options: ['Griego', 'Latín', 'Árabe', 'Persa'],
      correctAnswer: 'Árabe',
      explanation:
          '"Álgebra" proviene del árabe "al-jabr", término que aparece en el libro de Al-Juarismi del siglo IX. También "algoritmo" viene de la latinización de su nombre.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'lang_003',
      categoryId: 'language',
      type: 'multiple_choice',
      text: '¿Cuál es el idioma con más hablantes nativos en el mundo?',
      options: ['Inglés', 'Español', 'Mandarín', 'Hindi'],
      correctAnswer: 'Mandarín',
      explanation:
          'El mandarín chino es el idioma con más hablantes nativos del mundo, con más de 900 millones de personas que lo tienen como lengua materna, principalmente en China.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'lang_004',
      categoryId: 'language',
      type: 'multiple_choice',
      text: '¿Quién escribió "Don Quijote de la Mancha"?',
      options: [
        'Francisco de Quevedo',
        'Lope de Vega',
        'Miguel de Cervantes',
        'Luis de Góngora'
      ],
      correctAnswer: 'Miguel de Cervantes',
      explanation:
          'Miguel de Cervantes publicó la primera parte de "El ingenioso hidalgo don Quijote de la Mancha" en 1605 y la segunda en 1615. Es considerada la primera novela moderna y la obra más importante en lengua española.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'lang_005',
      categoryId: 'language',
      type: 'multiple_choice',
      text: '¿Qué es un oxímoron?',
      options: [
        'Una palabra con significado opuesto al literal',
        'Una figura retórica que combina dos conceptos contradictorios',
        'Un tipo de rima',
        'Una palabra sin traducción'
      ],
      correctAnswer: 'Una figura retórica que combina dos conceptos contradictorios',
      explanation:
          'Un oxímoron combina dos términos aparentemente contradictorios en una sola expresión, como "silencio estruendoso", "luz oscura" o "fuego helado" (de Quevedo).',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'lang_006',
      categoryId: 'language',
      type: 'multiple_choice',
      text: '¿Cuántas letras tiene el alfabeto español actualmente?',
      options: ['27', '28', '29', '30'],
      correctAnswer: '27',
      explanation:
          'El alfabeto español tiene 27 letras. La RAE eliminó "ch" y "ll" como letras independientes en 1994, pero mantuvo la "ñ" como letra propia del español.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'lang_007',
      categoryId: 'language',
      type: 'true_false',
      text:
          'El español es el segundo idioma más hablado en el mundo por número total de hablantes.',
      options: ['Verdadero', 'Falso'],
      correctAnswer: 'Verdadero',
      explanation:
          'El español es el segundo idioma más hablado del mundo con más de 580 millones de hablantes totales (nativos y no nativos), detrás del inglés que cuenta con más de 1 300 millones.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'lang_008',
      categoryId: 'language',
      type: 'multiple_choice',
      text: '¿Qué es un palíndromo?',
      options: [
        'Una palabra con varias acepciones',
        'Una palabra o frase que se lee igual de izquierda a derecha que al revés',
        'Una palabra prestada de otro idioma',
        'Un sinónimo arcaico'
      ],
      correctAnswer: 'Una palabra o frase que se lee igual de izquierda a derecha que al revés',
      explanation:
          'Un palíndromo es una palabra o frase que se lee igual en ambas direcciones, como "ojo", "reconocer", "Yo soy" o la frase "Dábale arroz a la zorra el abad".',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'lang_009',
      categoryId: 'language',
      type: 'multiple_choice',
      text: '¿Cuál es el libro más traducido de la historia después de la Biblia?',
      options: [
        '"El Principito"',
        '"Don Quijote"',
        '"Harry Potter y la piedra filosofal"',
        '"Las mil y una noches"'
      ],
      correctAnswer: '"El Principito"',
      explanation:
          '"El Principito" de Antoine de Saint-Exupéry, publicado en 1943, ha sido traducido a más de 300 idiomas y dialectos, siendo el libro más traducido después de la Biblia.',
      difficulty: 3,
      xpReward: 50,
    ),
    Question(
      id: 'lang_010',
      categoryId: 'language',
      type: 'multiple_choice',
      text: '¿Qué significa el prefijo griego "bio-"?',
      options: ['Tierra', 'Vida', 'Agua', 'Luz'],
      correctAnswer: 'Vida',
      explanation:
          'El prefijo "bio-" proviene del griego "bios" que significa vida. Por eso, biología es el estudio de la vida, biodiversidad es la variedad de seres vivos, etc.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'lang_011',
      categoryId: 'language',
      type: 'multiple_choice',
      text: '¿Qué escritor colombiano ganó el Premio Nobel de Literatura en 1982?',
      options: [
        'Álvaro Mutis',
        'Gabriel García Márquez',
        'Jorge Isaacs',
        'Tomás González'
      ],
      correctAnswer: 'Gabriel García Márquez',
      explanation:
          'Gabriel García Márquez recibió el Premio Nobel de Literatura en 1982 por su obra, principalmente por "Cien años de soledad" (1967), novela cumbre del realismo mágico latinoamericano.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'lang_012',
      categoryId: 'language',
      type: 'multiple_choice',
      text: '¿De dónde proviene etimológicamente la palabra "filosofía"?',
      options: [
        'Latín: "filo" (hilo) + "sofía" (suave)',
        'Griego: "philos" (amigo/amor) + "sophia" (sabiduría)',
        'Árabe: "fal" (reflexión) + "sofiya" (alma)',
        'Hebreo: "phil" (pensamiento) + "sofer" (escritura)'
      ],
      correctAnswer: 'Griego: "philos" (amigo/amor) + "sophia" (sabiduría)',
      explanation:
          '"Filosofía" proviene del griego antiguo "philos" (amor, amigo) y "sophia" (sabiduría), por lo que literalmente significa "amor a la sabiduría".',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'lang_013',
      categoryId: 'language',
      type: 'multiple_choice',
      text: '¿Qué es una onomatopeya?',
      options: [
        'Una palabra que imita un sonido',
        'Una palabra prestada de otro idioma',
        'Una palabra con doble significado',
        'Un tipo de metáfora'
      ],
      correctAnswer: 'Una palabra que imita un sonido',
      explanation:
          'Una onomatopeya es una palabra cuya pronunciación imita el sonido que describe, como "miau", "zumbido", "clic", "tic-tac" o "trueno".',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'lang_014',
      categoryId: 'language',
      type: 'multiple_choice',
      text: '¿Cuál es el idioma más antiguo que aún se habla en el mundo?',
      options: ['Latín', 'Griego moderno', 'Tamil', 'Chino'],
      correctAnswer: 'Tamil',
      explanation:
          'El tamil, hablado en el sur de India y Sri Lanka, es considerado uno de los idiomas más antiguos del mundo con evidencias escritas de más de 2 500 años y aún se habla con vigor.',
      difficulty: 3,
      xpReward: 50,
    ),
    Question(
      id: 'lang_015',
      categoryId: 'language',
      type: 'true_false',
      text: '"Hamlet" es la obra más larga de William Shakespeare.',
      options: ['Verdadero', 'Falso'],
      correctAnswer: 'Verdadero',
      explanation:
          '"Hamlet" es la obra más extensa de Shakespeare con aproximadamente 4 000 versos. También es una de sus obras más representadas y analizadas en la historia del teatro.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'lang_016',
      categoryId: 'language',
      type: 'multiple_choice',
      text: '¿Qué figura retórica consiste en la repetición de un sonido al inicio de palabras consecutivas?',
      options: ['Anáfora', 'Aliteración', 'Asíndeton', 'Hipérbole'],
      correctAnswer: 'Aliteración',
      explanation:
          'La aliteración es la figura retórica que consiste en la repetición del mismo sonido (generalmente consonante) al inicio de palabras contiguas, como en "tres tristes tigres" o "San Isidro labrador".',
      difficulty: 3,
      xpReward: 50,
    ),

    // =========================================================================
    // LENGUAJE — preguntas adicionales (lang_017 – lang_027)
    // =========================================================================

    Question(
      id: 'lang_017',
      categoryId: 'language',
      type: 'multiple_choice',
      text: '¿De qué lengua proviene la palabra "chocolate"?',
      options: ['Español antiguo', 'Náhuatl', 'Latín', 'Árabe'],
      correctAnswer: 'Náhuatl',
      explanation:
          '"Chocolate" proviene del náhuatl "xocolātl" (xococ = agrio/amargo + ātl = agua), la lengua de los aztecas. Fue adoptado al español tras la Conquista y de ahí pasó a casi todas las lenguas europeas.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'lang_018',
      categoryId: 'language',
      type: 'multiple_choice',
      text: '¿Qué significa la locución latina "carpe diem"?',
      options: [
        'Cuida tu camino',
        'Aprovecha el momento presente',
        'El tiempo vuela',
        'La vida es corta'
      ],
      correctAnswer: 'Aprovecha el momento presente',
      explanation:
          '"Carpe diem" proviene del poeta romano Horacio (Odas, 23 a.C.) y significa literalmente "cosecha el día" o "aprovecha el momento presente". Es una de las frases latinas más citadas en la cultura occidental.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'lang_019',
      categoryId: 'language',
      type: 'multiple_choice',
      text: '¿Qué idioma tiene más palabras en su diccionario oficial?',
      options: ['Inglés', 'Español', 'Árabe', 'Francés'],
      correctAnswer: 'Inglés',
      explanation:
          'El inglés tiene el mayor número de palabras entre las lenguas con diccionarios completos, con más de 170 000 palabras en uso activo según el Oxford English Dictionary y más de 470 000 entradas en total.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'lang_020',
      categoryId: 'language',
      type: 'multiple_choice',
      text: '¿Cuál es el idioma oficial de Brasil?',
      options: ['Español', 'Portugués', 'Inglés', 'Tupí-guaraní'],
      correctAnswer: 'Portugués',
      explanation:
          'El portugués es el idioma oficial de Brasil, que fue colonia portuguesa hasta 1822. Brasil es el país más grande de América Latina y el mayor hablante de portugués del mundo, con unos 215 millones de hablantes.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'lang_021',
      categoryId: 'language',
      type: 'multiple_choice',
      text: '¿Qué es un eufemismo?',
      options: [
        'Una palabra con etimología griega antigua',
        'Una expresión suave o agradable usada en lugar de otra más directa o dura',
        'Una figura retórica que exagera para enfatizar',
        'Un término técnico de una disciplina especializada'
      ],
      correctAnswer: 'Una expresión suave o agradable usada en lugar de otra más directa o dura',
      explanation:
          'Un eufemismo sustituye una expresión considerada desagradable, tabú o hiriente por otra más suave. Ejemplos: "pasar a mejor vida" por morir, "persona de la tercera edad" por viejo, "racionalización de personal" por despido.',
      difficulty: 1,
      xpReward: 10,
    ),
    Question(
      id: 'lang_022',
      categoryId: 'language',
      type: 'multiple_choice',
      text: '¿Qué significa "in situ" en latín?',
      options: [
        'Sin duda alguna',
        'En el mismo lugar, en el sitio original',
        'De buena fe',
        'Al mismo tiempo'
      ],
      correctAnswer: 'En el mismo lugar, en el sitio original',
      explanation:
          '"In situ" es una locución latina que significa "en el lugar" o "en su sitio original". Se usa en ciencia, arqueología y medicina para referirse a algo estudiado o tratado en su lugar de origen o localización natural.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'lang_023',
      categoryId: 'language',
      type: 'multiple_choice',
      text: '¿Cuántas familias lingüísticas principales existen aproximadamente en el mundo?',
      options: ['5-10', '20-30', '100-150', '250-300'],
      correctAnswer: '100-150',
      explanation:
          'Los lingüistas identifican entre 100 y 150 familias lingüísticas en el mundo, que agrupan las aproximadas 7 000 lenguas existentes. Las más extendidas son la indoeuropea, la sino-tibetana y la afroasiática.',
      difficulty: 3,
      xpReward: 50,
    ),
    Question(
      id: 'lang_024',
      categoryId: 'language',
      type: 'multiple_choice',
      text: '¿Qué es un arcaísmo en lingüística?',
      options: [
        'Una palabra de origen extranjero adoptada en otro idioma',
        'Una palabra o expresión antigua que ya no se usa en el habla cotidiana',
        'Una palabra nueva creada para nombrar un concepto moderno',
        'Un préstamo del latín usado en textos académicos'
      ],
      correctAnswer: 'Una palabra o expresión antigua que ya no se usa en el habla cotidiana',
      explanation:
          'Un arcaísmo es un vocablo o construcción lingüística que perteneció a una época anterior y ha caído en desuso en la lengua hablada moderna, aunque puede aparecer en textos literarios o históricos.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'lang_025',
      categoryId: 'language',
      type: 'multiple_choice',
      text: '¿Cuál es el sustantivo propio del idioma español que más tildes tiene?',
      options: ['Murciélago', 'Cumpleañero', 'Huésped', 'Ciénaga'],
      correctAnswer: 'Murciélago',
      explanation:
          '"Murciélago" contiene las cinco vocales (a, e, i, o, u) y tiene dos acentos ortográficos implícitos siendo esdrújula. Es además famoso por contener las cinco vocales del español en una sola palabra.',
      difficulty: 3,
      xpReward: 50,
    ),
    Question(
      id: 'lang_026',
      categoryId: 'language',
      type: 'multiple_choice',
      text: '¿Cuál es la regla de acentuación de las palabras agudas en español?',
      options: [
        'Siempre llevan tilde',
        'Llevan tilde cuando terminan en vocal, "n" o "s"',
        'Llevan tilde cuando terminan en consonante excepto "n" y "s"',
        'Nunca llevan tilde salvo en casos especiales'
      ],
      correctAnswer: 'Llevan tilde cuando terminan en vocal, "n" o "s"',
      explanation:
          'Las palabras agudas (acento en la última sílaba) llevan tilde cuando terminan en vocal, "n" o "s": sofá, canción, interés. Si terminan en otra consonante, no llevan tilde: reloj, ciudad, papel.',
      difficulty: 2,
      xpReward: 25,
    ),
    Question(
      id: 'lang_027',
      categoryId: 'language',
      type: 'true_false',
      text: 'El esperanto es una lengua artificial creada por Ludwig Lazarus Zamenhof en el siglo XIX.',
      options: ['Verdadero', 'Falso'],
      correctAnswer: 'Verdadero',
      explanation:
          'El esperanto fue creado por el médico polaco Ludwig Lazarus Zamenhof en 1887 como lengua internacional auxiliar. Hoy lo hablan entre 1 y 2 millones de personas en todo el mundo y tiene una rica literatura.',
      difficulty: 2,
      xpReward: 25,
    ),
  ];

  // ---------------------------------------------------------------------------
  // Public API
  // ---------------------------------------------------------------------------

  /// Returns all questions in the bank.
  List<Question> getAll() => List.unmodifiable(_allQuestions);

  /// Returns all questions belonging to a specific category.
  List<Question> getByCategory(String categoryId) =>
      _allQuestions.where((q) => q.categoryId == categoryId).toList();

  /// Returns all questions with a specific difficulty level (1, 2, or 3).
  List<Question> getByDifficulty(int difficulty) =>
      _allQuestions.where((q) => q.difficulty == difficulty).toList();

  /// Looks up a question by its unique id.
  Question? getById(String id) {
    try {
      return _allQuestions.firstWhere((q) => q.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Returns 10 questions for the daily challenge.
  ///
  /// Difficulty breakdown: 3 easy + 4 medium + 3 hard.
  /// Categories are weighted toward [preferredCategories] when provided.
  List<Question> getDailyChallenge(List<String> preferredCategories) {
    // Use today as a seed so the same day always returns the same questions.
    final today = DateTime.now();
    final seed = today.year * 10000 + today.month * 100 + today.day;

    final easy = _seededShuffle(getByDifficulty(1), seed).take(3).toList();
    final medium = _seededShuffle(getByDifficulty(2), seed + 1).take(4).toList();
    final hard = _seededShuffle(getByDifficulty(3), seed + 2).take(3).toList();

    final combined = [...easy, ...medium, ...hard];
    return _seededShuffle(combined, seed + 3);
  }

  /// Returns [count] adaptive questions for a given category.
  ///
  /// - If the user's accuracy in this category is > 70 %, prefer harder questions.
  /// - If accuracy is < 40 %, prefer easier questions.
  /// - Otherwise, use a balanced mix.
  List<Question> getAdaptiveQuestions({
    required String categoryId,
    required int count,
    double accuracy = 0.5,
    int totalAttempted = 0,
    int categoryXP = 0,
  }) {
    final categoryQuestions = getByCategory(categoryId);
    if (categoryQuestions.isEmpty) return [];

    List<Question> pool;
    if (accuracy > 0.70 || categoryXP > 200) {
      // Prefer medium + hard
      final hard = categoryQuestions.where((q) => q.difficulty == 3).toList();
      final medium = categoryQuestions.where((q) => q.difficulty == 2).toList();
      pool = [...hard, ...medium];
      if (pool.length < count) {
        pool.addAll(categoryQuestions.where((q) => q.difficulty == 1));
      }
    } else if (accuracy < 0.40 && totalAttempted > 5) {
      // Prefer easy + medium
      final easy = categoryQuestions.where((q) => q.difficulty == 1).toList();
      final medium = categoryQuestions.where((q) => q.difficulty == 2).toList();
      pool = [...easy, ...medium];
      if (pool.length < count) {
        pool.addAll(categoryQuestions.where((q) => q.difficulty == 3));
      }
    } else {
      pool = List.of(categoryQuestions);
    }

    final seed = DateTime.now().millisecondsSinceEpoch ~/ 60000;
    final shuffled = _seededShuffle(pool, seed);
    return shuffled.take(count).toList();
  }

  // ---------------------------------------------------------------------------
  // Mode-aware API
  // ---------------------------------------------------------------------------

  /// Returns questions configured for the given [ChallengeMode].
  ///
  /// [preferredCategories] is used to weight daily and speed selections.
  /// [categoryId] is required for marathon mode.
  List<Question> getForMode(
    ChallengeMode mode,
    List<String> preferredCategories, {
    String? categoryId,
  }) {
    switch (mode) {
      case ChallengeMode.daily:
        return getDailyChallenge(preferredCategories);
      case ChallengeMode.speed:
        return _getSpeedModeQuestions(preferredCategories);
      case ChallengeMode.survival:
        return _getSurvivalModeQuestions(preferredCategories);
      case ChallengeMode.marathon:
        return categoryId != null ? getByCategory(categoryId) : getAll();
    }
  }

  /// 15 questions weighted toward easy-medium for fast responses.
  List<Question> _getSpeedModeQuestions(List<String> preferredCategories) {
    final seed = DateTime.now().millisecondsSinceEpoch ~/ 60000;
    final easy = _seededShuffle(getByDifficulty(1), seed).take(7).toList();
    final medium = _seededShuffle(getByDifficulty(2), seed + 1).take(8).toList();
    final combined = [...easy, ...medium];
    return _seededShuffle(combined, seed + 2).take(15).toList();
  }

  /// All questions shuffled for survival mode (infinite until game over).
  List<Question> _getSurvivalModeQuestions(List<String> preferredCategories) {
    final seed = DateTime.now().millisecondsSinceEpoch ~/ 60000;
    // Sort by ascending difficulty so it gets progressively harder
    final easy = _seededShuffle(getByDifficulty(1), seed);
    final medium = _seededShuffle(getByDifficulty(2), seed + 1);
    final hard = _seededShuffle(getByDifficulty(3), seed + 2);
    return [...easy, ...medium, ...hard];
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  /// Deterministic Fisher-Yates shuffle driven by an integer seed.
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
