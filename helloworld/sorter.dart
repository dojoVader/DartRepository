/// This application is a CLI that communicates with the OpenAI API aka ChatGPT
/// [author] Okeowo Aderemi

import 'dart:convert';

import 'package:cli_util/cli_util.dart';
import 'package:cli_util/cli_logging.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

bool PC_RUNNING = true;
HttpClient httpClient;

final String API_KEY="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";

void main(List<String> args) async {
  String question = null;
  stdout.write("Welcome to the ChatGPT Console, please enter a question ? ");
  question = stdin.readLineSync();

  // Create the Logger
  Logger logger = Logger.standard();
  logger.stdout("Sending the Request to ChatGPT.........");
  Progress progress = logger.progress('Waiting for response');
  http.Request request = new http.Request("post", Uri.https("api.openai.com","v1/completions"));
  request.headers.clear();
  request.headers.addAll({
    "Authorization" : 'Bearer ${API_KEY}',
    "Content-type": 'application/json'
  });
  request.body = jsonEncode({
    'model': 'text-davinci-003',
    'prompt': question
  });
  var response = await request.send();
  String jsonResponse = (await response.stream.bytesToString());
  progress.finish(showTiming: true);
  Map<String,dynamic> responseXHR = jsonDecode(jsonResponse);
  print("ChatGPT Response:" + responseXHR['choices'][0]['text']);



}

