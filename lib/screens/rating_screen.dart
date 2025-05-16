import 'package:flutter/material.dart';
import '../models/model_3d.dart';
import '../models/rating.dart';
import '../services/rating_service.dart';

class RatingScreen extends StatefulWidget {
  final Model3D model;

  const RatingScreen({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  _RatingScreenState createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  final TextEditingController _nameController = TextEditingController();
  int _selectedRating = 3; // Valor padrão
  List<Rating> _ratings = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRatings();
  }

  Future<void> _loadRatings() async {
    setState(() {
      _isLoading = true;
    });
    
    final ratings = await RatingService.getRatingsForModel(widget.model.id);
    
    setState(() {
      _ratings = ratings;
      _isLoading = false;
    });
  }

  Future<void> _submitRating() async {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, insira seu nome')),
      );
      return;
    }

    final newRating = Rating(
      modelId: widget.model.id,
      userName: _nameController.text.trim(),
      score: _selectedRating,
      date: DateTime.now(),
    );

    await RatingService.saveRating(newRating);
    
    // Atualizar avaliações
    await _loadRatings();
    
    // Limpar campos
    _nameController.clear();
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Avaliação enviada com sucesso!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Avaliações: ${widget.model.name}'),
        backgroundColor: const Color(0xFF336633),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Seção para adicionar avaliação
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Adicionar avaliação',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Campo de nome
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Seu nome',
                        border: OutlineInputBorder(),
                      ),
                      maxLength: 50, // Limite de caracteres
                    ),
                    const SizedBox(height: 16),
                    
                    // Rating stars
                    const Text('Sua avaliação:'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return IconButton(
                          icon: Icon(
                            index < _selectedRating
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.amber,
                            size: 36,
                          ),
                          onPressed: () {
                            setState(() {
                              _selectedRating = index + 1;
                            });
                          },
                        );
                      }),
                    ),
                    
                    // Botão de enviar
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _submitRating,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF336633),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text('Enviar Avaliação'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Lista de avaliações
            const Text(
              'Avaliações anteriores',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _ratings.isEmpty
                      ? const Center(child: Text('Nenhuma avaliação ainda'))
                      : ListView.builder(
                          itemCount: _ratings.length,
                          itemBuilder: (context, index) {
                            final rating = _ratings[index];
                            return Card(
                              margin: const EdgeInsets.only(bottom: 8),
                              child: ListTile(
                                title: Text(rating.userName),
                                subtitle: Text(
                                  'Data: ${_formatDate(rating.date)}',
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: List.generate(5, (starIndex) {
                                    return Icon(
                                      starIndex < rating.score
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: Colors.amber,
                                      size: 20,
                                    );
                                  }),
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
  
  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
  
  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}