import 'dart:io';
import 'package:image/image.dart' as img;

Future<File> cropImage(File currentThumbnail) async {
  try {
    // Read the image bytes
    final imageBytes = await currentThumbnail.readAsBytes();

    // Decode image to get dimensions
    final decodedImage = img.decodeImage(imageBytes);
    if (decodedImage == null) {
      throw Exception('Failed to decode image');
    }

    // Calculate initial crop area for 16:9 aspect ratio
    final imageWidth = decodedImage.width.toDouble();
    final imageHeight = decodedImage.height.toDouble();

    final targetAspectRatio = 16 / 9;
    final imageAspectRatio = imageWidth / imageHeight;

    double cropWidth, cropHeight;

    if (imageAspectRatio > targetAspectRatio) {
      // Image is wider than 16:9, crop width
      cropHeight = imageHeight;
      cropWidth = imageHeight * targetAspectRatio;
    } else {
      // Image is taller than 16:9, crop height
      cropWidth = imageWidth;
      cropHeight = imageWidth / targetAspectRatio;
    }

    // Center the crop area
    final cropX = (imageWidth - cropWidth) / 2;
    final cropY = (imageHeight - cropHeight) / 2;

    // Create a temporary file for the cropped image
    final tempDir = Directory.systemTemp;
    final tempFile = File('${tempDir.path}/cropped_${DateTime.now().millisecondsSinceEpoch}.jpg');

    // Crop the image using image processing
    final croppedImage = img.copyCrop(
      decodedImage,
      x: cropX.toInt(),
      y: cropY.toInt(),
      width: cropWidth.toInt(),
      height: cropHeight.toInt(),
    );

    // Encode and save the cropped image
    final croppedBytes = img.encodeJpg(croppedImage);
    await tempFile.writeAsBytes(croppedBytes);

    return tempFile;
  } catch (e) {
    print('Error cropping image: $e');
    return currentThumbnail;
  }
}