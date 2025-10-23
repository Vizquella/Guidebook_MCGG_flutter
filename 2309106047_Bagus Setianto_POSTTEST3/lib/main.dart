import 'package:flutter/material.dart';

void main() {
  runApp(const MagicChessApp());
}

class MagicChessApp extends StatelessWidget {
  const MagicChessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guidebook MagicChess GoGo',
      routes: {
        '/signin': (_) => const SignInPage(),
        '/home': (_) => const HomeShell(),
      },
      initialRoute: '/signin',
    );
  }
}

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  String _role = 'player';
  bool _remember = false;
  bool _darkMode = false;
  bool _obscure = true;

  @override
  void dispose() {
    _email.dispose();
    _pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      brightness: _darkMode ? Brightness.dark : Brightness.light,
      primarySwatch: Colors.blue,
    );

    return Theme(
      data: theme,
      child: Scaffold(
        appBar: AppBar(title: const Text('Sign In')),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text('Guidebook MagicChess GoGo',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),

            TextField(
              controller: _email,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
              ),
              onChanged: (v) {},
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _pass,
              obscureText: _obscure,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
                  onPressed: () => setState(() => _obscure = !_obscure),
                ),
              ),
            ),

            const SizedBox(height: 16),
            const Text('Pilih Role'),
            ListTile(
              leading: Radio<String>(
                value: 'player',
                groupValue: _role,
                onChanged: (v) => setState(() => _role = v!),
              ),
              title: const Text('Player'),
            ),
            ListTile(
              leading: Radio<String>(
                value: 'coach',
                groupValue: _role,
                onChanged: (v) => setState(() => _role = v!),
              ),
              title: const Text('Coach'),
            ),

            CheckboxListTile(
              value: _remember,
              onChanged: (v) => setState(() => _remember = v ?? false),
              title: const Text('Remember me'),
              controlAffinity: ListTileControlAffinity.leading,
            ),

            SwitchListTile(
              value: _darkMode,
              onChanged: (v) => setState(() => _darkMode = v),
              title: const Text('Dark Mode'),
            ),

            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                if (_email.text.trim().isEmpty || _pass.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Email/Password wajib diisi')),
                  );
                  return;
                }
                Navigator.pushNamed(context, '/home',
                    arguments: {'email': _email.text, 'role': _role});
              },
              child: const Text('Masuk'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SignUpPlaceholderPage(),
                  ),
                );
              },
              child: const Text('Belum punya akun? Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});
  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  static final List<Widget> _pages = <Widget>[
    const CommanderPage(),
    const HeroPage(),
    const SynergyPage(),
  ];

  void _onTap(int i) => setState(() => _index = i);

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final email = args?['email'] as String? ?? 'Guest';

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, $email'),
      ),
      drawer: Drawer(
        child: ListView(
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blueAccent),
              child: Text('Guidebook Menu',
                  style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
            ListTile(leading: Icon(Icons.info), title: Text('About')),
          ],
        ),
      ),
      body: _pages.elementAt(_index),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: _onTap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.shield), label: 'Commander'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Hero'),
          BottomNavigationBarItem(icon: Icon(Icons.auto_awesome), label: 'Synergy'),
        ],
      ),
    );
  }
}

class CommanderPage extends StatelessWidget {
  const CommanderPage({super.key});
  @override
  Widget build(BuildContext context) {
    final data = const [
      {'name': 'Popol & Kupa', 'skill': 'Copy Trap'},
      {'name': 'Lancelot', 'skill': 'Golden Legacy'},
      {'name': 'Cyclops', 'skill': 'Astral Blessing'},
      {'name': 'Comming soon', 'skill': 'belum dibikin'},
    ];
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: data.length,
      itemBuilder: (_, i) {
        final c = data[i];
        return Card(
          child: ListTile(
            title: Text(c['name']!),
            subtitle: Text('Skill: ${c['skill']}'),
          ),
        );
      },
    );
  }
}

class HeroPage extends StatelessWidget {
  const HeroPage({super.key});
  Color getColorByCost(int cost) {
    switch (cost) {
      case 1:
        return const Color.fromARGB(255, 218, 218, 218);
      case 2:
        return const Color.fromARGB(255, 118, 238, 122);
      case 3:
        return const Color.fromARGB(255, 74, 198, 255);
      case 4:
        return const Color.fromARGB(255, 204, 41, 233);
      case 5:
        return const Color.fromARGB(255, 255, 183, 0);
      default:
        return const Color.fromARGB(255, 225, 224, 224);
    }
  }

  @override
  Widget build(BuildContext context) {
    final heroes = const [
      {
        'name': 'Xborg',
        'role': 'Defender',
        'faction': 'Metro Zero',
        'cost': 5,
        'image': 'assets/xborg.jpg',
        'description':
            'Menerjang ke area yang ramai dengan hero musuh, memberikan damage area secara bertahap kemudian diakhiri dengan damage area besar. Cocok untuk menjaga garis depan dan melindungi tim.'
      },
      {
        'name': 'Saber',
        'role': 'Swordsman',
        'faction': 'Starwing',
        'cost': 4,
        'image': 'assets/saber.jpg',
        'description':
            'Menyerang cepat dengan tebasan beruntun. Ultimate-nya bisa mengunci satu target dan mengeliminasi dengan damage tinggi.'
      },
      {
        'name': 'Angela',
        'role': 'Mage',
        'faction': 'Aspirant',
        'cost': 5,
        'image': 'assets/angela.jpg',
        'description':
            'Skill area memberikan damage beruntun dan memberikan shield dan heal kepada hero rekan.'
      },
      {
        'name': 'Alucard',
        'role': 'Weapon Master',
        'faction': 'Shadow Shell',
        'cost': 1,
        'image': 'assets/alucard.jpg',
        'description':
            'Memberikan damage keapada target tunggal terdekat.'
      },
      {
        'name': 'Hylos',
        'role': 'Defender',
        'faction': 'Doomsworn',
        'cost': 2,
        'image': 'assets/hylos.jpg',
        'description':
            'Memberikan damage kepada target tunggal dan membirak efek stun. Memberikan tambahan HP kepada hero rekan yang berada di sebelah kanan dan kiri.'
      },
      {
        'name': 'Tigreal',
        'role': 'Dauntless',
        'faction': 'Shadeweaver',
        'cost': 3,
        'image': 'assets/tigreal.jpg',
        'description':
            'Skill area memberikan damage dan membuat hero musuh disekitar tidak dapat bergerak.'
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: heroes.length,
      itemBuilder: (_, i) {
        final h = heroes[i];
        final cost = h['cost'] as int;

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => HeroDetailPage(hero: h),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: getColorByCost(cost),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black87, width: 2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(h['name'] as String,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      Text('Role: ${h['role']}'),
                      Text('Faction: ${h['faction']}'),
                      Text('Cost: $cost'),
                    ],
                  ),
                ),
                if (cost == 5)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFD700),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                      ),
                      child: const Text(
                        '★ 5 COST',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class SynergyPage extends StatelessWidget {
  const SynergyPage({super.key});
  @override
  Widget build(BuildContext context) {
    const syns = [
      'Metro Zero',
      'Starwing',
      'Aspirant',
      'Emberlord',
      'Comming Soon',
    ];
    return ListView(
      padding: const EdgeInsets.all(12),
      children: syns
          .map((s) => Card(child: ListTile(title: Text(s))))
          .toList(),
    );
  }
}

class HeroDetailPage extends StatelessWidget {
  final Map<String, Object?> hero;
  const HeroDetailPage({super.key, required this.hero});

  Color getColorByCost(int cost) {
    switch (cost) {
      case 1:
        return const Color.fromARGB(255, 218, 218, 218);
      case 2:
        return const Color.fromARGB(255, 118, 238, 122);
      case 3:
        return const Color.fromARGB(255, 74, 198, 255);
      case 4:
        return const Color.fromARGB(255, 204, 41, 233);
      case 5:
        return const Color.fromARGB(255, 255, 183, 0);
      default:
        return const Color.fromARGB(255, 225, 224, 224);
    }
  }

  @override
  Widget build(BuildContext context) {
    final name = hero['name'] as String? ?? 'Unknown';
    final role = hero['role'] as String? ?? '-';
    final faction = hero['faction'] as String? ?? '-';
    final cost = hero['cost'] as int? ?? 0;
    final skill = hero['description'] as String? ?? 'Tidak ada skill.';
    final imagePath = hero['image'] as String? ?? '';

    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 320,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: getColorByCost(cost),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black87, width: 2),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      imagePath,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(name,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text('Role: $role'),
                Text('Faction: $faction'),
                Text('Cost: $cost'),
                const Divider(height: 24, thickness: 2),
                const Text('Skill:',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text(skill, textAlign: TextAlign.justify),
                const SizedBox(height: 16),
                Center(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Kembali'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignUpPlaceholderPage extends StatelessWidget {
  const SignUpPlaceholderPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: const Center(child: Text('Halaman Sign Up (placeholder)')),
    );
  }
}