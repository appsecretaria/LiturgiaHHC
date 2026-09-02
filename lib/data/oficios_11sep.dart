import '../models/oficio.dart';
import 'salterio/laudes_viernes_iii.dart';
import 'salterio/visperas_viernes_iii.dart';

const Oficio laudesSanJuanGabrielPerboyre11Sep = Oficio(
  fecha: '11 de septiembre',
  titulo: 'Laudes',

  himnoLiturgico: '''
Fiel testigo de la Iglesia,
que la gracia y Salvación,
que al oriente misterioso
prodigaste con amor;
eres imagen de Cristo,
tu modelo y galardón.
Hoy tu gloria proclamamos,
e imploramos tu favor.

Ángel puro de inocencia,
de candor y sencillez:
fue tu gozo y fortaleza
el sentido de la fe.
Haz que ardamos en tu celo
fervoroso, Juan Gabriel;
que afrontemos todo riesgo
por Jesús y como él.

En remotas lejanías,
de tinieblas y dolor,
noble apóstol fue tu guía,
el ejemplo del Pastor:
al partirles pan y abrigo
a los pobres del Señor,
ver a Cristo en el hermano
y entregarle el corazón.

Copia trágica y divina
del suplicio de Jesús,
haz que gastemos la vida
para la eterna salud.
Dulce mártir generoso,
torturado en bella cruz;
ruega a Cristo por nosotros
desde tu gloria de luz.
''',

  // SALMODIA
  antifona1: 'Contra ti, contra ti solo pequé, Señor; ten misericordia de mí.',

  salmo1Titulo: 'Salmo 50',
  salmo1Referencia: null,
  salmo1Subtitulo: 'Confesión del pecador arrepentido',
  salmo1: salmo50ViernesIII,

  antifona2: 'Reconocemos, Señor, nuestra impiedad; hemos pecado contra ti.',

  salmo2Titulo: 'Cántico',
  salmo2Referencia: 'Jr 14, 17-21',
  salmo2Subtitulo: 'Lamentación del pueblo en tiempo de hambre y de guerra',
  salmo2: canticoJeremias14ViernesIII,

  rubricaSalmo2: null,

  antifona3:
      'El Señor es Dios y nosotros somos su pueblo y ovejas de su rebaño.',

  salmo3Titulo: 'Salmo 99',
  salmo3Referencia: null,
  salmo3Subtitulo: 'Alegría de los que entran en el templo',
  salmo3: salmo99ViernesIII,

  // LECTURA BREVE
  lecturaBreveTitulo: 'Lectura breve',
  lecturaBreveReferencia: '2Co 1, 3-5',
  lecturaBreve: '''¡Bendito sea Dios, Padre de nuestro Señor Jesucristo, Padre de misericordia y Dios del Consuelo! Él nos alienta en nuestras luchas hasta el punto de poder nosotros alentar a los demás en cualquier lucha, repartiendo con ellos el ánimo que nosotros recibimos de Dios. Si los sufrimientos de Cristo rebosan sobre nosotros, gracias a Cristo rebosa en proporción nuestro ánimo.''',

  // RESPONSORIO BREVE
  responsorio: '''
V/ El Señor es mi fuerza y mi poder.
R/ El Señor es mi fuerza y mi poder.

V/ Él es mi salvación.
R/ Y mi poder.

V/ Gloria al Padre, y al Hijo, y al Espíritu Santo.
R/ El Señor es mi fuerza y mi poder.
''',

  // CÁNTICO EVANGÉLICO
  antifonaCantico: 'Con gran amor ha dado la vida por el Evangelio de salvación; ha abrazado con energía la cruz de Cristo, por eso ha entrado en la gloria de su Señor.',

  canticoTitulo: 'Cántico de Zacarías',
  canticoReferencia: 'Lc 1, 68-79',
  canticoSubtitulo: 'El Mesías y su precursor',

  cantico: '''
Bendito sea el Señor, Dios de Israel,
porque ha visitado y redimido a su pueblo,
suscitándonos una fuerza de salvación
en la casa de David, su siervo,
según lo había predicho desde antiguo
por boca de sus santos profetas.

Es la salvación que nos libra de nuestros enemigos
y de la mano de todos los que nos odian;
realizando la misericordia que tuvo con nuestros padres,
recordando su santa alianza
y el juramento que juró a nuestro padre Abrahán.

Para concedernos que, libres de temor,
arrancados de la mano de los enemigos,
le sirvamos con santidad y justicia,
en su presencia, todos nuestros días.

Y a ti, niño, te llamarán profeta del Altísimo,
porque irás delante del Señor
a preparar sus caminos,
anunciando a su pueblo la salvación,
el perdón de sus pecados.

Por la entrañable misericordia de nuestro Dios,
nos visitará el sol que nace de lo alto,
para iluminar a los que viven en tinieblas
y en sombra de muerte,
para guiar nuestros pasos
por el camino de la paz.

Gloria al Padre, y al Hijo, y al Espíritu Santo.
Como era en el principio, ahora y siempre,
por los siglos de los siglos. Amén.
''',

  // PRECES
  introduccionPreces: '''San Juan Gabriel Perboyre reclama la exigencia de nuestra participación en el misterio de la cruz del Señor para proclamar su gloriosa resurrección. Aclamémosle con fe:''',

  respuestaPreces: 'Tu cruz es nuestra esperanza, Señor.',

  preces: [
    PreceOficio(
      inicio: 'Bendito seas Jesús, Salvador del mundo, que no has dudado en sufrir la pasión y la cruz por nosotros,',
      respuesta: 'y nos has redimido con tu sangre preciosa.',
    ),
    PreceOficio(
      inicio: 'Ilumina con tu presencia el inicio de nuestra jornada,',
      respuesta:
          'y haz que todo el día transcurra dedicado a trabajar por el Reino.',
    ),
    PreceOficio(
      inicio: 'Enséñanos a vivir intensamente la experiencia de tu Pasión,',
      respuesta: 'para participar, también, en tu gloriosa resurrección.',
    ),
    PreceOficio(
      inicio: 'Por tu cruz y resurrección,',
      respuesta:
          'llena nuestros corazones de la consolación del Espíritu Santo.',
    ),
    PreceOficio(
      inicio: 'Enséñanos a hacer el bien en tu nombre,',
      respuesta: 'para que la luz de la Iglesia resplandezca siempre sobre la familia humana.',
    ),
    PreceOficio(
      inicio: 'Manda operarios a tu mies,',
      respuesta: 'para que sea glorificado tu nombre entre todas las gentes.',
    ),
    PreceOficio(
      inicio: 'Enciende en nuestros corazones una sed ardiente de ti,',
      respuesta:
          'y que tu Espíritu nos una a todos en comunión de fe y de amor.',
    ),
  ],

  introduccionPadreNuestro: 'Dirijamos ahora nuestra oración al Padre que está en los cielos, diciendo:',

  oracionConclusiva: '''Señor Dios nuestro, que quisiste esclarecer a tu mártir San Juan Gabriel Perboyre con los trabajos apostólicos y la participación en la cruz de tu Hijo; haz que, siguiendo sus huellas, nos hagamos partícipes de la pasión de Cristo para que con gozo llevemos a todos la salvación. Por Jesucristo nuestro Señor.''',
);

const Oficio visperasSanJuanGabrielPerboyre11Sep = Oficio(
  fecha: '11 de septiembre',
  titulo: 'Vísperas',

  himnoLiturgico: '''
Oh Dios, que eres el premio, la corona
y la suerte de todos tus soldados,
líbranos de los lazos de las culpas
por este mártir a quien hoy cantamos.

Él conoció la hiel que está escondida
en la miel de los goces de este suelo,
y, por no haber cedido a sus encantos,
está gozando los del cielo eterno.

Él afrontó con ánimo seguro
lo que sufrió con varonil coraje,
y consiguió los celestiales dones
al derramar por ti su noble sangre.

Oh piadosísimo Señor de todo,
te suplicamos con humilde ruego
que, en el día del triunfo de este mártir,
perdones los pecados de tus siervos.

Gloria eterna al divino Jesucristo,
que nació de una Virgen impecable,
y gloria eterna al Santo Paracleto,
y gloria eterna al sempiterno Padre. Amén.
''',

  // SALMODIA
  antifona1: 'El Señor es grande, nuestro dueño más que todos los dioses.',

  salmo1Titulo: 'Salmo 134 I',
  salmo1Referencia: null,
  salmo1Subtitulo: 'Himno a Dios por sus maravillas',
  salmo1: salmo134IViernesIII,

  antifona2:
      'Casa de Israel, bendice al Señor; tañed para su nombre, que es amable.',

  salmo2Titulo: 'Salmo 134 II',
  salmo2Referencia: null,
  salmo2Subtitulo: null,
  salmo2: salmo134IIViernesIII,

  rubricaSalmo2: null,

  antifona3:
      'Vendrán todas las naciones y se postrarán en tu acatamiento, Señor.',

  salmo3Titulo: 'Cántico',
  salmo3Referencia: 'Ap 15, 3-4',
  salmo3Subtitulo: 'Canto de los vencedores',
  salmo3: canticoApocalipsis15ViernesIII,

  // LECTURA BREVE
  lecturaBreveTitulo: 'Lectura breve',
  lecturaBreveReferencia: '1Pe 3, 13-14',
  lecturaBreve: '''Queridos hermanos, estad alegres cuando compartan los padecimientos de Cristo, para que, cuando se manifieste su gloria, rebosen de gozo. Si los ultrajan por el nombre de Cristo, dichosos ustedes, porque el Espíritu de la gloria, el Espíritu de Dios, reposa sobre ustedes.''',

  // RESPONSORIO BREVE
  responsorio: '''
V/ Oh Dios, nos pusiste a prueba, pero nos has dado respiro.
R/ Oh Dios, nos pusiste a prueba, pero nos has dado respiro.

V/ Nos refinaste como refinan la plata.
R/ Pero nos has dado respiro.

V/ Gloria al Padre, y al Hijo, y al Espíritu Santo.
R/ Oh Dios, nos pusiste a prueba, pero nos has dado respiro.
''',

  // CÁNTICO EVANGÉLICO
  antifonaCantico: 'Completo en mi carne lo que le falta a los padecimientos de Cristo a favor de su cuerpo que es la Iglesia; mi gloria se encuentra en su cruz.',

  canticoTitulo: 'Cántico de María',
  canticoReferencia: 'Lc 1, 46-55',
  canticoSubtitulo: 'Alegría del alma en el Señor',

  cantico: '''
Proclama mi alma la grandeza del Señor,
se alegra mi espíritu en Dios, mi salvador;
porque ha mirado la humillación de su esclava.

Desde ahora me felicitarán todas las generaciones,
porque el Poderoso ha hecho obras grandes por mí:
su nombre es santo,
y su misericordia llega a sus fieles
de generación en generación.

Él hace proezas con su brazo:
dispersa a los soberbios de corazón,
derriba del trono a los poderosos
y enaltece a los humildes,
a los hambrientos los colma de bienes
y a los ricos los despide vacíos.

Auxilia a Israel, su siervo,
acordándose de la misericordia
—como lo había prometido a nuestros padres—
en favor de Abrahán y su descendencia por siempre.

Gloria al Padre, y al Hijo, y al Espíritu Santo.
Como era en el principio, ahora y siempre,
por los siglos de los siglos. Amén.
''',

  // PRECES
  introduccionPreces: '''Elevemos nuestra plegaria común a Dios Padre, para que la luz de la cruz y de la resurrección de Cristo ilumine a los hombres sumergidos en la tiniebla del error. Imitemos a San Juan Gabriel Perboyre, que ha unido sus sufrimientos a los de Cristo para la edificación de la Iglesia y digamos:''',

  respuestaPreces: 'Manifiesta, Señor, tu salvación.',

  preces: [
    PreceOficio(
      inicio: 'Porque nos amaste hasta el extremo, Salvador nuestro, principio y origen de todo martirio.',
      respuesta: '',
    ),
    PreceOficio(
      inicio: 'Porque no cesas de llamar a los pecadores arrepentidos para los premios de tu reino.',
      respuesta: '',
    ),
    PreceOficio(
      inicio: 'Porque has dado a la Iglesia, como sacrificio, la sangre de la alianza nueva y eterna, derramada para el perdón de los pecados.',
      respuesta: '',
    ),
    PreceOficio(
      inicio: 'Porque, con tu gracia, nos has dado perseverancia en la fe durante el día que ahora termina.',
      respuesta: '',
    ),
    PreceOficio(
      inicio: 'Porque has asociado a tu muerte a nuestros hermanos difuntos.',
      respuesta: '',
    ),
  ],

  introduccionPadreNuestro: 'Dirijamos ahora nuestra oración al Padre que está en los cielos, diciendo:',

  oracionConclusiva: '''Señor Dios nuestro, que quisiste esclarecer a tu mártir San Juan Gabriel Perboyre con los trabajos apostólicos y la participación en la cruz de tu Hijo; haz que, siguiendo sus huellas, nos hagamos partícipes de la pasión de Cristo para que con gozo llevemos a todos la salvación. Por Jesucristo nuestro Señor.''',
);
