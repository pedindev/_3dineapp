import '../models/model_3d.dart';

// Lista de modelos com URLs do p3d.in
final List<Model3D> predefinedModels = [
  Model3D(
    id: 'tenis_azul',
    name: 'Tênis Azul',
    imagePath: 'assets/images/tenis_azul.jpg',
    category: 'calcados',
    p3dUrl: 'https://p3d.in/k1Tzq',
  ),
  Model3D(
    id: 'caixa_enlatado',
    name: 'Caixa de Enlatados',
    imagePath: 'assets/images/caixa_enlatados.jpg',
    category: 'caixas',
    p3dUrl: 'https://p3d.in/zs82J',
  ),
  Model3D(
    id: 'prato_cuscuz',
    name: 'Prato de Cuscuz com Ovo',
    imagePath: 'assets/images/prato_cuscuz.jpg',
    category: 'comidas', 
    p3dUrl: 'https://p3d.in/ea0x9',
  ),
  Model3D(
    id: 'copo_mcdonalds',
    name: 'Copo do McDonald\'s',
    imagePath: 'assets/images/copo_mcdonalds.jpg',
    category: 'utensilios',
    p3dUrl: 'https://p3d.in/SXJ7B',
  ),
];