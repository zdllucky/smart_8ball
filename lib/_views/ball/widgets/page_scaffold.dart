import 'dart:ui';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_8ball/_support/di/__.dart';
import 'package:smart_8ball/_widgets/common/__.dart';

import '../logic/ball_action/ball_action_bloc.dart';

class PageScaffold extends StatefulWidget {
  PageScaffold({super.key, required this.child});

  final Widget child;

  @override
  State<PageScaffold> createState() => _PageScaffoldState();
}

class _PageScaffoldState extends State<PageScaffold>
    with SingleTickerProviderStateMixin {
  final GlobalKey _navBarKey = GlobalKey();
  late AnimationController _controller;
  late Animation<double> _blurXAnimation;
  late Animation<double> _blurYAnimation;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 260),
        reverseDuration: const Duration(milliseconds: 260));
    final ca = CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
        reverseCurve: Curves.easeOut);

    _blurXAnimation = Tween<double>(begin: 0, end: 20).animate(ca);
    _blurYAnimation = Tween<double>(begin: 0, end: 10).animate(ca);
    _controller.addListener(() => setState(() {}));

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider<BallActionBloc>(
        create: (context) => get(),
        child: BlocConsumer<BallActionBloc, BallActionState>(
          listener: (context, state) {
            if (state is BallActionWriting) {
              _controller.forward(from: 0);
            } else {
              _controller.reverse(from: 1);
            }
          },
          listenWhen: (previous, current) =>
              previous is! BallActionWriting && current is BallActionWriting ||
              previous is BallActionWriting && current is! BallActionWriting,
          builder: (context, state) => CupertinoPageScaffold(
            resizeToAvoidBottomInset: false,
            child: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  Color(0xff151421),
                  Color(0xff151421),
                  Color(0xff1D150F),
                  Color(0xff22170C)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )),
              child: Stack(
                children: [
                  CustomScrollView(
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    slivers: [
                      ThemedCSNavigationBar(
                        key: _navBarKey,
                        middleText: 'Ponder8',
                        largeTitleText: 'Mighty Ball  ',
                        leading: IgnorePointer(
                          ignoring: state is! BallActionInitial,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const CupertinoButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: null,
                                  child: Icon(
                                      FluentIcons.reading_list_24_regular)),
                              if (kDebugMode)
                                CupertinoButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () =>
                                        context.push('/dev-playground'),
                                    child: const Icon(
                                        FluentIcons.code_24_regular)),
                            ],
                          ),
                        ),
                        trailing: IgnorePointer(
                          ignoring: state is! BallActionInitial,
                          child: CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: () => context.push('/profile'),
                              child: const Icon(
                                FluentIcons.person_48_regular,
                              )),
                        ),
                      ),
                      SliverFillRemaining(
                        fillOverscroll: true,
                        hasScrollBody: false,
                        child: widget.child,
                      )
                    ],
                  ),
                  Positioned.fromRect(
                    rect: Rect.fromLTWH(
                      0,
                      0,
                      MediaQuery.of(context).size.width,
                      (_navBarKey.currentContext
                                  ?.findRenderObject()
                                  ?.paintBounds
                                  .size
                                  .height ??
                              0) +
                          15,
                    ),
                    child: ClipRRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                            sigmaX: _blurXAnimation.value,
                            sigmaY: _blurYAnimation.value,
                            tileMode: TileMode.clamp),
                        child: Container(),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
}
