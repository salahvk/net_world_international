import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:net_world_international/core/color_manager.dart';

class PrintPage extends StatefulWidget {
  // final List<Map<String, dynamic>> data;
  const PrintPage({super.key});

  @override
  _PrintPageState createState() => _PrintPageState();
}

class _PrintPageState extends State<PrintPage> {
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
  List<BluetoothDevice> _devices = [];
  String _devicesMsg = "";
  // final f = NumberFormat("\$###,###.00", "en_US");

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => {initPrinter()});
  }

  Future<void> initPrinter() async {
    bluetoothPrint.startScan(timeout: const Duration(seconds: 2));

    if (!mounted) return;
    bluetoothPrint.scanResults.listen(
      (val) {
        if (!mounted) return;
        setState(() => {_devices = val});
        if (_devices.isEmpty) {
          setState(() {
            _devicesMsg = "No Devices";
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Printer'),
        backgroundColor: Colormanager.primary,
      ),
      body: _devices.isEmpty
          ? Center(
              child: Text(_devicesMsg),
            )
          : ListView.builder(
              itemCount: _devices.length,
              itemBuilder: (c, i) {
                return ListTile(
                  leading: const Icon(Icons.print),
                  title: Text(_devices[i].name ?? ''),
                  subtitle: Text(_devices[i].address ?? ''),
                  onTap: () {
                    _startPrint(_devices[i]);
                  },
                );
              },
            ),
    );
  }

  Future<void> _startPrint(BluetoothDevice device) async {
    if (device.address != null) {
      await bluetoothPrint.connect(device);

      // Map<String, dynamic> config = {};
      List<LineText> list = [];
      List<int> bytes = [];

      list.add(
        LineText(
          type: LineText.TYPE_TEXT,
          content: "ERP App",
          weight: 2,
          width: 2,
          height: 2,
          align: LineText.ALIGN_CENTER,
          linefeed: 1,
        ),
      );

      // for (var i = 0; i < widget.data.length; i++) {
      //   list.add(
      //     LineText(
      //       type: LineText.TYPE_TEXT,
      //       content: widget.data[i]['title'],
      //       weight: 0,
      //       align: LineText.ALIGN_LEFT,
      //       linefeed: 1,
      //     ),
      //   );

      //   list.add(
      //     LineText(
      //       type: LineText.TYPE_TEXT,
      //       content:
      //           "${f.format(widget.data[i]['price'])} x ${widget.data[i]['qty']}",
      //       align: LineText.ALIGN_LEFT,
      //       linefeed: 1,
      //     ),
      //   );
      // }
      final profile = await CapabilityProfile.load();
      final generator = Generator(PaperSize.mm80, profile);
      final List<int> barData = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 4];
      generator.barcode(Barcode.upcA(barData));
      bytes += generator.text('Printed',
          styles: const PosStyles(align: PosAlign.center), linesAfter: 1);
    }
  }
}
