import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return Padding(
      padding: const .all(16),
      child: Column(
        children: [
          SearchBar(
            trailing: const [Icon(Icons.search)],
            hintText: 'Search for compounds',
            padding: .all(const .only(left: 16, right: 16)),
            elevation: .all(0),
          ),
        ],
      ),
    );
  }
}
