import 'package:flutter/material.dart';

class ScreenBuilder extends StatelessWidget {
  final Widget? header;
  final Widget content;
  final Widget? footer;
  final bool useSliverContent;
  final ScrollPhysics? overridePhysics;
  final Widget? searchField;

  const ScreenBuilder({
    super.key,
    this.header,
    required this.content,
    this.footer,
    this.useSliverContent = false,
    this.overridePhysics,
    this.searchField,
  });

  @override
  Widget build(BuildContext context) {
    final Widget sliverContent =
        useSliverContent ? content : SliverToBoxAdapter(child: content);

    final Widget? footerSection = footer != null
        ? SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: footer,
            ),
          )
        : null;

    final PreferredSizeWidget? searchSection = searchField != null
        ? PreferredSize(
            preferredSize: const Size.fromHeight(70.0),
            child: searchField!,
          )
        : null;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final physics = overridePhysics ??
              (constraints.maxHeight < 600
                  ? const AlwaysScrollableScrollPhysics()
                  : const NeverScrollableScrollPhysics());

          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: CustomScrollView(
              physics: physics,
              slivers: [
                SliverAppBar(
                  surfaceTintColor: Colors.white,
                  //pinned: true,
                  // floating: true,
                  // snap: true,
                  automaticallyImplyLeading: false,
                  title: header,
                  bottom: searchSection,
                ),
                sliverContent,
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: footerSection,
    );
  }
}
