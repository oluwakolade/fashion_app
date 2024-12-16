import 'package:fashion_app/features/home/domain/entities/category.dart';

abstract class CategoryState {}

//loading

class CategoryLoading extends CategoryState {}

//loaded
class CategoryLoaded extends CategoryState {
  final List<Category> category;

  CategoryLoaded(this.category);
}

class CategoryError extends CategoryState {
  final String message;

  CategoryError(this.message);
}
