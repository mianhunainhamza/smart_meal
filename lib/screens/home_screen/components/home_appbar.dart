import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "What are you\ncooking today?",
          style: TextStyle(
            fontSize: 26,
            color: Theme.of(context).colorScheme.onPrimary.withOpacity(.8),
            fontWeight: FontWeight.bold,
            height: 1.4,
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {},
          style: IconButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            backgroundColor:
            Theme.of(context).colorScheme.onPrimary.withOpacity(.2),
            fixedSize: const Size(50, 50),
          ),
          icon: const Icon(Iconsax.notification),
        ),
      ],
    );
  }
}
