import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class LanguageTranslation extends StatefulWidget {
  const LanguageTranslation({super.key});

  @override
  State<LanguageTranslation> createState() => _LanguageTranslationState();
}

class _LanguageTranslationState extends State<LanguageTranslation> {
  var languages = ["Russian", "English", "Italian"];
  var originLanguages = "From";
  var destinationLanguages = "To";
  var output = "";
  TextEditingController languageController = TextEditingController();

  void translate(String src, String dest, String input) async {
    GoogleTranslator translator = GoogleTranslator();
    var translation = await translator.translate(input, from: src, to: dest);
    setState(() {
      output = translation.text.toString();
    });
    if (src == "--" || dest == "--") {
      setState(() {
        output = "Fail to translate";
      });
    }
  }

  String getLanguageCode(String language) {
    if (language == "English") {
      return "en";
    } else if (language == "Russian") {
      return "ru";
    } else if (language == "Italian") {
      return "it";
    }
    return "--";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF10223D),
      appBar: AppBar(
        title: const Text("Language Translator"),
        centerTitle: true,
        backgroundColor: const Color(0XFF10223D),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton(
                    focusColor: Colors.white,
                    iconDisabledColor: Colors.white,
                    iconEnabledColor: Colors.white,
                    hint: Text(
                      originLanguages,
                      style: const TextStyle(color: Colors.white),
                    ),
                    dropdownColor: Colors.white,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: languages.map(
                      (String dropdownStringItem) {
                        return DropdownMenuItem(
                          value: dropdownStringItem,
                          child: Text(
                            dropdownStringItem,
                          ),
                        );
                      },
                    ).toList(),
                    onChanged: (String? value) {
                      setState(
                        () {
                          originLanguages = value!;
                        },
                      );
                    },
                  ),
                  const SizedBox(width: 40),
                  const Icon(Icons.arrow_right_outlined,
                      color: Colors.white, size: 40),
                  const SizedBox(width: 40),
                  DropdownButton(
                    focusColor: Colors.white,
                    iconDisabledColor: Colors.white,
                    iconEnabledColor: Colors.white,
                    hint: Text(
                      destinationLanguages,
                      style: const TextStyle(color: Colors.white),
                    ),
                    dropdownColor: Colors.white,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: languages.map(
                      (String dropdownStringItem) {
                        return DropdownMenuItem(
                          value: dropdownStringItem,
                          child: Text(
                            dropdownStringItem,
                          ),
                        );
                      },
                    ).toList(),
                    onChanged: (String? value) {
                      setState(
                        () {
                          destinationLanguages = value!;
                        },
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                    cursorColor: Colors.white,
                    autofocus: false,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    decoration: const InputDecoration(
                      labelText: "Please enter your text:",
                      labelStyle: TextStyle(fontSize: 50, color: Colors.white),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1),
                      ),
                      errorStyle: TextStyle(color: Colors.red, fontSize: 50),
                    ),
                    controller: languageController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter text to translate";
                      }
                      return null;
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0XFF2b3c5a),
                  ),
                  onPressed: () {
                    translate(
                      getLanguageCode(originLanguages),
                      getLanguageCode(destinationLanguages),
                      languageController.text.toString(),
                    );
                  },
                  child: const Text("Translate"),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "\n$output",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
