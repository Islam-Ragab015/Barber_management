import 'package:barber/features/favourite/favorites_provide.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage(
      {super.key, required List<Map<String, String>> favoriteShops});

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Favorites",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white70,
          ),
        ),
        backgroundColor: Colors.teal, // Same color scheme
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal, Colors.lightBlueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: favoritesProvider.favoriteShops.isEmpty
            ? Center(
                child: Text(
                  'No favorite shops added.',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width *
                        0.05, // Responsive font size
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              )
            : Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
                child: ListView.builder(
                  itemCount: favoritesProvider.favoriteShops.length,
                  itemBuilder: (context, index) {
                    final shop = favoritesProvider.favoriteShops[index];
                    return Card(
                      margin: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height *
                              0.01), // Responsive vertical margin
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      elevation: 8.0,
                      child: ListTile(
                        title: Text(
                          shop['title'] ?? '',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width *
                                0.04, // Responsive title font size
                            color: Colors.teal[800], // Custom color for title
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          shop['subtitle'] ?? '',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width *
                                0.035, // Responsive subtitle font size
                            color:
                                Colors.grey[600], // Custom color for subtitle
                          ),
                        ),
                        trailing: IconButton(
                          icon:
                              const Icon(Icons.delete, color: Colors.redAccent),
                          onPressed: () {
                            favoritesProvider.removeFavorite(shop);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
