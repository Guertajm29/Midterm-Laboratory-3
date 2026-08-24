import 'package:flutter/material.dart';

void main() {
  runApp(const SignUpApp());
}

class SignUpApp extends StatelessWidget {
  const SignUpApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unique Sign-Up Lab',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: const Color(0xFFF4F7F6),
      ),
      home: const SignUpScreen(),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _selectedAccountType;
  final List<String> _accountTypes = ['BSIT', 'BSCS', 'BSCE'];

  bool _agreeToTerms = false;
  String _selectedGender = 'Male';
  double _notificationVolume = 50.0;
  DateTime? _selectedBirthdate;

  Color _buttonColor = Colors.teal;
  String _gestureMessage = '💡 Try tapping, double-tapping, or long-pressing!';

  Future<void> _selectBirthdate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedBirthdate = picked;
      });
    }
  }

  void _validateAndExecute(String actionType, Color color, String message) {
    if (_formKey.currentState!.validate() && _agreeToTerms) {
      setState(() {
        _buttonColor = color;
        _gestureMessage = message;
      });
    } else {
      if (!_agreeToTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please agree to the Terms and Conditions first!'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
      _formKey.currentState!.validate();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.teal.shade200),
                ),
                child: const Text(
                  'Fill in your details below to get started.',
                  style: TextStyle(
                    color: Colors.teal,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Full name cannot be left empty.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Email address cannot be left empty.';
                  }
                  if (!value.contains('@') || !value.contains('.')) {
                    return 'Please enter a valid email address (e.g., user@domain.com).';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return 'Password must be at least 6 characters long.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              DropdownButtonFormField<String>(
                value: _selectedAccountType,
                hint: const Text('Select Account Type'),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.category),
                  border: OutlineInputBorder(),
                ),
                items: _accountTypes.map((String type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedAccountType = newValue;
                  });
                },
                validator: (value) =>
                    value == null ? 'Please select an account type' : null,
              ),
              const SizedBox(height: 15),

              const Text(
                'Gender:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Male'),
                      value: 'Male',
                      groupValue: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Female'),
                      value: 'Female',
                      groupValue: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Age:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${_notificationVolume.round()}%',
                    style: const TextStyle(color: Colors.teal),
                  ),
                ],
              ),
              Slider(
                value: _notificationVolume,
                min: 0,
                max: 100,
                divisions: 100,
                label: _notificationVolume.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _notificationVolume = value;
                  });
                },
              ),
              const SizedBox(height: 10),

              OutlinedButton.icon(
                onPressed: () => _selectBirthdate(context),
                icon: const Icon(Icons.calendar_today, color: Colors.teal),
                label: Text(
                  _selectedBirthdate == null
                      ? 'Select Birthdate'
                      : 'Birthdate: ${_selectedBirthdate!.toLocal().toString().split(' ')[0]}',
                  style: const TextStyle(color: Colors.black87),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  alignment: Alignment.centerLeft,
                  side: const BorderSide(color: Colors.grey),
                ),
              ),
              const SizedBox(height: 15),

              CheckboxListTile(
                title: const Text('I agree to the Terms and Conditions'),
                value: _agreeToTerms,
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
                onChanged: (bool? value) {
                  setState(() {
                    _agreeToTerms = value ?? false;
                  });
                },
              ),
              const SizedBox(height: 25),

              GestureDetector(
                onTap: () => _validateAndExecute(
                  'tap',
                  Colors.green,
                  '👆 Single Tap Detected!',
                ),
                onDoubleTap: () => _validateAndExecute(
                  'doubleTap',
                  Colors.orange,
                  '👏 Double Tap Detected!',
                ),
                onLongPress: () => _validateAndExecute(
                  'longPress',
                  Colors.red,
                  '🖐 Long Press Detected!',
                ),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.symmetric(
                    vertical: 18,
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                    color: _buttonColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'SIGN UP',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        _gestureMessage,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
