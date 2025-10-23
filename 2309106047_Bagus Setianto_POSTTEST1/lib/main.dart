import 'package:flutter/material.dart';

void main() {
  runApp(const MagicChessApp());
}

class MagicChessApp extends StatelessWidget {
  const MagicChessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Guidebook MagicChess GoGo',

      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HeroListPage(),
    );
  }
}

class HeroListPage extends StatelessWidget {
  const HeroListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final guide = Guidebook()
      ..addHero(HeroPiece(
        id: 1,
        name: 'Baxia',
        role: 'Defender',
        synergy: 'Shadowcell',
        rarity: 'Epic',
        ability: Ability(name: 'Dentuman roda', power: 70, effect: 'CC immune'),
        description: 'Tank keras dengan skill area',
      ))
      ..addHero(HeroPiece(
        id: 2,
        name: 'Belerick',
        role: 'Bruiser',
        synergy: 'Starwing',
        rarity: 'rare',
        ability: Ability(name: 'Sky Slash', power: 90),
        description: null,
      ))
      ..addHero(HeroPiece(
        id: 3,
        name: 'Angela',
        role: 'Mage',
        synergy: 'Aspirant',
        rarity: 'Legend',
        ability: Ability(name: 'Heart Guard', power: 50, effect: 'heal'),
        description: 'Support yang bisa melindungi dan area skill yang luas.',
      ));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Guidebook MagicChess GoGo'),
      ),
      body: ListView.builder(
        itemCount: guide.heroes.length,
        itemBuilder: (context, index) {
          final hero = guide.heroes[index];
          return Card(
            child: ListTile(
              title: Text(hero.name),
              subtitle: Text('${hero.role} • ${hero.rarity}'),
              trailing: Icon(
                hero.rarity == 'Legendary' ? Icons.star : Icons.shield,
                color: hero.rarity == 'Legendary' ? Colors.amber : Colors.grey,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => HeroDetailPage(hero: hero),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class HeroDetailPage extends StatelessWidget {
  final HeroPiece hero;

  const HeroDetailPage({super.key, required this.hero});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(hero.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(hero.name,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Role: ${hero.role}'),
            Text('Synergy: ${hero.synergy}'),
            Text('Rarity: ${hero.rarity}'),
            const Divider(),
            Text(
                'Ability: ${hero.ability.name} - power ${hero.ability.power}, '
                'effect: ${hero.ability.effect ?? "no effect"}'),
            const Divider(),
            Text('Description: ${hero.description?.trim() ?? "Belum ada deskripsi"}'),
            const SizedBox(height: 12),
            Text(
              'Status: ${hero.rarity == "Legendary" ? "Hero langka & kuat" : "Hero standar"}',
              style: TextStyle(
                color: hero.rarity == "Legendary" ? Colors.orange : Colors.black,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Guidebook {
  final List<HeroPiece> heroes = [];

  void addHero(HeroPiece h) => heroes.add(h);
}

class HeroPiece {
  final int id;
  final String name;
  final String role;
  final String synergy;
  final String rarity;
  final Ability ability;
  final String? description;

  HeroPiece({
    required this.id,
    required this.name,
    required this.role,
    required this.synergy,
    required this.rarity,
    required this.ability,
    this.description,
  });
}

class Ability {
  final String name;
  final int power;
  final String? effect;

  Ability({required this.name, required this.power, this.effect});
}