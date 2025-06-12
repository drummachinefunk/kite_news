import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagi_news/features/category_tab/components/category_list_tile.dart';
import 'package:kagi_news/features/category_tab/category_tab_bloc.dart';
import 'package:kagi_news/models/cluster.dart';

class CategoryTab extends StatelessWidget {
  const CategoryTab({super.key, required this.onSelected});

  final void Function(List<Cluster> clusters, int index) onSelected;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryTabBloc, CategoryTabState>(
      builder: (context, state) {
        switch (state) {
          case CategoryTabStateError(:final message):
            return Center(child: Text(message));
          case CategoryTabStateLoaded(:final clusters):
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child:
                  clusters.isEmpty
                      ? Container()
                      : ListView.separated(
                        itemBuilder:
                            (context, index) => CategoryListTile(
                              cluster: state.clusters[index],
                              onTap: () => onSelected(state.clusters, index),
                            ),
                        separatorBuilder:
                            (context, index) => const Divider(height: 1, indent: 16, endIndent: 16),
                        itemCount: state.clusters.length,
                      ),
            );
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
