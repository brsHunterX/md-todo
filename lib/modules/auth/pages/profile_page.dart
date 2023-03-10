import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:md_todo/modules/auth/routes.dart';
import 'package:md_todo/modules/auth/stores/auth.store.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthStore _store = AuthStore();

  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Text('Profile'),
    );
  }

  Widget _buildPersonTile() {
    return ListTile(
      leading: _store.account?.hasAvatar ?? false
        ? CircleAvatar(
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          backgroundColor: Theme.of(context).colorScheme.primary,
          backgroundImage: NetworkImage(_store.account?.avatar ?? ''),
        )
        : CircleAvatar(
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Text(_store.account?.shortName ?? ''),
        ),
      title: Text(_store.account?.fullName ?? ''),
      subtitle: Text(_store.account?.email ?? ''),
    );
  }

  // Widget _buildThemeTile() {
  //   return ListTile(
  //     leading: Theme.of(context).brightness == Brightness.dark
  //       ? const Icon(Icons.dark_mode_outlined)
  //       : const Icon(Icons.light_mode_outlined),
  //     title: const Text('Theme'),
  //     subtitle: const Text('Change theme colors.'),
  //     onTap: () => showDialog(
  //       context: context,
  //       builder: (BuildContext context) => const ThemeDialog()
  //     ),
  //   );
  // }

  Widget _buildAboutTile() {
    return ListTile(
      leading: const Icon(Icons.info_outline_rounded),
      title: const Text('Application'),
      subtitle: const Text('More informations about app.'),
      onTap: () {
        showAboutDialog(
          context: context,
          applicationIcon: CircleAvatar(
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: const Text('T'),
          ),
          applicationName: 'Todo',
          applicationVersion: 'V1.0.0',
          applicationLegalese: 'A ToDo app created in Flutter for case study.',
        );
      },
    );
  }

  Widget _buildSignOutTile() {
    return ListTile(
      leading: const Icon(Icons.logout_rounded),
      title: const Text('Sign out'),
      subtitle: const Text('Terminate session.'),
      onTap: () async {
        Navigator.of(context).pushNamed(AuthRoutes.AUTH_ONBOARDING);
        _store.signOut();
      }
    );
  }

  Widget _buildBody() {
    return Observer(
      builder: (BuildContext _) => RefreshIndicator(
        onRefresh: _store.me,
        child: ListView(
          children: [
            _buildPersonTile(),
            const Divider(),
            // _buildThemeTile(),
            _buildAboutTile(),
            _buildSignOutTile(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }
}
