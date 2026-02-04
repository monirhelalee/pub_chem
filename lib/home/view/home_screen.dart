import 'package:flutter/material.dart';
import 'package:pub_chem/app/utils/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const .all(16),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            SearchBar(
              leading: const Icon(Icons.search),
              hintText: 'Search for compounds',
              onChanged: (value) {},
              padding: .all(const .only(left: 16)),
              elevation: .all(0),
              readOnly: true,
            ),
            const SizedBox(height: 16),
            const Text(
              'Featured Compounds',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.2,
                ),
                itemCount: Constants.featuredCompounds.length,
                itemBuilder: (BuildContext context, int index) {
                  final compound = Constants.featuredCompounds[index];
                  return Card(
                    elevation: 2,
                    child: Center(
                      child: Padding(
                        padding: const .all(8),
                        child: Column(
                          mainAxisAlignment: .center,
                          spacing: 8,
                          children: [
                            const Icon(
                              Icons.science_outlined,
                              size: 48,
                            ),
                            Text(
                              compound,
                              textAlign: .center,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: .w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
