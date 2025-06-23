import 'package:flutter/material.dart';

class Pager extends StatefulWidget {
  const Pager({
    super.key,
    required this.itemBuilder,
    required this.length,
    required this.index,
    this.onIndexChanged,
  });

  final Widget Function(BuildContext context, int index) itemBuilder;
  final int length;
  final int index;
  final ValueChanged<int>? onIndexChanged;

  @override
  State<Pager> createState() => _PagerState();
}

class _PagerState extends State<Pager> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(
      length: widget.length,
      initialIndex: widget.index,
      vsync: this,
    );
    _tabController?.addListener(_indexChanged);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant Pager oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.length != widget.length) {
      _tabController?.dispose();
      _tabController = TabController(
        length: widget.length,
        initialIndex: widget.index,
        vsync: this,
      );
      _tabController?.addListener(_indexChanged);
    }
    if (_tabController?.index != widget.index) {
      _tabController?.index = widget.index;
    }
    setState(() {});
  }

  void _indexChanged() {
    widget.onIndexChanged?.call(_tabController!.index);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: TabBarView(
            key: const ValueKey('pager'),
            controller: _tabController,
            children:
                List.generate(widget.length, (index) => index).map((index) {
                  return widget.itemBuilder(context, index);
                }).toList(),
          ),
        ),
      ],
    );
  }
}
