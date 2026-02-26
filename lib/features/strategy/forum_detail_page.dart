import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../core/constants/app_colors.dart';
import '../../shared/models/forum_topic_model.dart';
import '../../shared/models/comment_model.dart';

class ForumDetailPage extends StatefulWidget {
  final ForumTopicModel topic;

  const ForumDetailPage({super.key, required this.topic});

  @override
  State<ForumDetailPage> createState() => _ForumDetailPageState();
}

class _ForumDetailPageState extends State<ForumDetailPage> {
  final TextEditingController _commentController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _commentController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Discussão',
          style: GoogleFonts.cormorantGaramond(fontWeight: FontWeight.bold),
        ),
        backgroundColor: isDark ? Colors.grey[900] : AppColors.verdeOliva,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                _buildTopicHeader(isDark),
                SizedBox(height: 24),
                Text(
                  'Discussão (${widget.topic.discussao.length})',
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : AppColors.verdeOliva,
                  ),
                ),
                SizedBox(height: 16),
                ...widget.topic.discussao.map((comment) => _buildComment(comment, isDark)),
              ],
            ),
          ),
          _buildCommentInput(isDark),
        ],
      ),
    );
  }

  Widget _buildTopicHeader(bool isDark) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[850]?.withOpacity(0.5) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? Colors.white.withOpacity(0.1) : Colors.grey[300]!,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(widget.topic.avatarUrl),
                radius: 24,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.topic.autor,
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      timeago.format(widget.topic.data, locale: 'pt_BR'),
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.douradoTrigo.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Text(widget.topic.icone, style: TextStyle(fontSize: 16)),
                    SizedBox(width: 4),
                    Text(
                      widget.topic.categoria,
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.douradoTrigo,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            widget.topic.titulo,
            style: GoogleFonts.cormorantGaramond(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : AppColors.verdeOliva,
            ),
          ),
          SizedBox(height: 12),
          Text(
            widget.topic.descricao,
            style: GoogleFonts.lora(
              fontSize: 16,
              color: isDark ? Colors.white70 : Colors.black87,
              height: 1.6,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.visibility_outlined, size: 18, color: Colors.grey),
              SizedBox(width: 4),
              Text(
                '${widget.topic.visualizacoes} visualizações',
                style: GoogleFonts.montserrat(fontSize: 13, color: Colors.grey),
              ),
              SizedBox(width: 16),
              Icon(Icons.comment_outlined, size: 18, color: Colors.grey),
              SizedBox(width: 4),
              Text(
                '${widget.topic.comentarios} comentários',
                style: GoogleFonts.montserrat(fontSize: 13, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildComment(CommentModel comment, bool isDark, {bool isReply = false}) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 12,
        left: isReply ? 40 : 0,
      ),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.grey[850]?.withOpacity(0.3)
            : Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? Colors.white.withOpacity(0.05) : Colors.grey[200]!,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(comment.avatarUrl),
                radius: 16,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comment.autor,
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      timeago.format(comment.data, locale: 'pt_BR'),
                      style: GoogleFonts.montserrat(
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            comment.conteudo,
            style: GoogleFonts.lora(
              fontSize: 14,
              color: isDark ? Colors.white70 : Colors.black87,
              height: 1.5,
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    Icon(Icons.thumb_up_outlined, size: 16, color: Colors.grey),
                    SizedBox(width: 4),
                    Text(
                      '${comment.likes}',
                      style: GoogleFonts.montserrat(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16),
              InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    Icon(Icons.reply, size: 16, color: Colors.grey),
                    SizedBox(width: 4),
                    Text(
                      'Responder',
                      style: GoogleFonts.montserrat(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (comment.respostas.isNotEmpty) ...[
            SizedBox(height: 12),
            ...comment.respostas.map((reply) => _buildComment(reply, isDark, isReply: true)),
          ],
        ],
      ),
    );
  }

  Widget _buildCommentInput(bool isDark) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.douradoTrigo,
              child: Text(
                'V',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: _commentController,
                focusNode: _focusNode,
                decoration: InputDecoration(
                  hintText: 'Adicione seu comentário...',
                  hintStyle: GoogleFonts.lora(fontSize: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: isDark ? Colors.grey[800] : Colors.grey[100],
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                style: GoogleFonts.lora(fontSize: 14),
              ),
            ),
            SizedBox(width: 8),
            IconButton(
              onPressed: () {
                if (_commentController.text.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Comentário enviado!')),
                  );
                  _commentController.clear();
                  _focusNode.unfocus();
                }
              },
              icon: Icon(Icons.send),
              color: AppColors.douradoTrigo,
            ),
          ],
        ),
      ),
    );
  }
}
