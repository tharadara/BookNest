
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Widgets/AppBar.dart';
import '../../Widgets/SearchBar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildAppBar(
        'assets/images/BN.png',
        'BookNest',
      ),
      body: Column(
        children: [

          BuildSearchBarForSearchScreen(
              context,
              Icon(
                Icons.search,
                size: 30,
              ),
              'Search'),
          // SizedBox(height: 20,),
        ],
      ),
    );
  }
}
