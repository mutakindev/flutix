part of 'shared.dart';

Future<File> getImage() async {
  ImagePicker imagePicker = ImagePicker();
  var image = await imagePicker.getImage(source: ImageSource.gallery);
  return File(image.path);
}

Future<String> uploadImage(File image) async {
  String fileName = basename(image.path);

  StorageReference ref = FirebaseStorage.instance.ref().child(fileName);
  StorageUploadTask task = ref.putFile(image);
  StorageTaskSnapshot snapshot = await task.onComplete;

  return await snapshot.ref.getDownloadURL();
}

void showFlushbarError(String message, BuildContext context) {
  Flushbar(
    duration: Duration(seconds: 4),
    flushbarPosition: FlushbarPosition.TOP,
    backgroundColor: Color(0xFFFF5C83),
    message: message,
  )..show(context);
}
