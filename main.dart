import 'package:flutter/material.dart';

void main() => runApp(const ICookApp());

class ICookApp extends StatelessWidget {
  const ICookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iCook',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE56B2F),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFFFAF5),
        fontFamily: 'Roboto',
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedTab = 0;
  String selectedCategory = 'All';

  final categories = const [
    'All', 'Breakfast', 'Main Course', 'Snacks', 'Dessert',
    'Vegetarian', 'Non-Vegetarian'
  ];

  final recipes = const [
    Recipe('Hyderabadi Chicken Dum Biryani', 'Telangana', 'Main Course', '55 min', 'Medium', '🍛'),
    Recipe('Masala Dosa', 'Karnataka', 'Breakfast', '35 min', 'Medium', '🥞'),
    Recipe('Bengali Mishti Doi', 'West Bengal', 'Dessert', '20 min', 'Easy', '🍮'),
    Recipe('Punjabi Chole', 'Punjab', 'Main Course', '40 min', 'Easy', '🥘'),
    Recipe('Mumbai Vada Pav', 'Maharashtra', 'Snacks', '30 min', 'Medium', '🍔'),
    Recipe('Kerala Avial', 'Kerala', 'Vegetarian', '35 min', 'Easy', '🥗'),
  ];

  @override
  Widget build(BuildContext context) {
    final visible = selectedCategory == 'All'
        ? recipes
        : recipes.where((r) => r.category == selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFAF5),
        title: const Row(children: [
          Text('🍲', style: TextStyle(fontSize: 25)),
          SizedBox(width: 8),
          Text('iCook', style: TextStyle(fontWeight: FontWeight.w800)),
        ]),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.account_circle_outlined)),
        ],
      ),
      body: IndexedStack(
        index: selectedTab,
        children: [
          _home(visible),
          const ExplorePage(),
          const AssistantPage(),
          const SavedPage(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedTab,
        onDestinationSelected: (i) => setState(() => selectedTab = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.map_outlined), selectedIcon: Icon(Icons.map), label: 'Explore'),
          NavigationDestination(icon: Icon(Icons.auto_awesome_outlined), selectedIcon: Icon(Icons.auto_awesome), label: 'AI Cook'),
          NavigationDestination(icon: Icon(Icons.bookmark_border), selectedIcon: Icon(Icons.bookmark), label: 'Saved'),
        ],
      ),
    );
  }

  Widget _home(List<Recipe> visible) => ListView(
    padding: const EdgeInsets.fromLTRB(18, 8, 18, 24),
    children: [
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color(0xFFFFE4CC), Color(0xFFFFF1DF)]),
          borderRadius: BorderRadius.circular(24),
        ),
        child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('India on a plate 🇮🇳', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800)),
          SizedBox(height: 8),
          Text('Discover regional flavours. Cook traditions at home.', style: TextStyle(fontSize: 15)),
        ]),
      ),
      const SizedBox(height: 18),
      TextField(
        decoration: InputDecoration(
          hintText: 'Search dishes or ingredients',
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
        ),
      ),
      const SizedBox(height: 22),
      const Text('Explore Indian regions', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
      const SizedBox(height: 12),
      SizedBox(
        height: 94,
        child: ListView(scrollDirection: Axis.horizontal, children: const [
          RegionTile(name: 'North', emoji: '🕌'),
          RegionTile(name: 'South', emoji: '🌴'),
          RegionTile(name: 'East', emoji: '🐟'),
          RegionTile(name: 'West', emoji: '🌶️'),
          RegionTile(name: 'Central', emoji: '🌾'),
        ]),
      ),
      const SizedBox(height: 22),
      const Text('Find something delicious', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
      const SizedBox(height: 10),
      Wrap(spacing: 8, runSpacing: 8, children: categories.map((c) =>
        ChoiceChip(label: Text(c), selected: selectedCategory == c,
          onSelected: (_) => setState(() => selectedCategory = c),
        )).toList()),
      const SizedBox(height: 16),
      ...visible.map((r) => RecipeCard(recipe: r, onTap: () => Navigator.push(
        context, MaterialPageRoute(builder: (_) => RecipePage(recipe: r)),
      ))),
    ],
  );
}

class RegionTile extends StatelessWidget {
  final String name, emoji;
  const RegionTile({super.key, required this.name, required this.emoji});
  @override
  Widget build(BuildContext context) => Container(
    width: 86, margin: const EdgeInsets.only(right: 10), padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(emoji, style: const TextStyle(fontSize: 27)),
      const SizedBox(height: 5), Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
    ]),
  );
}

class Recipe {
  final String title, region, category, time, difficulty, emoji;
  const Recipe(this.title, this.region, this.category, this.time, this.difficulty, this.emoji);
}

class RecipeCard extends StatelessWidget {
  final Recipe recipe; final VoidCallback onTap;
  const RecipeCard({super.key, required this.recipe, required this.onTap});
  @override
  Widget build(BuildContext context) => Card(
    color: Colors.white, elevation: 0, margin: const EdgeInsets.only(bottom: 12),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
    child: ListTile(
      onTap: onTap, contentPadding: const EdgeInsets.all(12),
      leading: CircleAvatar(radius: 27, backgroundColor: const Color(0xFFFFE9D8),
        child: Text(recipe.emoji, style: const TextStyle(fontSize: 25))),
      title: Text(recipe.title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text('${recipe.region} • ${recipe.time} • ${recipe.difficulty}'),
      trailing: const Icon(Icons.chevron_right),
    ),
  );
}

class RecipePage extends StatelessWidget {
  final Recipe recipe;
  const RecipePage({super.key, required this.recipe});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Recipe')),
    body: ListView(padding: const EdgeInsets.all(20), children: [
      Text(recipe.emoji, textAlign: TextAlign.center, style: const TextStyle(fontSize: 72)),
      Text(recipe.title, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
      Text('${recipe.region} • ${recipe.time} • ${recipe.difficulty}'),
      const SizedBox(height: 22),
      const Text('Ingredients', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      const Text('Recipe ingredients and measured quantities will be added to the verified recipe catalogue.'),
      const SizedBox(height: 18),
      const Text('Cooking steps', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      const Text('Step-by-step regional cooking instructions will appear here.'),
      const SizedBox(height: 24),
      FilledButton.icon(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AssistantPage())),
        icon: const Icon(Icons.auto_awesome), label: const Text('Ask AI Cooking Assistant')),
    ]),
  );
}

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});
  @override
  Widget build(BuildContext context) => const Center(child: Padding(
    padding: EdgeInsets.all(24),
    child: Text('Regional Explorer\n\nBrowse Indian regions and discover their traditional recipes.', textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
  ));
}

class AssistantPage extends StatefulWidget {
  const AssistantPage({super.key});
  @override
  State<AssistantPage> createState() => _AssistantPageState();
}
class _AssistantPageState extends State<AssistantPage> {
  final controller = TextEditingController();
  final messages = <String>['Namaste! I’m your iCook assistant. Ask me about ingredients, substitutions or cooking techniques.'];
  @override
  void dispose() { controller.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => Column(children: [
    const Padding(padding: EdgeInsets.all(20), child: Text('Your cooking companion', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
    Expanded(child: ListView(padding: const EdgeInsets.all(16), children: messages.map((m) =>
      Align(alignment: Alignment.centerLeft, child: Container(margin: const EdgeInsets.only(bottom: 10), padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)), child: Text(m)))).toList())),
    SafeArea(child: Padding(padding: const EdgeInsets.all(12), child: Row(children: [
      Expanded(child: TextField(controller: controller, decoration: const InputDecoration(hintText: 'Ask a cooking question...', border: OutlineInputBorder()))),
      IconButton(onPressed: () { if (controller.text.trim().isEmpty) return; setState(() { messages.add(controller.text.trim()); messages.add('AI connection will be enabled after secure backend setup.'); controller.clear(); }); }, icon: const Icon(Icons.send)),
    ]))),
  ]);
}

class SavedPage extends StatelessWidget {
  const SavedPage({super.key});
  @override
  Widget build(BuildContext context) => const Center(child: Text('Your saved recipes will appear here.'));
}
