import 'package:agronews/news_tile.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AgroNewsHome(),
  ));
}

class AgroNewsHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Text("AgroNews", 
          style: TextStyle(color: Colors.green[800], fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black54),
            onPressed: () {},
          ),
          CircleAvatar(
            backgroundColor: Colors.green[100],
            child: Icon(Icons.person, color: Colors.green[800]),
          ),
          SizedBox(width: 16),
        ],
      ),
      body: ListView(
        children: [
        
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Quarta-feira, 25 de Fev", style: TextStyle(color: Colors.grey)),
                    Text("Araçatuba, SP", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.wb_sunny, color: Colors.orange),
                    SizedBox(width: 8),
                    Text("31°C", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                )
              ],
            ),
          ),

  
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              clipBehavior: Clip.antiAlias, // Corta a imagem nas bordas do card
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    'https://images.unsplash.com/photo-1523348837708-15d4a09cfac2?w=800',
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("DESTAQUE", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 12)),
                        SizedBox(height: 8),
                        Text(
                          "Brasil projeta colheita recorde para a próxima safra de grãos",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
            child: Text("Mais lidas", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),

          NewsTile(
            titulo: "Preço do milho sobe no mercado internacional",
            categoria: "MERCADO",
            tempo: "Há 1h",
            imagem: "https://images.unsplash.com/photo-1551730459-92db2a308d6a?w=200",
          ),
          NewsTile(
            titulo: "Nova tecnologia de drones reduz custo de pulverização",
            categoria: "TECH",
            tempo: "Há 3h",
            imagem: "https://images.unsplash.com/photo-1508197149814-0cc02e8b7f74?w=200",
          ),
          NewsTile(
            titulo: "Pecuária sustentável: os desafios para 2026",
            categoria: "PECUÁRIA",
            tempo: "Há 5h",
            imagem: "https://images.unsplash.com/photo-1544465544-1b71aee9dfa3?w=200",
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
