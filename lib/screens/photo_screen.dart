import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'dart:io';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class PhotosProvider extends ChangeNotifier {
  List<Photo> _photos = [
    Photo(date: DateTime(2023, 6, 2), url: 'https://example.com/photo1.jpg'),
    Photo(date: DateTime(2023, 6, 2), url: 'https://example.com/photo2.jpg'),
    Photo(date: DateTime(2023, 6, 2), url: 'https://example.com/photo3.jpg'),
    Photo(date: DateTime(2023, 5, 8), url: 'https://example.com/photo4.jpg'),
    Photo(date: DateTime(2023, 5, 8), url: 'https://example.com/photo5.jpg'),
  ];

  List<Photo> get photos => _photos;

  void addPhoto(Photo photo) {
    _photos.add(photo);
    _photos.sort((a, b) => b.date.compareTo(a.date)); // Sort photos by date, newest first
    notifyListeners();
  }

  void removePhoto(Photo photo) {
    _photos.remove(photo);
    notifyListeners();
  }
}

class Photo {
  final DateTime date;
  final String url;
  final File? file;

  Photo({required this.date, this.url = '', this.file});
}

class PhotosScreen extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () =>
              Navigator.pushReplacementNamed(context, '/dashboard'),
        ),
        title: Text('Progress Photo',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.more_horiz, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: AnimationLimiter(
        child: SingleChildScrollView(
          child: Column(
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 375),
              childAnimationBuilder: (widget) =>
                  SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: widget,
                    ),
                  ),
              children: [
                _buildReminderCard(),
                _buildTrackProgressCard(),
                _buildComparePhotoButton(),
                _buildGallery(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: Colors.blue,
        children: [
          SpeedDialChild(
            child: Icon(Icons.camera_alt),
            backgroundColor: Colors.blue,
            label: 'Take Photo',
            onTap: () => _takePhoto(context),
          ),
          SpeedDialChild(
            child: Icon(Icons.photo_library),
            backgroundColor: Colors.green,
            label: 'Choose from Gallery',
            onTap: () => _chooseFromGallery(context),
          ),
        ],
      ),
    );
  }


  Widget _buildReminderCard() {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Color(0xFFFFEBEE),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.calendar_today, color: Colors.red, size: 20),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Reminder!', style: TextStyle(fontWeight: FontWeight.bold,
                  color: Colors.red,
                  fontSize: 16)),
              Text('Next Photos Fall On July 08',
                  style: TextStyle(color: Colors.red, fontSize: 14)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTrackProgressCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Track Your Progress Each', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text('Month With Photo', style: TextStyle(fontSize: 14)),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Learn More',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparePhotoButton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Compare my Photo',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Navigate to compare screen
              // Navigator.push(context, MaterialPageRoute(builder: (context) => CompareScreen()));
            },
            child: Text('Compare', style: TextStyle(color: Colors.white)),

            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGallery() {
    return Consumer<PhotosProvider>(
      builder: (context, photosProvider, child) {
        var groupedPhotos = groupBy(photosProvider.photos, (Photo p) =>
            DateFormat('d MMMM').format(p.date));

        return Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Gallery', style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18)),
                  Text('See more',
                      style: TextStyle(color: Colors.blue, fontSize: 14)),
                ],
              ),
            ),
            ...groupedPhotos.entries.map((entry) =>
                _buildPhotoGroup(context, entry.key, entry.value)),
          ],
        );
      },
    );
  }

  Widget _buildPhotoGroup(BuildContext context, String date,
      List<Photo> photos) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(date,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: photos.length,
          itemBuilder: (context, index) {
            return _buildPhotoItem(photos[index]);
          },
        ),
      ],
    );
  }

  Widget _buildPhotoItem(Photo photo) {
    return Hero(
      tag: photo.url.isNotEmpty ? photo.url : photo.file!.path,
      child: GestureDetector(
        onTap: () {
          // Implement photo viewing functionality here
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: photo.file != null
              ? Image.file(photo.file!, fit: BoxFit.cover)
              : Image.network(photo.url, fit: BoxFit.cover),
        ),
      ),
    );
  }

  Future<void> _chooseFromGallery(BuildContext context) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final photo = Photo(
        date: DateTime.now(),
        file: File(image.path),
      );
      Provider.of<PhotosProvider>(context, listen: false).addPhoto(photo);
    }
  }


  Future<void> _takePhoto(BuildContext context) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      final Directory appDir = await getApplicationDocumentsDirectory();
      final String fileName = path.basename(image.path);
      final File localImage = await File(image.path).copy(
          '${appDir.path}/$fileName');

      final photo = Photo(
        date: DateTime.now(),
        file: localImage,
      );
      Provider.of<PhotosProvider>(context, listen: false).addPhoto(photo);
    }
  }
}

Map<K, List<V>> groupBy<K, V>(Iterable<V> items, K Function(V) key) {
  return items.fold({}, (Map<K, List<V>> map, V item) {
    (map[key(item)] ??= []).add(item);
    return map;
  });
}