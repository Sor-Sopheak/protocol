import 'package:flutter/material.dart';
import 'package:protocol_app/constants/app_constants.dart';
import 'package:protocol_app/constants/color_constants.dart';
import 'package:protocol_app/constants/string_constants.dart';

class Navbar extends StatefulWidget implements PreferredSizeWidget {
  final int currentIndex;
  final Function(int) onSelectedRoute;

  const Navbar({
    super.key,
    required this.currentIndex,
    required this.onSelectedRoute,
  });

  @override
  State<Navbar> createState() => _NavbarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight * 3);
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kToolbarHeight * 3,
      child: Column(
        children: [
          Container(
            height: kToolbarHeight * 2,
            decoration: const BoxDecoration(
              color: Color(blueColor),
              border: Border(
                bottom: BorderSide(
                  color: Color(darkBlueColor),
                  width: 2,
                  strokeAlign: BorderSide.strokeAlignInside,
                ),
              ),
            ),
            padding: const EdgeInsets.only(left: 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(
                      'assets/images/mptc_logo.png',
                      width: 64,
                      height: 64,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 8),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appNameKh,
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(whiteColor),
                          ),
                        ),
                        Text(
                          appNameEn,
                          style: TextStyle(
                            fontSize: 15.9,
                            fontWeight: FontWeight.w600,
                            color: Color(whiteColor),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                IntrinsicHeight(
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      children: [
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {},
                            child: MenuAnchor(
                              builder: (BuildContext context,
                                  MenuController controller, Widget? child) {
                                return IconButton(
                                  icon: Image.asset(
                                    'assets/icons/cambodia_flag.png',
                                    width: 32,
                                    height: 24,
                                  ),
                                  onPressed: () {
                                    if (controller.isOpen) {
                                      controller.close();
                                    } else {
                                      controller.open();
                                    }
                                  },
                                );
                              },
                              menuChildren: <Widget>[
                                Column(
                                  children: [
                                    MenuItemButton(
                                      child: const Text('Khmer'),
                                      onPressed: () => {},
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          margin: const EdgeInsets.only(right: 12),
                          child: const VerticalDivider(
                            color: Color(whiteColor),
                            thickness: 1,
                            endIndent: 0,
                          ),
                        ),
                        IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: const Color(whiteColor),
                                      ),
                                    ),
                                    child: Image.asset(
                                      'assets/icons/person.png',
                                      width: 24,
                                      height: 24,
                                    ),
                                  ),
                                ),
                              ),
                              MenuAnchor(
                                builder: (BuildContext context,
                                    MenuController controller, Widget? child) {
                                  return IconButton(
                                    icon: Image.asset(
                                      'assets/icons/chevron_down.png',
                                      width: 24,
                                      height: 24,
                                    ),
                                    onPressed: () {
                                      if (controller.isOpen) {
                                        controller.close();
                                      } else {
                                        controller.open();
                                      }
                                    },
                                  );
                                },
                                menuChildren: <Widget>[
                                  Column(
                                    children: [
                                      MenuItemButton(
                                        child: const Row(
                                          children: [
                                            Icon(Icons.person, size: 20),
                                            SizedBox(width: 8),
                                            Text('Username'),
                                          ],
                                        ),
                                        onPressed: () => {},
                                      ),
                                      MenuItemButton(
                                        child: const Row(
                                          children: [
                                            Icon(Icons.logout, size: 20),
                                            SizedBox(width: 8),
                                            Text('Logout'),
                                          ],
                                        ),
                                        onPressed: () => {},
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: kToolbarHeight,
            decoration: const BoxDecoration(
              color: Color(blueColor),
              border: Border(
                bottom: BorderSide(
                  color: Color(darkBlueColor),
                  width: 2,
                  strokeAlign: BorderSide.strokeAlignInside,
                ),
              ),
            ),
            child: Row(
              children: [
                const SizedBox(width: 60),
                Expanded(
                  child: Row(
                    children: List.generate(
                      navItems.length,
                      (index) {
                        final item = navItems[index];
                        return MouseRegion(
                          onEnter: (_) => {},
                          onExit: (_) => {},
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 14),
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              color: widget.currentIndex == index
                                  ? const Color(darkBlueColor)
                                  : Colors.transparent,
                            ),
                            child: TextButton(
                              onPressed: () => widget.onSelectedRoute(index),
                              style: TextButton.styleFrom(
                                foregroundColor: const Color(whiteColor),
                                overlayColor: Colors.transparent,
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              child: Text(item.title),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
