import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  bool _showSimulationSection = false;

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  bool _isSmoking = false;
  bool _isDrinking = false;
  double _eatingValue = 2;
  double _exerciseValue = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Survey Result'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Text(
                'Your Health Risks',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildResultsCard(
                    context,
                    'Cancer Risk',
                    'Medium',
                    'Higher than Normal',
                  ),
                  _buildResultsCard(
                    context,
                    'Heart Disease Risk',
                    'High',
                    'Higher than Normal',
                  ),
                  _buildResultsCard(
                    context,
                    'Diabetes Risk',
                    'Low',
                    'Lower than Normal',
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Visibility(
                visible: widget._showSimulationSection,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      'Simulate the Impact of Changing Your Habits',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900],
                      ),
                    ),
                    const SizedBox(height: 20),
                    SwitchListTile(
                      title: const Text('Stop Smoking'),
                      value: _isSmoking,
                      onChanged: (newValue) {
                        setState(() {
                          _isSmoking = newValue;
                        });
                      },
                    ),
                    SwitchListTile(
                      title: const Text('Stop Drinking Alcohol'),
                      value: _isDrinking,
                      onChanged: (newValue) {
                        setState(() {
                          _isDrinking = newValue;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Eating Healthier:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900],
                          ),
                        ),
                        Text(
                          '$_eatingValue',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900],
                          ),
                        ),
                      ],
                    ),
                    Slider(
                      value: _eatingValue,
                      min: 0,
                      max: 4,
                      divisions: 4,
                      label: _eatingValue.round().toString(),
                      onChanged: (value) {
                        setState(() {
                          _eatingValue = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Exercising Regularly:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900],
                          ),
                        ),
                        Text(
                          '$_exerciseValue',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900],
                          ),
                        ),
                      ],
                    ),
                    Slider(
                      value: _exerciseValue,
                      min: 0,
                      max: 4,
                      divisions: 4,
                      label: _exerciseValue.round().toString(),
                      onChanged: (value) {
                        setState(() {
                          _exerciseValue = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    widget._showSimulationSection =
                        !widget._showSimulationSection;
                  });
                },
                child: Text(
                  widget._showSimulationSection
                      ? 'Hide Simulation Section'
                      : 'Show Simulation Section',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue[900],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultsCard(
      BuildContext context, String title, String subtitle, String rank) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width / 3.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              rank,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
