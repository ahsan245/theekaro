import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:theek_karo/api/api_service.dart';
import 'package:theek_karo/application/notifier/tech_filter_notifier.dart';
import 'package:theek_karo/application/notifier/tech_notifier.dart';
import 'package:theek_karo/application/state/tech_state.dart';
import 'package:theek_karo/models/category.dart';
import 'package:theek_karo/models/pagination.dart';
import 'package:theek_karo/models/tech.dart';
import 'package:theek_karo/models/tech_filter.dart';
import 'package:theek_karo/widgets/widget_home_categories.dart';

final categoriesProvider =
    FutureProvider.family<List<Category>?, PaginationModel>(
  (ref, paginationModel) {
    final apiRepository = ref.watch(apiService);

    return apiRepository.getCategories(
        paginationModel.page, paginationModel.pageSize);
  },
);

final homeTechProvider = FutureProvider.family<List<Tech>?, TechFilterModel>(
  (ref, techFilterModel) {
    final apiRepository = ref.watch(apiService);
    return apiRepository.getTechs(techFilterModel);
  },
);

final techsFilterProvider =
    StateNotifierProvider<TechsFilterNotifier, TechFilterModel>(
  (ref) => TechsFilterNotifier(),
);

final techsNotifierProvider = StateNotifierProvider<TechNotifier, TechsState>(
  (ref) => TechNotifier(
    ref.watch(apiService),
    ref.watch(techsFilterProvider),
  ),
);
