import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:receiter/camera_screen.dart';
import 'package:receiter/main.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  late CameraDescription _camera;
  Widget _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return Container(child: Text('Sülo'));
      case 1:
        return CameraScreen();
      default:
        return new Text("Error");
    }
  }

  List<String> titleList = ["Home", "Camera"];

  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(titleList[_currentIndex]),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          backgroundColor: colorScheme.surface,
          selectedItemColor: colorScheme.onSurface,
          unselectedItemColor: colorScheme.onSurface.withOpacity(.60),
          selectedLabelStyle: textTheme.caption,
          unselectedLabelStyle: textTheme.caption,
          onTap: (value) async {
            if (value == 1) {
              WidgetsFlutterBinding.ensureInitialized();
              cameras = await availableCameras();
            }
            setState(() {
              _currentIndex = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: 'Camera',
              icon: Icon(Icons.camera),
            )
          ],
        ),
        body: _getDrawerItemWidget(_currentIndex)
        // body: FutureBuilder<Widget>(
        //   future: _getDrawerItemWidget(_currentIndex),
        //   builder: (context, data) {
        //     if (data.connectionState != ConnectionState.done) {
        //       return const Center(child: CircularProgressIndicator());
        //     }
        //     return data.data!;
        //   },
        // ),
        );
  }
}
