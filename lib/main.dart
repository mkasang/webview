import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// Future<void> loadRequest() async {
//   try {
//     final response = await http.get(Uri.parse("https://v1.udps.applipourtous.cd/dashboard"));
//     if (response.statusCode == 200) {
//       // Traitez la réponse ici
//     } else {
//       throw Exception('Erreur lors du chargement de l\'URL');
//     }
//   } catch (e) {
//     print("Erreur: $e");
//     }
// }

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  WebViewController? controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            log("The Started Page:$url");
          },
          onPageFinished: (String url) {
            log("The Finished Page:$url");
          },
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url
                .startsWith('https://v1.udps.applipourtous.cd/login/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://v1.udps.applipourtous.cd/login'));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            WebViewWidget(
              controller: controller!,
            ),
          ],
        ),
      ),
    );
  }
}
