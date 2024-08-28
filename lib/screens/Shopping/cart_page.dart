import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_meal/widgets/custom_snackbar.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../core/store.dart';
import '../../models/cart.dart';
import 'delivery_details.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(.9),
        title: "Cart".text.xl3.center.make().pOnly(top: 7),
      ),
      body: Column
        (
        children: [
          _CartList().p32().expand(),
          const Divider(),
          const _CardTotal(),
        ],
      ),
    );
  }
}
class _CardTotal extends StatelessWidget {
  const _CardTotal();

  @override
  Widget build(BuildContext context) {
    final CartModel cart = (VxState.store as MyStore).cart;
    VxState.watch(context, on: [RemoveMutation]);
    return  SizedBox(
      height: 200,
      child:cart.items.isEmpty ? " ".text.make(): Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          "€${cart.totalPrice}".text.color(context.theme.colorScheme.secondary).xl3.make(),
          30.widthBox,
          ElevatedButton(
              onPressed: (){
                Navigator.push(context,CupertinoPageRoute(builder: (c)=> const DetailsPage() ));
              },
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.onSecondary),
            shape: WidgetStateProperty.all(const StadiumBorder())
          ), child: "Confirm".text.xl2.black.fontWeight(FontWeight.w300).make(),).wh(130, 45)
        ],
      ),
    );
  }
}
class _CartList extends StatelessWidget {
  final CartModel _cart = (VxState.store as MyStore).cart;
  @override
  Widget build(BuildContext context) {
    VxState.watch(context, on: [RemoveMutation]);

    return _cart.items.isEmpty ? "Nothing to Show here".text.xl.makeCentered(): ListView.builder(
        itemCount: _cart.items.length,
        itemBuilder: (context,index){
          return ListTile(
            leading: const Icon(Icons.done),
            trailing: IconButton(
              icon: const Icon(Icons.remove_circle_outline), onPressed: () {
              CustomSnackbar.showSnackBar('Oh No','Item has been Removed',const Icon(Icons.warning_amber),Theme.of(context).colorScheme.primary.withOpacity(1),context);
                RemoveMutation(_cart.items[index]);
            },
            ),
            title: Text(_cart.items[index].name.toString()),
          );
        });
  }
}