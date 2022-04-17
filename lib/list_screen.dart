import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:receiter/preview_screen.dart';

import 'main.dart';

class CapturesScreen extends StatelessWidget {
  final Map<String, List<File>> imageFileList;

  const CapturesScreen({required this.imageFileList});

  refreshAlreadyCapturedImages() async {
    final directory = await getApplicationDocumentsDirectory();
    List<FileSystemEntity> fileList =
        await directory.list(recursive: true).toList();
    allFileList.clear();
    List<Map<int, dynamic>> fileNames = [];

    fileList.forEach((file) {
      if (file.path.contains('.jpg') || file.path.contains('.mp4')) {
        String name = file.path.split('/').last.split('.').first;
        List<String> splitted = file.path.split('/');
        int length = splitted.length;
        // allFileList[splitted[length - 2]] = ;

        if (!allFileList.containsKey(splitted[length - 2])) {
          allFileList[splitted[length - 2]] = [];
        }

        allFileList[splitted[length - 2]]!.add(File(file.path));

        fileNames.add({
          0: int.parse(name),
          1: '${splitted[length - 2]}/${splitted[length - 1]}'
        });

        // fileNames.add({0: int.parse(name), 1: file.path.split('/').last});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    refreshAlreadyCapturedImages();
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Captures',
                style: TextStyle(
                  fontSize: 32.0,
                  color: Colors.white,
                ),
              ),
            ),
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              children: [
                for (List<File> fileListForMonth in imageFileList.values)
                  for (File imageFile in fileListForMonth)
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => PreviewScreen(
                                fileList: fileListForMonth,
                                imageFile: imageFile,
                              ),
                            ),
                          );
                        },
                        child: Image.file(
                          imageFile,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
