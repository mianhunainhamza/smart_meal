import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class QuickScreenAppbar extends StatelessWidget {
  const QuickScreenAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: IconButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.onPrimary.withOpacity(.2),
            fixedSize: const Size(50, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          color: Colors.black,
          icon: const Icon(CupertinoIcons.chevron_back),
        ),
        const Spacer(),
        Text(
          "Quick & Fast",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary.withOpacity(.9),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {},
          style: IconButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.onPrimary.withOpacity(.2),
            fixedSize: const Size(50, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          color: Colors.black,
          icon: const Icon(Iconsax.notification),
        ),
      ],
    );
  }
}
