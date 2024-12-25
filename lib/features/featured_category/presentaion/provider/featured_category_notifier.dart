import 'package:fashion_app/features/featured_category/domain/repo/featured_category_repo.dart';
import 'package:fashion_app/features/featured_category/presentaion/provider/featured_category_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FeaturedCategoryNotifier extends StateNotifier<FeaturedCategoryState> {
  final FeaturedCategoryRepo featureRepo;

  FeaturedCategoryNotifier({required this.featureRepo})
      : super(FeatureLoading());

  //load featured
  Future<void> loadFeaturedCategories() async {
    try {
      //throw loader while loading categories
      state = FeatureLoading();
      //fetch featured category from data source api/firestore
      await Future.delayed(Duration.zero, () async {
        final featuredCategories = await featureRepo.getFeaturedCategories();
        //update category list
        state = FeatureLoaded(featuredCategories);
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
