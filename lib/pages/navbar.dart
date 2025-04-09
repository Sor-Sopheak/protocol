import 'package:flutter/material.dart';
import 'package:protocol_app/constants/app_constants.dart';

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
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _NavbarState extends State<Navbar> {
  final Map<int, bool> _isHovered = {};
  final FocusNode _buttonFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Expanded(
            child: Row(
              children: List.generate(
                navItems.length,
                (index) {
                  final item = navItems[index];
                  return MouseRegion(
                    onEnter: (_) => setState(() => _isHovered[index] = true),
                    onExit: (_) => setState(() => _isHovered[index] = false),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: widget.currentIndex == index
                            ? Colors.black
                            : Colors.transparent,
                      ),
                      child: TextButton(
                        onPressed: () => widget.onSelectedRoute(index),
                        style: TextButton.styleFrom(
                          foregroundColor: widget.currentIndex == index ||
                                  (_isHovered[index] ?? false)
                              ? Colors.white
                              : Colors.black,
                          overlayColor: Colors.transparent,
                        ),
                        child: Text(
                          item.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: 16),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {},
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      MenuAnchor(
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
                              setState(() {});
                            },
                          );
                        },
                        childFocusNode: _buttonFocusNode,
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
