import '../models/oficio.dart';
import 'salterio/laudes_miercoles_ii.dart';
import 'salterio/visperas_miercoles_ii.dart';

const Oficio laudesMartires2Septiembre = Oficio(
  fecha: '2 de septiembre',
  titulo: 'Laudes',

  himnoLiturgico: '''Testigos de la sangre
con sangre rubricada,
frutos de amor cortados
al golpe de la espada.

Testigos del amor
en sumisión callada,
canto y cielo en los labios
al golpe de la espada.

Testigos del dolor
de vida enamorada;
diario placer de muerte
al golpe de la espada.

Testigos del cansancio
de una vida inmolada
a golpe de Evangelio
y al golpe de la espada.

Demos gracias al Padre
por la sangre sagrada;
pidamos ser sus mártires,
y a cada madrugada
poder morir la vida
al golpe de la espada. Amén.''',

  // SALMODIA
  // La completaremos con los salmos correspondientes
  // al Salterio del día.
  antifona1: 'En medio de sus tormentos, los mártires de Cristo contemplaban la gloria del reino y decían: «Ayúdanos, Señor».',
  salmo1Titulo: 'Salmo 76',
  salmo1Referencia: null,
  salmo1Subtitulo: 'RECUERDO DEL PASADO GLORIOSO DE ISRAEL',
  salmo1: salmo76MiercolesII,

  antifona2: 'Almas y espíritus justos, cantad un himno a Dios. Aleluya.',
  salmo2Titulo: 'Cántico',
  salmo2Referencia: '1S 2, 1-10',
  salmo2Subtitulo: 'ALEGRÍA DE LOS HUMILDES EN DIOS',
  salmo2: cantico1Samuel2MiercolesII,

  antifona3: 'Mártires del Señor, alabad al Señor en el cielo.',
  salmo3Titulo: 'Salmo 96',
  salmo3Referencia: null,
  salmo3Subtitulo: 'EL SEÑOR ES UN REY MAYOR QUE TODOS LOS DIOSES',
  salmo3: salmo96MiercolesII,

  lecturaBreveTitulo: 'Lectura breve',
  lecturaBreveReferencia: '2Co 1, 3-5',
  lecturaBreve: '''Bendito sea Dios, Padre de nuestro Señor Jesucristo, Padre de misericordia y Dios de todo consuelo; él nos consuela en todas nuestras luchas, para poder nosotros consolar a los que están en toda tribulación, mediante el consuelo con que nosotros somos consolados por Dios. Porque si es cierto que los sufrimientos de Cristo rebosan sobre nosotros, también por Cristo rebosa nuestro consuelo.''',

  responsorio: '''V/ Los justos viven eternamente.
R/ Los justos viven eternamente.

V/ Reciben de Dios su recompensa.
R/ Viven eternamente.

V/ Gloria al Padre, y al Hijo, y al Espíritu Santo.
R/ Los justos viven eternamente.''',

  antifonaCantico: 'Dichosos los perseguidos por causa de la justicia, pues de ellos es el Reino de los Cielos.',

  canticoTitulo: 'Cántico de Zacarías',
  canticoReferencia: 'Lc 1, 68-79',
  canticoSubtitulo: 'EL MESÍAS Y SU PRECURSOR',

  cantico: '''Bendito sea el Señor, Dios de Israel,
porque ha visitado y redimido a su pueblo.
suscitándonos una fuerza de salvación
en la casa de David, su siervo,
según lo había predicho desde antiguo
por boca de sus santos profetas:

Es la salvación que nos libra de nuestros enemigos
y de la mano de todos los que nos odian;
ha realizado así la misericordia que tuvo con nuestros padres,
recordando su santa alianza
y el juramento que juró a nuestro padre Abraham.

Para concedernos que, libres de temor,
arrancados de la mano de los enemigos,
le sirvamos con santidad y justicia,
en su presencia, todos nuestros días.

Y a ti, niño, te llamarán Profeta del Altísimo,
porque irás delante del Señor
a preparar sus caminos,
anunciando a su pueblo la salvación,
el perdón de sus pecados.

Por la entrañable misericordia de nuestro Dios,
nos visitará el sol que nace de lo alto,
para iluminar a los que viven en tiniebla
y en sombra de muerte,
para guiar nuestros pasos
por el camino de la paz.

Gloria al Padre, y al Hijo, y al Espíritu Santo.
Como era en el principio, ahora y siempre, por los siglos de los siglos. Amén.''',

  introduccionPreces: '''Celebremos, amados hermanos, a Jesús, el testigo fiel, y al recordar hoy a los beatos mártires Luis José François y compañeros, a causa de la palabra de Dios, aclamémosle diciendo:''',

  respuestaPreces: 'Nos has comprado, Señor, con tu sangre.',

  preces: [
    PreceOficio(
      inicio: 'Por la intercesión de los beatos mártires que entregaron libremente su vida como testimonio de la fe,',
      respuesta: 'concédenos, Señor, la verdadera libertad de espíritu.',
    ),
    PreceOficio(
      inicio: 'Por la intercesión de los beatos mártires que proclamaron la fe hasta derramar su sangre,',
      respuesta: 'concédenos, Señor, la integridad y constancia de la fe.',
    ),
    PreceOficio(
      inicio: 'Por la intercesión de los beatos mártires que soportando la cruz siguieron tus pasos,',
      respuesta: 'concédenos, Señor, soportar con generosidad las contrariedades de la vida.',
    ),
    PreceOficio(
      inicio: 'Por la intercesión de los beatos mártires que blanquearon su manto en la sangre del Cordero,',
      respuesta: 'concédenos, Señor, vencer las obras del mundo y de la carne.',
    ),
  ],

  introduccionPadreNuestro: '''Dirijamos ahora nuestra oración al Padre que está en los cielos, diciendo:''',

  oracionConclusiva: '''Señor Dios nuestro, que uniste a los bienaventurados mártires Luís José François, Juan Enrique Gruyer, Nicolás Colin, Juan Carlos Carón y Pedro Renato Rogue, por el amor a tu Iglesia y los fortaleciste con invicta constancia en la proclamación de tu libertad; concédenos que los que nos alegramos en la celebración de su martirio aprendamos a amar a la Iglesia como a una madre y anunciemos siempre con evangélica firmeza la palabra de la verdad y la justicia. Por Nuestro Señor.''',
);

const Oficio visperasMartires2Sep = Oficio(
  fecha: '2 de septiembre',
  titulo: 'Vísperas',

  himnoLiturgico: '''Espíritus sublimes,
¡oh mártires gloriosos!,
felices moradores
de la inmortal Sión,
rogad por los que luchan
en las batallas recias,
que alcancen la victoria
y eterno galardón.

¡Oh mártires gloriosos
de rojas vestiduras,
que brillan con eternos
fulgores ante Dios!
Con vuestro riego crezca
de Cristo la semilla,
y el campo de las mieses
se cubra ya en sazón. Amén.''',

  antifona1: 'Los cuerpos de los santos fueron sepultados en paz, y su fama vive por generaciones.',
  salmo1Titulo: 'Salmo 61',
  salmo1Referencia: null,
  salmo1Subtitulo: 'DIOS, ÚNICA ESPERANZA DEL JUSTO',
  salmo1: salmo61MiercolesII,

  antifona2: 'Vi las almas de los degollados a causa de la Palabra de Dios y del testimonio que mantuvieron.',
  salmo2Titulo: 'Salmo 66',
  salmo2Referencia: null,
  salmo2Subtitulo: 'QUE TODOS LOS PUEBLOS ALABEN AL SEÑOR',
  salmo2: salmo66MiercolesII,

  antifona3: 'Estos son aquellos santos que entregaron sus cuerpos para ser fieles a la alianza de Dios y han lavado sus mantos en la sangre del Cordero.',
  salmo3Titulo: 'Cántico',
  salmo3Referencia: 'Cf. Col 1, 12-20',
  salmo3Subtitulo: 'HIMNO A CRISTO, PRIMOGÉNITO DE TODA CREATURA Y PRIMER RESUCITADO DE ENTRE LOS MUERTOS',
  salmo3: canticoColosensesMiercolesII,

  lecturaBreveTitulo: 'Lectura breve',
  lecturaBreveReferencia: '1Pe 4, 13-14',
  lecturaBreve: '''Queridos hermanos: Estad alegres cuando compartís los padecimientos de Cristo, para que, cuándo se manifieste su gloria, reboséis de gozo. Si os ultrajan por el nombre de Cristo, dichosos vosotros: porque el Espíritu de la gloria, el Espíritu de Dios, reposa sobre vosotros.''',

  responsorio: '''V/ Alegraos, justos, y gozad con el Señor.
R/ Alegraos, justos, y gozad con el Señor.

V/ Aclamadlo, los rectos de corazón.
R/ Y gozad con el Señor.

V/ Gloria al Padre, y al Hijo, y al Espíritu Santo.
R/ Alegraos, justos, y gozad con el Señor.''',

  antifonaCantico: 'Se alegran en el cielo los santos que siguieron las huellas de Cristo; y, porque lo amaron hasta derramar su sangre, reinan con el Señor eternamente.',

  canticoTitulo: 'Cántico de María',
  canticoReferencia: 'Lc 1, 46-55',
  canticoSubtitulo: 'ALEGRÍA DEL ALMA EN EL SEÑOR',
  cantico: '''Proclama mi alma la grandeza del Señor,
se alegra mi espíritu en Dios, mi salvador;
porque ha mirado la humillación de su esclava.

Desde ahora me felicitarán todas las generaciones,
porque el Poderoso ha hecho obras grandes por mí:
su nombre es santo,
y su misericordia llega a sus fieles
de generación en generación.

El hace proezas con su brazo:
dispersa a los soberbios de corazón,
derriba del trono a los poderosos
y enaltece a los humildes,
a los hambrientos los colma de bienes
y a los ricos los despide vacíos.

Auxilia a Israel, su siervo,
acordándose de su misericordia
—como lo había prometido a nuestros padres—
en favor de Abraham y su descendencia por siempre.

Gloria al Padre, y al Hijo, y al Espíritu Santo.
Como era en el principio, ahora y siempre, por los siglos de los siglos. Amén.''',

  introduccionPreces: '''En esta hora en la que el Señor, cenando con sus discípulos, presentó al Padre su propia vida que luego entregó en la cruz, aclamemos al Rey de los mártires, diciendo:''',

  respuestaPreces: 'Te glorificamos, Señor.',

  preces: [
    PreceOficio(
      inicio:
          'Te damos gracias, Señor, principio, ejemplo y rey de los mártires,',
      respuesta: 'porque nos amaste hasta el extremo.',
    ),
    PreceOficio(
      inicio: 'Te damos gracias, Señor, porque no cesas de llamar a los pecadores arrepentidos',
      respuesta: 'y les das parte en los premios de tu reino.',
    ),
    PreceOficio(
      inicio: 'Te damos gracias, Señor, porque hoy hemos ofrecido, como sacrificio para el perdón de los pecados,',
      respuesta: 'la sangre de la alianza nueva y eterna.',
    ),
    PreceOficio(
      inicio: 'Te damos gracias, Señor, porque con tu gracia nos has dado',
      respuesta: 'perseverar en la fe durante el día que ahora termina.',
    ),
    PreceOficio(
      inicio: 'Te damos gracias, Señor, porque has asociado a nuestros hermanos difuntos',
      respuesta: 'a tu muerte.',
    ),
  ],

  introduccionPadreNuestro: 'Dirijamos ahora nuestra oración al Padre que está en los cielos, diciendo:',

  oracionConclusiva: '''Señor Dios nuestro, que uniste a los bienaventurados mártires Luís José François, Juan Enrique Gruyer, Nicolás Colin, Juan Carlos Carón y Pedro Renato Rogue, por el amor a tu Iglesia y los fortaleciste con invicta constancia en la proclamación de tu libertad; concédenos que los que nos alegramos en la celebración de su martirio aprendamos a amar a la Iglesia como a una madre y anunciemos siempre con evangélica firmeza la palabra de la verdad y la justicia. Por Nuestro Señor.''',
);
