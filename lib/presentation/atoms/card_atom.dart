import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:infinite_horizons/presentation/core/theme_data.dart';

class CardAtom extends StatelessWidget {
  const CardAtom({required this.child, this.onClick, this.image});

  final Widget child;
  final SvgPicture? image;
  final VoidCallback? onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Card.filled(
        margin: EdgeInsets.zero,
        clipBehavior: Clip.hardEdge,
        child: Column(
          children: [
            if (image != null)
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(15)),
                child: SizedBox(
                  height: 170,
                  width: double.infinity,
                  child: image,
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(AppThemeData.generalSpacing),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
