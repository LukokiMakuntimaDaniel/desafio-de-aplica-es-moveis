import 'package:flutter/material.dart';
import 'package:call_log/call_log.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CallLogScreen(),
    );
  }
}

class CallLogScreen extends StatefulWidget {
  @override
  _CallLogScreenState createState() => _CallLogScreenState();
}

class _CallLogScreenState extends State<CallLogScreen> {
  List<CallLogEntry> _callLog = [];

  @override
  void initState() {
    super.initState();
    _getCallLog();
  }

  Future<void> _getCallLog() async {
    try {
      Iterable<CallLogEntry> entries = await CallLog.get();
      setState(() {
        _callLog = entries.toList();
      });
    } catch (e) {
      print("Erro ao acessar o histórico de chamadas: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Histórico de Chamadas'),
      ),
      body: _callLog.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _callLog.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_callLog[index].name ?? 'Desconhecido'),
                  subtitle: Text(_callLog[index].number ?? 'Número desconhecido'),
                  trailing: Text(_callLog[index].callType == CallType.incoming ? 'Recebida' : 'Efetuada'),
                );
              },
            ),
    );
  }
}
