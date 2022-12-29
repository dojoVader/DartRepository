import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Welcome to Flutter',
      home: RandomWords()
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {

  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18);
  final _saved = <WordPair> {};

  void _pushSaved(){
    Navigator.of(context).push(
    MaterialPageRoute<void>(
      builder: (context) {
         final tiles = _saved.map((e) {
           return ListTile(
             title: Text(
               e.asPascalCase,
               style: _biggerFont
             ),
           );
         });

         final divided = tiles.isNotEmpty ? ListTile.divideTiles(
           context: context,
           tiles: tiles,
         ).toList() : <Widget>[];

         return Scaffold(
           appBar: AppBar(
             title: const Text('Saved Suggestions'),
           ),
          body:  ListView(children: divided),
         );
      }
    ));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Startup Name generator"),
        actions: [
          IconButton(
              onPressed: _pushSaved,
              tooltip: 'Saved Suggestions',
              icon: const Icon(Icons.list)),

        ]
      ),
     body:  ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context,item) {
        if(item.isOdd) return const Divider();

        final index = item ~/ 2;
        if(index >= _suggestions.length){
          _suggestions.addAll(generateWordPairs().take(10));
        }
        WordPair currentSuggestion = _suggestions[index];
        final alreadySaved = _saved.contains(currentSuggestion);

        return ListTile(
            title: Text(
                _suggestions[index].asPascalCase,
                 style: _biggerFont,
            ),
          trailing: Icon(
            alreadySaved ? Icons.favorite : Icons.favorite_border,
            color: alreadySaved ? Colors.red : null,
            semanticLabel: alreadySaved ? 'Remove from saved' : 'Save',
          ),
          onTap: (){
              setState(() {
                if(alreadySaved){
                  _saved.remove(currentSuggestion);
                }else{
                  _saved.add(currentSuggestion);
                }
              });
          },
        );
      }

    ))
    ;
  }
}
