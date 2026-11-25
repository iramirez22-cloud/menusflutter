import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Menus Flutter',
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: const Color(0xFFF7F7F7),
      ),
      home: const MenuHome(),
    );
  }
}

class MenuHome extends StatefulWidget {
  const MenuHome({super.key});

  @override
  State<MenuHome> createState() => _MenuHomeState();
}

class _MenuHomeState extends State<MenuHome> {
  int _selectedIndex = 0;

  final List<_MenuDestination> _destinations = const [
    _MenuDestination('Inicio', Icons.home),
    _MenuDestination('Peoples', Icons.groups),
    _MenuDestination('Calls', Icons.phone),
    _MenuDestination('Chats', Icons.chat),
    _MenuDestination('Configuration', Icons.settings),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF4A4659),
        elevation: 0.5,
        title: Text(
          _destinations[_selectedIndex].label,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      drawer: Drawer(
        width: 286,
        child: SafeArea(
          child: Column(
            children: [
              const _DrawerHeader(),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(12, 10, 12, 8),
                  children: [
                    for (int i = 0; i < _destinations.length; i++)
                      _drawerItem(
                        index: i,
                        label: i == 0 ? 'Inicio' : _destinations[i].label,
                        icon: _destinations[i].icon,
                      ),
                    _drawerItem(index: -1, label: 'Exit', icon: Icons.logout),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: _buildPage(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF5C5870),
        unselectedItemColor: const Color(0xFF8D8998),
        selectedFontSize: 11,
        unselectedFontSize: 11,
        items: [
          for (final destination in _destinations)
            BottomNavigationBarItem(
              icon: Icon(destination.icon),
              label: destination.label,
            ),
        ],
      ),
    );
  }

  Widget _drawerItem({
    required int index,
    required String label,
    required IconData icon,
  }) {
    final selected = index == _selectedIndex;
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Material(
        color: selected ? const Color(0xFFEAE7F2) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            Navigator.pop(context);
            if (index >= 0) {
              setState(() => _selectedIndex = index);
            } else {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Sesión cerrada')));
            }
          },
          child: SizedBox(
            height: 68,
            child: Row(
              children: [
                const SizedBox(width: 16),
                Icon(icon, size: 31, color: const Color(0xFF5A5471)),
                const SizedBox(width: 20),
                Text(
                  label,
                  style: TextStyle(
                    color: const Color(0xFF303030),
                    fontSize: 20,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 1:
        return const _SimplePage(
          title: 'Peoples',
          icon: Icons.groups,
          entries: ['Ana García', 'Carlos López', 'María Torres'],
        );
      case 2:
        return const _SimplePage(
          title: 'Calls',
          icon: Icons.phone,
          entries: ['Llamada entrante', 'Llamada perdida', 'Llamada realizada'],
        );
      case 3:
        return const _SimplePage(
          title: 'Chats',
          icon: Icons.chat,
          entries: ['Equipo Flutter', 'Familia', 'Amigos'],
        );
      case 4:
        return const _SimplePage(
          title: 'Configuration',
          icon: Icons.settings,
          entries: ['Cuenta', 'Notificaciones', 'Privacidad'],
        );
      default:
        return const _WelcomePage();
    }
  }
}

class _MenuDestination {
  final String label;
  final IconData icon;

  const _MenuDestination(this.label, this.icon);
}

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 215,
      child: Stack(
        fit: StackFit.expand,
        children: [
          const _TunnelBackground(),
          Positioned(
            left: 22,
            top: 20,
            child: Container(
              width: 68,
              height: 68,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: const Color(0xFF4E9DE1), width: 4),
              ),
              alignment: Alignment.center,
              child: const Text('🌴', style: TextStyle(fontSize: 38)),
            ),
          ),
          Positioned(
            left: 22,
            bottom: 18,
            child: const Text(
              'Opciones de menú',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w900,
                color: Color(0xFF00C853),
                shadows: [
                  Shadow(
                    offset: Offset(1, 1),
                    blurRadius: 2,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WelcomePage extends StatelessWidget {
  const _WelcomePage();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF7F7F7),
      alignment: Alignment.topLeft,
      child: SizedBox(
        height: 205,
        child: Stack(
          fit: StackFit.expand,
          children: [
            const _TunnelBackground(),
            Positioned(
              left: 22,
              top: 18,
              child: Container(
                width: 78,
                height: 78,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: const Color(0xFF37D5D8), width: 4),
                ),
                alignment: Alignment.center,
                child: const Text('🌴', style: TextStyle(fontSize: 44)),
              ),
            ),
            Positioned(
              left: 22,
              bottom: 18,
              child: const Text(
                '¡Hola, Bienvenido!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF37D5D8),
                  shadows: [
                    Shadow(
                      offset: Offset(1, 1),
                      blurRadius: 2,
                      color: Colors.black54,
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

class _TunnelBackground extends StatelessWidget {
  const _TunnelBackground();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _TunnelPainter());
  }
}

class _TunnelPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.drawRect(
      rect,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1B6EA6), Color(0xFF08284F)],
        ).createShader(rect),
    );

    final gridPaint = Paint()
      ..color = const Color(0xFF62AEE5).withValues(alpha: 0.42)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final center = Offset(size.width * 0.58, size.height * 0.45);
    for (double i = 18; i < size.shortestSide * 0.72; i += 28) {
      canvas.drawRect(
        Rect.fromCenter(center: center, width: i * 2.2, height: i * 1.25),
        gridPaint,
      );
      canvas.drawOval(
        Rect.fromCenter(center: center, width: i * 2.8, height: i * 1.55),
        gridPaint,
      );
    }

    for (int i = -4; i <= 4; i++) {
      canvas.drawLine(
        Offset(size.width * 0.5 + i * 36, 0),
        center,
        Paint()
          ..color = const Color(0xFF62AEE5).withValues(alpha: 0.42)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _SimplePage extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<String> entries;

  const _SimplePage({
    required this.title,
    required this.icon,
    required this.entries,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: entries.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: const Color(0xFFE9E6F2),
              child: Icon(icon, color: const Color(0xFF5A5471)),
            ),
            title: Text(entries[index]),
          ),
        );
      },
    );
  }
}
