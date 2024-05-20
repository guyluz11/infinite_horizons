import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TipResource extends StatelessWidget {
  const TipResource({
    required this.url,
    super.key,
  });
  final String url;

  @override
  Widget build(BuildContext context) {
    //Check what type of resource is being displayed
    final bool isVideo = url.contains("youtube") || url.contains("youtu.be");
    final bool isPdf = url.contains("pdf");
    //Display the pdf
    if (isPdf) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Resource'),
        ),
        body: SfPdfViewer.network(url),
      );
      //Display the video
    } else if (isVideo) {
      final YoutubePlayerController controller = YoutubePlayerController(
        //Convert the url to the video id
        initialVideoId: YoutubePlayer.convertUrlToId(url) ?? "",
        //Hide the thumbnail
        flags: const YoutubePlayerFlags(hideThumbnail: true),
      );
      return Stack(
        children: [
          //Add a transparent container to close the video and implement it like a popup window
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: double.infinity,
              color: Colors.transparent.withOpacity(0.5),
            ),
          ),
          //Builder is used when full screen functionality is required
          YoutubePlayerBuilder(
            player: YoutubePlayer(
              //controller initialized above
              controller: controller,
              //Show the progress bar
              showVideoProgressIndicator: true,
              //Set the color of the progress bar and other attrs
              progressIndicatorColor: Colors.red,
              progressColors: const ProgressBarColors(
                playedColor: Colors.red,
                handleColor: Colors.red,
              ),
            ),
            builder: (context, player) {
              //Center and pad the player for UI Improvement
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: player),
              );
            },
          ),
        ],
      );
      //Display the webview
    } else {
      final controller = WebViewController()
        //Allows unrestricted javascript execution
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        //Set the background color to transparent
        ..setBackgroundColor(const Color(0x00000000))
        //Defines properties for the webview navigation
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) {
              // Update loading bar.
            },
            onPageStarted: (String url) {},
            onPageFinished: (String url) {},
            onWebResourceError: (WebResourceError error) {},
          ),
        )
        //Load the url
        ..loadRequest(Uri.parse(url));
      return Scaffold(
        appBar: AppBar(title: const Text('Resource')),
        //Actual webview widget to which the controller is passed
        body: WebViewWidget(controller: controller),
      );
    }
  }
}
