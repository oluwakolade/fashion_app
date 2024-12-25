import 'package:fashion_app/features/featured_category/data/firebase_featured_category_repo.dart';
import 'package:fashion_app/features/featured_category/presentaion/provider/featured_category_notifier.dart';
import 'package:fashion_app/features/featured_category/presentaion/provider/featured_category_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final featureProvider =
    StateNotifierProvider<FeaturedCategoryNotifier, FeaturedCategoryState>(
        (ref) {
  final featureRepo = FirebaseFeaturedCategoryRepo();
  return FeaturedCategoryNotifier(featureRepo: featureRepo);
});
