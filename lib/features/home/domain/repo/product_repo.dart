import 'package:fashion_app/features/home/domain/entities/products.dart';

abstract class ProductRepo {
  Future<List<Products>> fetchAllProducts();
  Future<void> toggleFavorite();
}

// abstract class PostRepo {
//   Future<List<Post>> fetchAllPosts();
//   Future<void> createPost(Post post);
//   Future<void> deletePost(String postId);
//   Future<List<Post>> fetchPostsByUid(String userId);
//   Future<void> toggleLikePost(String postId, String userId);
//   Future<void> addComment(String postId, Comment comment);
//   Future<void> deleteComment(String postId, String commentId);
// }
