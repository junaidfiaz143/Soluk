import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

enum CameraMediaType { IMAGE, VIDEO, BOTH }

class Pickers {
  static final instance = Pickers._internal();

  Pickers._internal();

  final ImagePicker _picker = ImagePicker();

  final String sourceCamera = "CAMERA";
  final String sourceGallery = "GALLERY";

  Future<String?> pickImage(
      {String source = "CAMERA",
      CameraMediaType? mediaType = CameraMediaType.IMAGE,
      int quality = 50,
      CameraDevice preferredCameraDevice = CameraDevice.rear}) async {
    try {
      XFile? file;
      if (mediaType == CameraMediaType.IMAGE) {
        file = await _picker.pickImage(
            source: source == sourceCamera
                ? ImageSource.camera
                : ImageSource.gallery,
            imageQuality: quality,
            preferredCameraDevice: preferredCameraDevice);
      } else {
        file = await _picker.pickVideo(
            source: source == sourceCamera
                ? ImageSource.camera
                : ImageSource.gallery,
            preferredCameraDevice: preferredCameraDevice);
      }
      return file?.path;
    } catch (e) {
      return null;
    }
  }

  Future<List<File>?> pickFromGallery() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.media,
      allowCompression: true,
    );
    if (result != null) {
      return result.paths.map((e) => File(e!)).toList();
    } else {
      return null;
    }
  }

  static const List<String> _allowedExtensions = [
    'bmp',
    'doc',
    'docx',
    'gif',
    'jpeg',
    'jpg',
    'pdf',
    'png',
    'tif',
    'tiff',
    'xls',
    'xlsx'
  ];
  Future<FilePickerResult?> pickFile(
      {FileType type = FileType.custom,
      List<String> allowedExtensions = _allowedExtensions,
      bool allowCompression = true,
      bool allowMultiple = false}) async {
    try {
      return await FilePicker.platform.pickFiles(
          type: type,
          allowedExtensions: allowedExtensions,
          allowCompression: allowCompression,
          allowMultiple: allowMultiple);
    } catch (e) {
      return null;
    }
  }
}
