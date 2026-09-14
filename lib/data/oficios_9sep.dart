import '../models/oficio.dart';
import '../models/tipo_oficio.dart';
import 'salterio/laudes_miercoles_iii.dart';
import 'salterio/visperas_miercoles_iii.dart';

const Oficio laudesFedericoOzanam9Sep = Oficio(
  fecha: '9 de septiembre',
  tipo: TipoOficio.laudes,

  himnoLiturgico: '''Vosotros sois luz del mundo
y ardiente sal de la tierra,
ciudad esbelta en el monte,
fermento en la masa nueva.

Vosotros sois los sarmientos,
y yo la Vid verdadera;
si el Padre poda las ramas,
más fruto llevan las cepas.

Vosotros sois la abundancia
del reino que ya está cerca,
los doce mil señalados
que no caerán en la siega.

Dichosos, porque sois limpios
y ricos en la pobreza,
y es vuestro el reino que sólo
se gana con la violencia.

Amén.''',

  // SALMODIA:
  // Los completaremos con los salmos correspondientes al día.
  antifona1:
      'Alegra el alma de tu siervo, pues levanto mi alma hacia ti, Señor.',
  salmo1Titulo: 'Salmo 85',
  salmo1Referencia: null,
  salmo1Subtitulo: 'ORACIÓN DE UN POBRE ANTE LAS ADVERSIDADES',
  salmo1: salmo85MiercolesIII,

  antifona2: 'Dichoso el hombre que procede con justicia y habla con rectitud.',
  salmo2Titulo: 'Cántico',
  salmo2Referencia: 'Is 33, 13-16',
  salmo2Subtitulo: 'DIOS JUZGARÁ CON JUSTICIA',
  salmo2: canticoIsaias33MiercolesIII,

  antifona3: 'Aclamad al Rey y Señor.',
  salmo3Titulo: 'Salmo 97',
  salmo3Referencia: null,
  salmo3Subtitulo: 'EL SEÑOR, JUEZ VENCEDOR',
  salmo3: salmo97MiercolesIII,

  lecturaBreveTitulo: 'Lectura breve',
  lecturaBreveReferencia: '1Co 13, 4-7',
  lecturaBreve: '''El amor es paciente, afable; no tiene envidia; no presume ni se engríe; no es mal educado ni egoísta; no se irrita, no lleva cuentas del mal; no se alegra con la injusticia, sino que goza con la verdad. Disculpa sin límites, cree sin límites, espera sin límites, aguanta sin límites.''',

  responsorio: '''V/ Dichoso el que cuida del pobre. En el día aciago lo librará el Señor.
R/ Dichoso el que cuida del pobre. En el día aciago lo librará el Señor.

V/ El Señor le hará feliz en la tierra.
R/ En el día aciago lo librará el Señor.

V/ Gloria al Padre, y al Hijo y al Espíritu Santo.
R/ Dichoso el que cuida del pobre. En el día aciago lo librará el Señor.''',

  antifonaCantico: 'La señal por la que conocerán que son discípulos míos será que se amen unos a otros.',

  introduccionPreces: '''Elevemos nuestra plegaria al Dios de la misericordia y del amor para que aumente en su Iglesia el celo por la evangelización y el servicio de los pobres, y digámosle confiadamente:''',

  respuestaPreces: 'Haznos testigos y mensajeros de tu salvación.',

  preces: [
    PreceOficio(
      inicio: 'Dios de misericordia, haz que hoy nos entreguemos generosamente a las obras de amor al prójimo,',
      respuesta: 'para que tu misericordia, a través de nosotros, llegue a todos los hombres.',
    ),
    PreceOficio(
      inicio:
          'Tú que nos has hecho partícipes de la misión profética de Cristo,',
      respuesta:
          'haz que anunciemos de palabra y de obra las maravillas de tu amor.',
    ),
    PreceOficio(
      inicio: 'Enséñanos a hacer el bien a todos en tu nombre,',
      respuesta: 'para que la luz de tu Iglesia resplandezca más y más sobre la familia humana.',
    ),
    PreceOficio(
      inicio: 'Haz que colaboremos en la edificación de un mundo nuevo,',
      respuesta:
          'para que la justicia y la paz de Cristo reinen en toda la tierra.',
    ),
    PreceOficio(
      inicio: 'Perdónanos por haber ignorado la presencia de Cristo en los pobres, los sencillos y los marginados,',
      respuesta:
          'y por no haber atendido a tu Hijo en estos hermanos nuestros.',
    ),
    PreceOficio(
      inicio: 'Envía sobre nosotros tu Espíritu,',
      respuesta: 'para que nuestra caridad sea auténtica y sin hipocresía.',
    ),
  ],

  introduccionPadreNuestro: 'Dirijamos ahora nuestra oración al Padre que está en los cielos, diciendo:',

  oracionConclusiva: '''Oh Dios, que suscitaste el bienaventurado Federico Ozanam, inflamado por el espíritu de tu caridad, para promover asociaciones de laicos con el fin de asistir a los pobres, concédenos que, movidos por su ejemplo, observemos tu mandamiento del amor y seamos así fermento en el mundo en que vivimos. Por nuestro Señor Jesucristo.''',
);

const Oficio visperasFedericoOzanam9Sep = Oficio(
  fecha: '9 de septiembre',
  tipo: TipoOficio.segundasVisperas,
  himnoLiturgico: '''Cuando, Señor, el día ya declina,
quedaos con el hombre, que, en la noche
del tiempo y de la lucha en que camina,
turba su corazón con su reproche.

Disipad nuestras dudas, hombres santos,
que en el alto glorioso del camino
ya dejasteis atrás temores tantos
de perder vuestra fe en el Don divino.

Perdonad nuestros miedos, seguidores
del camino en la fe que os fue ofrecido,
hacednos con vosotros confesores
de la fe y del amor que habéis vivido.

Que tu amor, Padre santo, haga fuerte
nuestro amor, nuestra fe en tu Hijo amado;
que la hora suprema de la muerte
sea encuentro en la luz, don consumado. Amén.''',

  // SALMODIA
  // La completaremos con los salmos correspondientes al día.
  antifona1: 'Los que sembraban con lágrimas cosechan entre cantares.',
  salmo1Titulo: 'Salmo 125',
  salmo1Referencia: null,
  salmo1Subtitulo: 'Dios, alegría y esperanza nuestra',
  salmo1: salmo125MiercolesIII,

  antifona2: 'Que el Señor nos construya la casa y nos guarde la ciudad.',
  salmo2Titulo: 'Salmo 126',
  salmo2Referencia: null,
  salmo2Subtitulo: 'El esfuerzo humano es inútil sin Dios',
  salmo2: salmo126MiercolesIII,

  antifona3: 'Él es el primogénito de toda creatura, es el primero en todo.',
  salmo3Titulo: 'Cántico',
  salmo3Referencia: 'Cf. Col 1, 12-20',
  salmo3Subtitulo: 'Himno a Cristo, primogénito de toda creatura y primer resucitado de entre los muertos',
  salmo3: canticoColosensesMiercolesIII,

  lecturaBreveTitulo: 'Lectura breve',
  lecturaBreveReferencia: '1Pe 3, 8-9',
  lecturaBreve: '''Procurad todos tener un mismo pensar y un mismo sentir: con afecto fraternal, con ternura, con humildad. No devolváis mal por mal o insulto por insulto; al contrario, responded con una bendición, porque para eso habéis sido llamados.''',

  responsorio: '''V/ Seréis discípulos míos, si os amáis unos a otros.
R/ Seréis discípulos míos, si os amáis unos a otros.

V/ Todos lo conocerán por esto.
R/ Si os amáis unos a otros.

V/ Gloria al Padre, y al Hijo y al Espíritu Santo.
R/ Seréis discípulos míos, si os amáis unos a otros.''',

  antifonaCantico: 'Lo que hagan al más pequeño de los míos, a mí me lo hacen. Vengan benditos de mi Padre, reciban la herencia del Reino preparado para ustedes desde la creación del mundo.',

  introduccionPreces: '''Celebrando la memoria del bienaventurado Federico Ozanam, y recordando su amor a los pobres, dirijamos nuestra oración a Dios, nuestro Padre, y, con el corazón lleno de alegría, digámosle:''',

  respuestaPreces: 'Enciende, Señor, en nosotros la llama de tu amor.',

  preces: [
    PreceOficio(
      inicio:
          'Infunde tu amor en aquellos que se nutren con el mismo pan de vida,',
      respuesta: 'para que todos sean uno en el cuerpo de tu Hijo.',
    ),
    PreceOficio(
      inicio: 'Tú que amas a los hombres, haznos solícitos para con el prójimo como tú nos mandaste,',
      respuesta: 'para que brille más vivamente la luz de tu Salvación.',
    ),
    PreceOficio(
      inicio: 'Ilumina a quienes tienen la misión de hacer las leyes,',
      respuesta:
          'para que en todas las cosas procedan con sabiduría y equidad.',
    ),
    PreceOficio(
      inicio: 'Socorre a quienes sufren discriminación por causa de su raza, color, condición, lengua o religión,',
      respuesta: 'para que obtengan el reconocimiento de sus derechos y de su dignidad.',
    ),
    PreceOficio(
      inicio: 'Protege a quienes en el mundo se han consagrado al servicio de sus hermanos,',
      respuesta:
          'para que puedan cumplir su tarea con libertad y sin obstáculos.',
    ),
    PreceOficio(
      inicio: 'Que todos los que reconocieron y amaron tu presencia en nuestros hermanos pobres,',
      respuesta: 'puedan contemplar tu rostro sin velos entre tus elegidos.',
    ),
  ],

  introduccionPadreNuestro:
      'Fieles a la recomendación del Salvador, nos atrevemos a decir:',

  oracionConclusiva: '''Oh Dios, que suscitaste el bienaventurado Federico Ozanam, inflamado por el espíritu de tu caridad, para promover asociaciones de laicos con el fin de asistir a los pobres, concédenos que, movidos por su ejemplo, observemos tu mandamiento del amor y seamos así fermento en el mundo en que vivimos. Por nuestro Señor Jesucristo.''',
);
