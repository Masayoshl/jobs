import 'package:flutter/material.dart';

class ScreenBuilder extends StatelessWidget {
  final Widget? appBarWidget;
  final Widget bodyWidget;
  final Widget? bottomWidget;
  const ScreenBuilder({
    super.key,
    this.appBarWidget,
    required this.bodyWidget,
    required this.bottomWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        final physics = constraints.maxHeight < 600
            ? const AlwaysScrollableScrollPhysics()
            : const NeverScrollableScrollPhysics();

        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: CustomScrollView(
            physics: physics,
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                title: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: appBarWidget,
                ),
              ),
              SliverToBoxAdapter(child: bodyWidget),
            ],
          ),
        );
      }),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: bottomWidget,
        ),
      ),
      extendBody: true,
      //extendBodyBehindAppBar: true,
    );
  }
}
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     //resizeToAvoidBottomInset: true,
  //     appBar: AppBar(
  //       automaticallyImplyLeading: false,
  //       scrolledUnderElevation: 0,
  //       backgroundColor: Colors.white,
  //       title: appBarWidget,
  //     ),
  //     bottomNavigationBar: SafeArea(
  //       child: Padding(
  //         padding: const EdgeInsets.only(bottom: 10.0),
  //         child: bottomWidget,
  //       ),
  //     ),
  //     body: SingleChildScrollView(
  //       padding:
  //           EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top + 20),
  //       child: bodyWidget,
  //     ),
  //   );
  // }
// }
