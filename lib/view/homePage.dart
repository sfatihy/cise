import 'package:flutter/material.dart';
import 'package:cise/product/iconConstants.dart';
import 'package:cise/product/imageConstants.dart';
import 'package:cise/product/localeKeys.dart';
import 'package:cise/view/cardPage.dart';
import 'package:cise/view/profilePage.dart';
import 'package:cise/widget/CustomSnackBar.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _widgets = [const CardPage(), ProfilePage()];

  Uri _url = Uri.parse("https://github.com/sfatihy/cise_privacy/blob/main/privacy_policy.md");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 50,
          child: Image.asset(ImageConstants.logoName)
        ),
      ),
      body: _widgets[_selectedIndex],
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Image.asset(ImageConstants.logo)
            ),
            ListTile(
              trailing: IconConstants.gamesIcon,
              title: Text(LocaleKeys.gameSpace.value),
              onTap: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  CustomSnackBar(text: LocaleKeys.notAvailable.value)
                );
              },
            ),
            ListTile(
              trailing: IconConstants.collectionsIcon,
              title: Text(LocaleKeys.collections.value),
              onTap: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                    CustomSnackBar(text: LocaleKeys.notAvailable.value)
                );
              },
            ),
            ListTile(
              trailing: IconConstants.booksIcon,
              title: Text(LocaleKeys.books.value),
              onTap: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                    CustomSnackBar(text: LocaleKeys.notAvailable.value)
                );
              },
            ),
            ListTile(
              trailing: IconConstants.weeklyReport,
              title: Text(LocaleKeys.weeklyReport.value),
              onTap: () {
                Navigator.pushNamed(context, '/weekly');
              },
            ),
            ListTile(
              trailing: IconConstants.randomIcon,
              title: Text(LocaleKeys.randomWords.value),
              onTap: () {
                Navigator.pushNamed(context, '/random');
              },
            ),
            Divider(),
            ListTile(
              trailing: IconConstants.settingsIcon,
              title: Text(LocaleKeys.settings.value),
              onTap: () {
                Navigator.pushNamed(context, '/settings');
              },
            ),
            ListTile(
              trailing: IconConstants.infoIcon,
              title: Text(LocaleKeys.info.value),
              onTap: () {
                Navigator.pushNamed(context, '/info');
              },
            ),
            ListTile(
              trailing: IconConstants.privacyPolicyIcon,
              title: Text(LocaleKeys.privacyPolicy.value),
              onTap: () async {
                if (!await launchUrl(_url)) {
                  throw Exception('Could not launch ${_url.path}');
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: IconConstants.floatingActionButtonIcon,
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(icon: IconConstants.cardIcon, label: LocaleKeys.card.value),
          NavigationDestination(icon: IconConstants.personIcon, label: LocaleKeys.person.value),
        ],
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int value) {
          setState(() {
            _selectedIndex = value;
          });
        },
      ),
    );
  }
}
