import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeScreen());
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _labWidgets = [
    ImageGrid(),
    SecureStorageGrid(),
    DataTableExample(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Labs')),
      body: Center(child: _labWidgets[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.grid_on), label: 'Lab 1'),
          BottomNavigationBarItem(icon: Icon(Icons.security), label: 'Lab 2'),
          BottomNavigationBarItem(
            icon: Icon(Icons.table_chart),
            label: 'Lab 3',
          ),
        ],
      ),
    );
  }
}

class ImageGrid extends StatelessWidget {
  final List<Map<String, String>> items = [
    {'title': 'Blue Whale', 'image': 'bin/assets/images/blue_whale.jpg'},
    {
      'title': 'Humpback Whale',
      'image': 'bin/assets/images/humpback_whale.jpeg',
    },
    {'title': 'Sperm Whale', 'image': 'bin/assets/images/sperm_whale.jpeg'},
    {'title': 'Orca (Killer Whale)', 'image': 'bin/assets/images/orca.jpg'},
    {'title': 'Beluga Whale', 'image': 'bin/assets/images/beluga_whale.jpeg'},
    {'title': 'Fin Whale', 'image': 'bin/assets/images/fin_whale.jpeg'},
    {'title': 'Gray Whale', 'image': 'bin/assets/images/gray_whale.jpeg'},
    {'title': 'Minke Whale', 'image': 'bin/assets/images/minke_whale.jpeg'},
    {'title': 'Bryde’s Whale', 'image': 'bin/assets/images/brydes_whale.jpeg'},
    {'title': 'Narwhal', 'image': 'bin/assets/images/narwhal.jpg'},
  ];
  ImageGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return GridTile(
          footer: GridTileBar(
            backgroundColor: Colors.black45,
            title: Text(items[index]['title']!),
          ),
          child: Image.asset(items[index]['image']!, fit: BoxFit.cover),
        );
      },
    );
  }
}

class SecureStorageGrid extends StatefulWidget {
  const SecureStorageGrid({super.key});

  @override
  _SecureStorageGridState createState() => _SecureStorageGridState();
}

class _SecureStorageGridState extends State<SecureStorageGrid> {
  final List<Map<String, String>> items = [
    {'title': 'Blue Whale', 'image': 'bin/assets/images/blue_whale.jpg'},
    {
      'title': 'Humpback Whale',
      'image': 'bin/assets/images/humpback_whale.jpeg',
    },
    {'title': 'Sperm Whale', 'image': 'bin/assets/images/sperm_whale.jpeg'},
    {'title': 'Orca (Killer Whale)', 'image': 'bin/assets/images/orca.jpg'},
    {'title': 'Beluga Whale', 'image': 'bin/assets/images/beluga_whale.jpeg'},
    {'title': 'Fin Whale', 'image': 'bin/assets/images/fin_whale.jpeg'},
    {'title': 'Gray Whale', 'image': 'bin/assets/images/gray_whale.jpeg'},
    {'title': 'Minke Whale', 'image': 'bin/assets/images/minke_whale.jpeg'},
    {'title': 'Bryde’s Whale', 'image': 'bin/assets/images/brydes_whale.jpeg'},
    {'title': 'Narwhal', 'image': 'bin/assets/images/narwhal.jpg'},
  ];

  final storage = FlutterSecureStorage();
  Set<int> selectedIndices = {};

  void _toggleSelection(int index) {
    setState(() {
      if (selectedIndices.contains(index)) {
        selectedIndices.remove(index);
      } else {
        selectedIndices.add(index);
      }
    });
  }

  Future<void> _saveSelections() async {
    List<String> selectedTitles =
        selectedIndices.map((index) => items[index]['title']!).toList();
    await storage.write(key: 'selectedItems', value: selectedTitles.join(','));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => _toggleSelection(index),
                child: GridTile(
                  footer: GridTileBar(
                    backgroundColor:
                        selectedIndices.contains(index)
                            ? Colors.blue
                            : Colors.black45,
                    title: Text(items[index]['title']!),
                  ),
                  child: Image.asset(items[index]['image']!, fit: BoxFit.cover),
                ),
              );
            },
          ),
        ),
        ElevatedButton(
          onPressed: _saveSelections,
          child: Text('Save Selections'),
        ),
      ],
    );
  }
}

class DataTableExample extends StatefulWidget {
  @override
  _DataTableExampleState createState() => _DataTableExampleState();
}

class _DataTableExampleState extends State<DataTableExample> {
  final List<Map<String, String>> items = [
    {
      'title': 'Blue Whale',
      'description': 'Largest animal on Earth, deep diver.',
    },
    {
      'title': 'Humpback Whale',
      'description': 'Known for acrobatic jumps, beautiful songs.',
    },
    {
      'title': 'Sperm Whale',
      'description': 'Deepest diving whale, has large head.',
    },
    {
      'title': 'Orca (Killer Whale)',
      'description': 'Highly intelligent, hunts in pods.',
    },
    {
      'title': 'Beluga Whale',
      'description': 'White whale, very vocal and social.',
    },
    {
      'title': 'Fin Whale',
      'description': 'Second largest whale, very fast swimmer.',
    },
    {
      'title': 'Gray Whale',
      'description': 'Long migrations, feeds on ocean floor.',
    },
    {
      'title': 'Minke Whale',
      'description': 'Smallest baleen whale, very curious nature.',
    },
    {
      'title': 'Bryde’s Whale',
      'description': 'Warm-water whale, has three head ridges.',
    },
    {
      'title': 'Narwhal',
      'description': 'Has a long spiral tusk, Arctic dweller.',
    },
  ];

  Set<int> selectedIndices = {};

  void _toggleSelection(int index) {
    setState(() {
      if (selectedIndices.contains(index)) {
        selectedIndices.remove(index);
      } else {
        selectedIndices.add(index);
      }
    });
  }

  void _showSelectedWhales() {
    if (selectedIndices.isEmpty) {
      _showAlert('No whales selected.');
      return;
    }

    List<String> selectedTitles =
        selectedIndices.map((index) => items[index]['title']!).toList();

    String message = selectedTitles.join('\n');

    _showAlert('Selected Whales:\n$message');
  }

  void _showAlert(String message) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.w900,
              color: const Color.fromARGB(255, 52, 24, 101),
              fontSize: 25.9,
            ),
            title: Text('Selection'),

            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Whale Species')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            bool isSelected = selectedIndices.contains(index);
            return GestureDetector(
              onTap: () => _toggleSelection(index),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 6),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color:
                      isSelected
                          ? Colors.deepPurple.withOpacity(0.3)
                          : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      spreadRadius: 1,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Checkbox(
                      value: isSelected,
                      onChanged: (bool? value) {
                        _toggleSelection(index);
                      },
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color:
                                  Colors
                                      .deepPurple
                                      .shade700, // Title background color
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              items[index]['title']!,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: 6),
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color:
                                  Colors
                                      .grey
                                      .shade200, // Description background color
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              items[index]['description']!,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showSelectedWhales,
        child: Icon(Icons.check),
      ),
    );
  }
}
