import 'package:flutter/material.dart';

class CalculatePage extends StatefulWidget {
  const CalculatePage({super.key});

  @override
  State<CalculatePage> createState() => _CalculatePageState();
}

class _CalculatePageState extends State<CalculatePage> {
  final _firstController = TextEditingController();
  final _secondController = TextEditingController();
  double? _result;

  @override
  void dispose() {
    _firstController.dispose();
    _secondController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _firstController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'First number'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _secondController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Second number'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              final first = double.tryParse(_firstController.text);
              final second = double.tryParse(_secondController.text);
              setState(() {
                if (first != null && second != null) {
                  _result = first + second;
                } else {
                  _result = null;
                }
              });
            },
            child: const Text('Add'),
          ),
          const SizedBox(height: 20),
          if (_result != null)
            Text(
              'Result: $_result',
              style: Theme.of(context).textTheme.titleLarge,
            )
        ],
      ),
    );
  }
}
