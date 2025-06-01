import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagi_news/features/home/tab/category_item.dart';
import 'package:kagi_news/features/home/tab/category_tab_bloc.dart';
import 'package:kagi_news/models/cluster.dart';

class CategoryTab extends StatelessWidget {
  const CategoryTab({super.key, required this.onSelected});

  final void Function(List<Cluster> clusters, int index) onSelected;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryTabBloc, CategoryTabState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: ListView.separated(
              itemBuilder:
                  (context, index) => CategoryItem(
                    cluster: state.clusters[index],
                    onTap: () => onSelected(state.clusters, index),
                  ),
              separatorBuilder:
                  (context, index) => const Divider(height: 1, indent: 16, endIndent: 16),
              itemCount: state.clusters.length,
            ),
          ),
        );
      },
    );
  }
}
