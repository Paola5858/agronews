import 'package:flutter/material.dart';

class NewsTile extends StatelessWidget {
  final String titulo;
  final String categoria;
  final String tempo;
  final String imagem;

  NewsTile({required this.titulo, required this.categoria, required this.tempo, required this.imagem});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(categoria, style: TextStyle(color: Colors.orange[800], fontWeight: FontWeight.bold, fontSize: 11)),
                SizedBox(height: 4),
                Text(titulo, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                SizedBox(height: 8),
                Text(tempo, style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          SizedBox(width: 16),
        
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(image: NetworkImage(imagem), fit: BoxFit.cover),
            ),
          ),
        ],
      ),
    );
  }
}