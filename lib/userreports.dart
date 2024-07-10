import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class UserReportsScreen extends StatefulWidget {
  final String email;

  UserReportsScreen({required this.email});

  @override
  _UserReportsScreenState createState() => _UserReportsScreenState();
}

class _UserReportsScreenState extends State<UserReportsScreen> {
  List<dynamic> _reports = [];

  @override
  void initState() {
    super.initState();
    _fetchUserReports();
  }

  Future<void> _fetchUserReports() async {
    final uri = Uri.parse("http://192.168.100.85:8080/api/API/user-reports/${widget.email}/");
    var response = await http.get(uri);
    print("USER REPORTS FETCHED *********");
    if (response.statusCode == 200) {
      setState(() {
        _reports = json.decode(response.body);
      });
    } else {
      print('Failed to load reports: ${response.statusCode}');
    }
  }

  Future<void> _launchUrl(Uri _url) async {
    print('URL IS************: $_url');
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Reports'),
      ),
      body: ListView.builder(
        itemCount: _reports.length,
        itemBuilder: (context, index) {
          var report = _reports[index];
          Uri fileUrl = Uri.parse("http://192.168.100.85:8080/media/${report['file']}");
          return ListTile(
            title: GestureDetector(
              onTap: () => launchUrl(fileUrl, mode: LaunchMode.inAppBrowserView),
              child: Text(
                report['file'].split('/').last,
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            subtitle: Text(report['uploaded_at']),
          );
        },
      ),
    );
  }
}
