class Model3D {
  final String id;
  final String name;
  final String imagePath;
  final String category;
  final String p3dUrl;
  double averageRating; 
  Model3D({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.category,
    required this.p3dUrl,
    this.averageRating = 0.0, 
  });
}