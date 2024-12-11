import 'package:Benefeer/component/buttons.dart';
import 'package:Benefeer/component/colors.dart';
import 'package:Benefeer/component/padding.dart';
import 'package:Benefeer/component/texts.dart';
import 'package:Benefeer/component/widgets/header.dart';
import 'package:Benefeer/view/store/local/verifiedscreen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_vision/google_ml_vision.dart';
import 'package:permission_handler/permission_handler.dart';

class DocumentScannerScreen extends StatefulWidget {
  DocumentScannerScreen({super.key, required this.localstoreId});

  final int localstoreId;

  @override
  _DocumentScannerScreenState createState() => _DocumentScannerScreenState();
}

class _DocumentScannerScreenState extends State<DocumentScannerScreen> {
  CameraController? _controller;
  List<CameraDescription>? cameras;
  bool isProcessing = false;
  bool isPermissionDenied = false;

  @override
  void initState() {
    super.initState();
    _checkCameraPermission();
  }

  Future<void> _checkCameraPermission() async {
    final status = await Permission.camera.request();

    if (status.isGranted) {
      await _initializeCamera();
    } else if (status.isDenied || status.isPermanentlyDenied) {
      setState(() {
        isPermissionDenied = true;
      });
    }
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
          builder: (_) => VerifiedScreen(
              imagePath: imagePath, localstoreId: widget.localstoreId),
        ),
      );
    } else {
      print('Documento não identificado.');
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
    if (isPermissionDenied) {
      return Scaffold(
        body: Padding(
          padding: defaultPadding,
          child: Center(
              child: SubText(
                  text:
                      "Acesso à câmera negado. Por favor, permita o uso da câmera nas configurações.",
                  align: TextAlign.center)),
        ),
      );
    }

    if (_controller == null || !_controller!.value.isInitialized) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: lightColor,
        body: Padding(
          padding: defaultPaddingHorizon,
          child: Column(
            children: [
              MainHeader(
                title: "Área do Comprovante",
                onClick: () {
                  Navigator.of(context).pop();
                },
                icon: Icons.arrow_back_ios,
              ),
              const SizedBox(
                height: 35,
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CameraPreview(_controller!),
                  ),
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: defaultPadding,
                  child: GestureDetector(
                    onTap: _captureAndDetectDocument,
                    child: DefaultButton(
                      text: 'Tirar foto',
                      icon: Icons.camera,
                      color: SeventhColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 35,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
