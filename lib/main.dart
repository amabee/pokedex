import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pokedex/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String name;

  MyHomePage({required this.name});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>> pokeList = [];

  Future<void> getData() async {
    http.Response pokeResponse;
    String urlString =
        "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
    Uri uri = Uri.parse(urlString);

    pokeResponse = await http.get(uri);

    if (pokeResponse.statusCode == 200) {
      Map<String, dynamic> pokeData = json.decode(pokeResponse.body);
      if (pokeData['pokemon'] is List) {
        List<Map<String, dynamic>> tempList =
            List<Map<String, dynamic>>.from(pokeData['pokemon']);
        setState(() {
          pokeList = tempList;
          _savePokemonData();
        });
      } else {
        throw Exception('Invalid data format: pokemon must be a List');
      }
    } else {
      throw Exception('Failed to load data from the API');
    }
  }

  Future<void> _savePokemonData() async {
    var box = await Hive.openBox('pokemonBox');
    await box.clear();
    for (var pokemon in pokeList) {
      await box.add(pokemon);
    }
  }

  Future<void> _loadPokemonData() async {
    var box = await Hive.openBox('pokemonBox');
    print(box.get("name"));
    setState(() {
      pokeList = box.values
          .where((element) => element is Map<String, dynamic>)
          .toList()
          .cast<Map<String, dynamic>>();
    });
  }

  @override
  void initState() {
    _loadPokemonData();
    getData();
    super.initState();
  }

  Future<void> _addPokemon() async {
    TextEditingController nameController = TextEditingController();
    TextEditingController imgUrlController = TextEditingController();
    TextEditingController candyController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Pokemon'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: imgUrlController,
              decoration: const InputDecoration(labelText: 'Image URL'),
            ),
            TextField(
              controller: candyController,
              decoration: const InputDecoration(labelText: 'Candy'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              var newPokemon = {
                'name': nameController.text,
                'img': imgUrlController.text,
                'candy': candyController.text,
              };
              setState(() {
                pokeList.add(newPokemon);
              });
              _savePokemonData();
              Navigator.of(context).pop();
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Welcome to PokeDex ${widget.name}"),
        backgroundColor: Colors.green,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addPokemon,
        child: const Icon(Icons.add),
      ),
      body: pokeList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: pokeList.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 300,
                        width: 300,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                pokeList[index]['name'],
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ),
                            Image.network(
                              pokeList[index]['img'],
                              width: 300,
                              height: 200,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Candy: ",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                                Text(pokeList[index]['candy'] ?? 'N/A',
                                    style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500)),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
    );
  }
}
