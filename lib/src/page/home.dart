import 'package:flutter/material.dart';
import 'package:one_way_hashing/src/model/encryption.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('One Way Hash')),
        body: const _BodyHomePage(),
      ),
    );
  }
}

class _BodyHomePage extends StatefulWidget {
  const _BodyHomePage({Key? key}) : super(key: key);

  @override
  _BodyHomePageState createState() => _BodyHomePageState();
}

class _BodyHomePageState extends State<_BodyHomePage> {
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Encryption>(context);
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _textController,
                  decoration: const InputDecoration(
                    labelText: 'Input Text',
                    labelStyle: TextStyle(color: Color(0xFFD5D5DC)),
                    hintStyle:
                        TextStyle(color: Color(0xFFD5D5DC), fontSize: 14),
                    filled: true,
                    fillColor: Color(0xFFF6F7F8),
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              CustomMainButton(
                text: 'Encrypt',
                color: Colors.green,
                onPressed: () {
                  Provider.of<Encryption>(context, listen: false)
                      .hash(_textController.text);
                },
              ),
              const SizedBox(height: 30),
              const Text(
                'SHA256',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              SelectableText(
                provider.encrypted,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 30),
              CustomMainButton(
                text: 'Decrypt (Try to decode from it\'s bytes)',
                color: Colors.green,
                onPressed: () {
                  final digest = Provider.of<Encryption>(context, listen: false)
                      .hash(_textController.text);
                  Provider.of<Encryption>(context, listen: false)
                      .bytesToString(digest.bytes);
                },
              ),
              const SizedBox(height: 30),
              const Text(
                'Decrypted Text',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              SelectableText(
                provider.decrypted,
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomMainButton extends StatelessWidget {
  final Color color;
  final String text;
  final void Function()? onPressed;

  const CustomMainButton({
    Key? key,
    required this.color,
    required this.text,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all<double>(0),
        backgroundColor: MaterialStateProperty.all<Color>(
            onPressed != null ? color : Colors.black12),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            side: BorderSide.none,
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
      child: Container(
          height: 58,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
            ],
          )),
      onPressed: onPressed,
    );
  }
}
