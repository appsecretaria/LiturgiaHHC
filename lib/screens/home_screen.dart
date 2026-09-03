import 'package:flutter/material.dart';

import '../services/celebracion_service.dart';
import '../services/santoral_service.dart';
import 'celebracion_screen.dart';
import '../utils/navegacion.dart';
import '../main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int paginaActual = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: paginaActual,
        children: [
          const HoyScreen(),
          CalendarioScreen(
            onIrAHoy: () {
              setState(() {
                paginaActual = 0;
              });
            },
          ),
          const AjustesScreen(),
        ],
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: const NavigationBarThemeData(
          labelTextStyle: WidgetStatePropertyAll(
            TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        child: NavigationBar(
          selectedIndex: paginaActual,
          onDestinationSelected: (index) {
            setState(() {
              paginaActual = index;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined, size: 30),
              selectedIcon: Icon(Icons.home, size: 30),
              label: 'Hoy',
            ),
            NavigationDestination(
              icon: Icon(Icons.calendar_month_outlined, size: 30),
              selectedIcon: Icon(Icons.calendar_month, size: 30),
              label: 'Calendario',
            ),
            NavigationDestination(
              icon: Icon(Icons.settings_outlined, size: 30),
              selectedIcon: Icon(Icons.settings, size: 30),
              label: 'Ajustes',
            ),
          ],
        ),
      ),
    );
  }
}

class HoyScreen extends StatefulWidget {
  const HoyScreen({super.key});

  @override
  State<HoyScreen> createState() => _HoyScreenState();
}

class _HoyScreenState extends State<HoyScreen> {
  late Future<List<String>> santosHoy;

  @override
  void initState() {
    super.initState();
    santosHoy = obtenerSantosDelDia(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    final ahora = DateTime.now();
    final celebracion = obtenerCelebracion(ahora);

    const diasSemana = [
      'Lunes',
      'Martes',
      'Miércoles',
      'Jueves',
      'Viernes',
      'Sábado',
      'Domingo',
    ];

    const meses = [
      'enero',
      'febrero',
      'marzo',
      'abril',
      'mayo',
      'junio',
      'julio',
      'agosto',
      'septiembre',
      'octubre',
      'noviembre',
      'diciembre',
    ];

    final fechaFormateada =
        '${diasSemana[ahora.weekday - 1]}, '
        '${ahora.day} de ${meses[ahora.month - 1]} de ${ahora.year}';

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 14),

            const Text(
              'Hoy',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Text(
              fechaFormateada,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),

            const SizedBox(height: 32),

            const Divider(),

            const SizedBox(height: 32),

            // SANTO DEL DÍA
            Text(
              'Santo del día',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),

            const SizedBox(height: 14),

            FutureBuilder<List<String>>(
              future: santosHoy,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final santos = snapshot.data ?? [];

                if (santos.isEmpty) {
                  return const Text(
                    'No hay santo registrado para este día.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17),
                  );
                }

                return Column(
                  children: santos
                      .map(
                        (santo) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            santo,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                );
              },
            ),

            const SizedBox(height: 32),

            const Divider(),

            const SizedBox(height: 36),

            // LITURGIA VICENCIANA
            Text(
              'Liturgia Vicenciana',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),

            const SizedBox(height: 32),

            if (celebracion != null)
              Card(
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: Image.asset(
                    'assets/icons/corazon.png',
                    width: 48,
                    height: 48,
                    fit: BoxFit.contain,
                  ),
                  title: Text(
                    celebracion.nombre,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    celebracion.tipo,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    abrirPantalla(
                      context,
                      CelebracionScreen(celebracion: celebracion),
                    );
                  },
                ),
              )
            else
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/icons/sv_calendar.png',
                        width: 48,
                        height: 48,
                        fit: BoxFit.contain,
                      ),

                      const SizedBox(height: 22),

                      const Text(
                        'Hoy no hay Liturgia Vicenciana propia',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class CalendarioScreen extends StatefulWidget {
  final VoidCallback onIrAHoy;

  const CalendarioScreen({super.key, required this.onIrAHoy});

  @override
  State<CalendarioScreen> createState() => _CalendarioScreenState();
}

class _CalendarioScreenState extends State<CalendarioScreen> {
  final ScrollController _scrollController = ScrollController();

  late DateTime mesActual;

  @override
  void initState() {
    super.initState();

    final ahora = DateTime.now();

    mesActual = DateTime(ahora.year, ahora.month, 1);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final diasDelMes = DateTime(mesActual.year, mesActual.month + 1, 0).day;

    final primerDiaSemana = DateTime(
      mesActual.year,
      mesActual.month,
      1,
    ).weekday;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 10),

            const Text(
              'Calendario Vicenciano',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 26),

            // MES + FLECHAS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: _mesAnterior,
                  icon: const Icon(Icons.chevron_left),
                ),

                Text(
                  '${_nombreMes(mesActual.month)} ${mesActual.year}',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),

                IconButton(
                  onPressed: _mesSiguiente,
                  icon: const Icon(Icons.chevron_right),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // DÍAS DE LA SEMANA
            const Row(
              children: [
                _DiaSemana('L'),
                _DiaSemana('M'),
                _DiaSemana('X'),
                _DiaSemana('J'),
                _DiaSemana('V'),
                _DiaSemana('S'),
                _DiaSemana('D'),
              ],
            ),

            const SizedBox(height: 10),

            Expanded(
              child: Scrollbar(
                controller: _scrollController,
                thumbVisibility: true,
                interactive: true,
                child: GridView.builder(
                  controller: _scrollController,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    childAspectRatio: 1,
                  ),
                  itemCount: 42,
                  itemBuilder: (context, index) {
                    final dia = index - (primerDiaSemana - 1) + 1;

                    if (dia < 1 || dia > diasDelMes) {
                      return const SizedBox();
                    }

                    final fecha = DateTime(
                      mesActual.year,
                      mesActual.month,
                      dia,
                    );

                    final celebracion = obtenerCelebracion(fecha);

                    final esVicenciano = celebracion != null;

                    final hoy = DateTime.now();

                    final esHoy =
                        fecha.year == hoy.year &&
                        fecha.month == hoy.month &&
                        fecha.day == hoy.day;

                    return InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: () {
                        if (esHoy) {
                          widget.onIrAHoy();
                        } else if (esVicenciano) {
                          abrirPantalla(
                            context,
                            CelebracionScreen(celebracion: celebracion),
                          );
                        }
                      },
                      child: Center(
                        child: Container(
                          width: 38,
                          height: 38,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: esVicenciano
                                ? Theme.of(context).colorScheme.primary
                                : Colors.transparent,
                            shape: BoxShape.circle,
                            border: esHoy
                                ? Border.all(
                                    color: const Color(0xFFD4A017),
                                    width: 2.5,
                                  )
                                : null,
                          ),
                          child: Text(
                            '$dia',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: esVicenciano
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: esVicenciano
                                  ? Colors.white
                                  : Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _mesAnterior() {
    setState(() {
      mesActual = DateTime(mesActual.year, mesActual.month - 1, 1);
    });
  }

  void _mesSiguiente() {
    setState(() {
      mesActual = DateTime(mesActual.year, mesActual.month + 1, 1);
    });
  }

  String _nombreMes(int mes) {
    const meses = [
      'Enero',
      'Febrero',
      'Marzo',
      'Abril',
      'Mayo',
      'Junio',
      'Julio',
      'Agosto',
      'Septiembre',
      'Octubre',
      'Noviembre',
      'Diciembre',
    ];

    return meses[mes - 1];
  }
}

class _DiaSemana extends StatelessWidget {
  final String texto;

  const _DiaSemana(this.texto);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(
          texto,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class AjustesScreen extends StatelessWidget {
  const AjustesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = AppSettingsScope.of(context);

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Lectura',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 24),

          Text(
            'Tamaño del texto: ${settings.tamanoTexto.toInt()}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 8),

          Slider(
            value: settings.tamanoTexto,
            min: 16,
            max: 30,
            divisions: 7,
            label: settings.tamanoTexto.toInt().toString(),
            onChanged: (value) {
              settings.cambiarTamanoTexto(value);
            },
          ),

          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '16',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Text(
                '30',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
