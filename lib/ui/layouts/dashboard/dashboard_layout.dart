import 'package:admin_dashboard/providers/sidemenu_provider.dart';
import 'package:admin_dashboard/ui/shared/navbar.dart';
import 'package:admin_dashboard/ui/shared/sidebar.dart';
import 'package:flutter/material.dart';

class DashBoardlayout extends StatefulWidget {
  final Widget child;
  
  const DashBoardlayout({Key? key, required this.child}) : super(key: key);

  @override
  State<DashBoardlayout> createState() => _DashBoardlayoutState();
}

class _DashBoardlayoutState extends State<DashBoardlayout> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SideMenuProvider.menuController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xffEDF1F2),
      body: Stack(
        children: [
          Row(
            children: [
              if(size.width >= 700)
                const Sidebar(),
              Expanded(
                child: Column(
                  children: [
                    const Navbar(),
                    Expanded(
                      child: widget.child,
                    )
                  ],
                ),
              )
            ],
          ),
          if(size.width < 700)
            AnimatedBuilder(
              animation: SideMenuProvider.menuController, builder: (context, _) => Stack(
                children: [
                  if(SideMenuProvider.isOpen)
                    AnimatedOpacity(
                      opacity: SideMenuProvider.opacity.value, 
                      duration: const Duration(milliseconds: 200),
                      child: GestureDetector(
                        onTap: () => SideMenuProvider.closeMenu(),
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Container(
                            width: size.width,
                            height: size.height,
                            color: Colors.black26,
                          ),
                        ),
                      ),
                    ),
                  Transform.translate(
                    offset: Offset(SideMenuProvider.movement.value, 0),
                    child: const Sidebar(),
                  )
                ],
              )
            )
        ],
      )
    );
  }
}