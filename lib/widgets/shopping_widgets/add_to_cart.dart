import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../core/store.dart';
import '../../models/cart.dart';
import '../../models/catalog.dart';
import '../custom_snackbar.dart';

class AddToCart extends StatelessWidget {
  final Item catalog;
   const AddToCart({
    super.key, required this.catalog,
  });
  @override
  Widget build(BuildContext context)
  {
    VxState.watch(context, on: [AddMutation,RemoveMutation]);
    final CartModel _cart= (VxState.store as MyStore).cart;
    bool isInCart= _cart.items.contains(catalog)??false;
    return ElevatedButton(
        onPressed: (){
          if(!isInCart)
          {
            AddMutation(catalog);
            CustomSnackbar.showSnackBar('Great!','Item has been Added',const Icon(Iconsax.happyemoji),Theme.of(context).colorScheme.primary.withOpacity(1),context);

          }
          else {
            CustomSnackbar.showSnackBar('Oh','Item already added',const Icon(Icons.warning_amber),Theme.of(context).colorScheme.primary.withOpacity(1),context);
          }
        },
        style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.onSecondary),shape: WidgetStateProperty.all(const StadiumBorder())
        ),
        child: isInCart ? Icon(Icons.done,color: Theme.of(context).colorScheme.primary,): const Icon(CupertinoIcons.cart_badge_plus,color: Colors.black,));
  }
}