import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ReferencesView extends StatefulWidget {
  const ReferencesView({super.key});

  @override
  State<ReferencesView> createState() => _ReferencesViewState();
}

class _ReferencesViewState extends State<ReferencesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("References"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _sectionTitle("Fonts"),
            _referenceTile(
              icon: Icons.font_download_outlined,
              title: "Oooh Baby",
              subtitle: "Google Fonts",
              url: "https://fonts.google.com/specimen/Oooh+Baby",
            ),
            _referenceTile(
              icon: Icons.font_download_outlined,
              title: "Birthstone",
              subtitle: "Google Fonts",
              url: "https://fonts.google.com/specimen/Birthstone",
            ),

            const SizedBox(height: 24),

        _sectionTitle("Background Images"),

        _referenceTile(
          icon: Icons.image_outlined,
          title: "Login View Background",
          subtitle: "Moon on an afterglow background — Pexels",
          url: "https://www.pexels.com/photo/moon-on-an-afterglow-background-3070339/",
        ),

        _referenceTile(
          icon: Icons.image_outlined,
          title: "Register View Background",
          subtitle: "Airplane with smoke trail — Pexels",
          url: "https://www.pexels.com/photo/photo-of-airplane-with-smoke-trail-2088203/",
        ),

        _referenceTile(
          icon: Icons.image_outlined,
          title: "Forgot Password View Background",
          subtitle: "Clouds in the sky — Pexels",
          url: "https://www.pexels.com/photo/clouds-in-the-sky-11915890/",
        ),

        _referenceTile(
          icon: Icons.image_outlined,
          title: "Verify Email View Background",
          subtitle: "Starry night sky — Pexels",
          url: "https://www.pexels.com/photo/photo-of-a-starry-night-sky-15293548/",
        ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _referenceTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required String url,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.open_in_new, size: 18),
        onTap: () {
          _openLink(url);
        },
      ),
    );
  }

  Future<void> _openLink(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not open link: $url');
    }
  }
}

