// import 'package:flutter/material.dart';
// import 'package:barcode_scan2/barcode_scan2.dart';
//
// class InventoryManagementScreen extends StatefulWidget {
//   const InventoryManagementScreen({super.key});
//
//   @override
//   InventoryManagementScreenState createState() => InventoryManagementScreenState();
// }
//
// class InventoryManagementScreenState extends State<InventoryManagementScreen> {
//   String _scanResult = 'Scan a code';
//
//   Future<void> _scanQR() async {
//     try {
//       final result = await BarcodeScanner.scan();
//       setState(() {
//         _scanResult = result.rawContent;
//       });
//     } catch (e) {
//       setState(() {
//         _scanResult = 'Error: ${e.toString()}';
//       });
//     }
//   }
//
//   Future<void> _scanBarcode() async {
//     try {
//       final result = await BarcodeScanner.scan();
//       setState(() {
//         _scanResult = result.rawContent;
//       });
//     } catch (e) {
//       setState(() {
//         _scanResult = 'Error: ${e.toString()}';
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Inventory Management'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             ElevatedButton(
//               onPressed: _scanQR,
//               child: const Text('Scan QR Code'),
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _scanBarcode,
//               child: const Text('Scan Barcode'),
//             ),
//             const SizedBox(height: 16),
//             Text('Scan Result: $_scanResult'),
//             const SizedBox(height: 16),
//             Expanded(
//               child: ListView(
//                 children: const [
//                    ListTile(
//                     title: Text('Item 1'),
//                     subtitle: Text('Details of item 1'),
//                   ),
//                    ListTile(
//                     title: Text('Item 2'),
//                     subtitle: Text('Details of item 2'),
//                   ),
//                   // Add more items here
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
