import 'package:fashion_app/core/constants/app_text.dart';
import 'package:fashion_app/core/constants/progress_indicator.dart';
import 'package:fashion_app/features/home/presentation/provider/category_provider.dart';
import 'package:fashion_app/features/home/presentation/provider/category_state.dart';
import 'package:fashion_app/features/home/presentation/widgets/category_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryView extends ConsumerWidget {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryState = ref.watch(categoryProvider);

    return SizedBox(
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          AppText(
            text: "Categories",
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
          categoryState is CategoryLoaded
              ? const AppLoadingIndicator()
              : categoryState is CategoryLoaded
                  ? ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: categoryState.category.length,
                      itemBuilder: (context, index) {
                        final category = categoryState.category[index];

                        return Column(
                          spacing: 5.0,
                          children: [
                            CategoryImage(
                              image: category.image,
                              onTap: () {},
                            ),
                            AppText(text: category.name)
                          ],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(
                        width: 10,
                      ),
                    )
                  : categoryState is CategoryError
                      ? Center(
                          child: AppText(text: categoryState.message),
                        )
                      : const SizedBox(),
        ],
      ),
    );
  }
}
