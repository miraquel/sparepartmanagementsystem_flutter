import 'package:flutter/material.dart';

class AdminCenter extends StatefulWidget {
  const AdminCenter({super.key});

  @override
  State<AdminCenter> createState() => _AdminCenterState();
}

class _AdminCenterState extends State<AdminCenter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Master'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/user');
            },
            title: const Text('User'),
            subtitle: const Text('User management'),
            leading: const SizedBox(
              height: double.infinity,
              child: Icon(Icons.person, size: 30)
            ),
            minLeadingWidth: 0,
            leadingAndTrailingTextStyle: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/role');
            },
            title: const Text('Role'),
            subtitle: const Text('Role management'),
            leading: const SizedBox(
              height: double.infinity,
              child: Icon(Icons.supervisor_account_rounded, size: 30)
            ),
            minLeadingWidth: 0,
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/numberSequence');
            },
            title: const Text('Number Sequence'),
            subtitle: const Text('Number Sequence management'),
            leading: const SizedBox(
              height: double.infinity,
              child: Icon(Icons.format_list_numbered, size: 30)
            ),
            minLeadingWidth: 0,
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/rowLevelAccessList');
            },
            title: const Text('Row Level Access'),
            subtitle: const Text('Row Level Access management'),
            leading: const SizedBox(
              height: double.infinity,
              child: Icon(Icons.table_rows, size: 30)
            ),
            minLeadingWidth: 0,
          ),
        ],
      ),
    );
  }
}
