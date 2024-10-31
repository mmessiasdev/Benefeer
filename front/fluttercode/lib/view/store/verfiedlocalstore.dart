import 'package:Benefeer/view/home/homepage.dart';
import 'package:Benefeer/view/store/verifiedscreen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_vision/google_ml_vision.dart';

class DocumentScannerScreen extends StatefulWidget {
  @override
  _DocumentScannerScreenState createState() => _DocumentScannerScreenState();
}

class _DocumentScannerScreenState extends State<DocumentScannerScreen> {
  CameraController? _controller;
  List<CameraDescription>? cameras;
  bool isProcessing = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    _controller = CameraController(cameras![0], ResolutionPreset.medium);

    await _controller?.initialize();
    if (!mounted) return;
    setState(() {});
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _captureAndDetectDocument() async {
    if (_controller == null ||
        !_controller!.value.isInitialized ||
        isProcessing) return;

    setState(() {
      isProcessing = true;
    });

    // Captura a imagem da câmera
    final image = await _controller!.takePicture();
    final imagePath = image.path; // Salva o caminho da imagem
    final visionImage = GoogleVisionImage.fromFilePath(imagePath);
    final textRecognizer = GoogleVision.instance.textRecognizer();

    // Processa a imagem para detectar texto
    final visionText = await textRecognizer.processImage(visionImage);

    // Verifica se algum texto foi detectado (simulando a detecção de um documento)
    if (visionText.text?.isNotEmpty ?? false) {
      // Navega para `VerifiedScreen` com o caminho da imagem
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => VerifiedScreen(imagePath: imagePath),
        ),
      );
    }

    // Finaliza o processamento
    setState(() {
      isProcessing = false;
    });

    // Libera o reconhecedor de texto
    textRecognizer.close();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(title: Text("Document Scanner")),
      body: Column(
        children: [
          Expanded(child: CameraPreview(_controller!)),
          ElevatedButton(
            onPressed: _captureAndDetectDocument,
            child: Text("Capturar e Analisar"),
          ),
        ],
      ),
    );
  }
}
