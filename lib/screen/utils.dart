import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class DeviceTile extends StatelessWidget {
  final String name;
  final String id;
  final VoidCallback? connect;

  const DeviceTile(this.name, this.id, this.connect, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(name),
            subtitle: Text(id),
            trailing: TextButton(
              onPressed: connect,
              child: const Text("Connect"),
            ),
          ),
        ],
      ),
    );
  }
}
