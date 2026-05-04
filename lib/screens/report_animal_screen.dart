import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class ReportAnimalScreen extends StatefulWidget {
  const ReportAnimalScreen({super.key});

  @override
  State<ReportAnimalScreen> createState() => _ReportAnimalScreenState();
}

class _ReportAnimalScreenState extends State<ReportAnimalScreen> {
  final _formKey = GlobalKey<FormState>();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _animalType;
  String? _healthStatus;
  bool _imageSelected = false;
  bool _submitted = false;

  static const _types = ['Cat', 'Dog', 'Unknown'];
  static const _statuses = [
    'Healthy',
    'Needs Feeding',
    'Injured',
    'Sick',
    'Unknown',
  ];

  @override
  void dispose() {
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _clear() {
    _formKey.currentState?.reset();
    _locationController.clear();
    _descriptionController.clear();
    setState(() {
      _animalType = null;
      _healthStatus = null;
      _imageSelected = false;
      _submitted = false;
    });
  }

  void _submit() {
    setState(() => _submitted = true);
    final formValid = _formKey.currentState!.validate();
    if (!formValid || !_imageSelected) {
      return;
    }

    Navigator.pushNamed(context, '/success');
  }

  @override
  Widget build(BuildContext context) {
    final showImageError = _submitted && !_imageSelected;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Animal'),
        actions: [
          TextButton(
            onPressed: _clear,
            child: const Text('Clear', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Text(
                'Animal Photo *',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppTheme.text.withValues(alpha: 0.72),
                ),
              ),
              const SizedBox(height: 8),
              InkWell(
                borderRadius: BorderRadius.circular(18),
                onTap: () => setState(() => _imageSelected = true),
                child: Container(
                  height: 160,
                  decoration: BoxDecoration(
                    color: AppTheme.primary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: showImageError ? AppTheme.error : AppTheme.border,
                      width: showImageError ? 1.8 : 1.2,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _imageSelected ? Icons.image : Icons.camera_alt,
                        size: 42,
                        color: _imageSelected
                            ? AppTheme.success
                            : AppTheme.primary,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _imageSelected
                            ? 'photo_20260504.jpg selected'
                            : 'Tap to upload photo',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: _imageSelected
                                  ? AppTheme.success
                                  : AppTheme.primary,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Image upload is a Sprint 1 placeholder',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.text.withValues(alpha: 0.48),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (showImageError)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    'Animal photo is required before submitting',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.error,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              const SizedBox(height: 18),
              DropdownButtonFormField<String>(
                initialValue: _animalType,
                decoration: const InputDecoration(
                  labelText: 'Animal Type',
                  prefixIcon: Icon(Icons.pets),
                ),
                items: _types
                    .map(
                      (type) =>
                          DropdownMenuItem(value: type, child: Text(type)),
                    )
                    .toList(),
                onChanged: (value) => setState(() => _animalType = value),
                validator: _required,
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(
                  labelText: 'Location Found',
                  hintText: 'e.g. N28 Engineering Block, UTM',
                  prefixIcon: Icon(Icons.location_on),
                ),
                validator: _required,
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _descriptionController,
                maxLength: 300,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  hintText:
                      'Describe the animal condition, appearance, and behavior.',
                  prefixIcon: Icon(Icons.notes),
                  alignLabelWithHint: true,
                ),
                validator: _required,
              ),
              const SizedBox(height: 4),
              DropdownButtonFormField<String>(
                initialValue: _healthStatus,
                decoration: const InputDecoration(
                  labelText: 'Health Status',
                  prefixIcon: Icon(Icons.health_and_safety),
                ),
                items: _statuses
                    .map(
                      (status) =>
                          DropdownMenuItem(value: status, child: Text(status)),
                    )
                    .toList(),
                onChanged: (value) => setState(() => _healthStatus = value),
                validator: _required,
              ),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppTheme.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppTheme.primary.withValues(alpha: 0.16),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.info_outline,
                      color: AppTheme.primary,
                      size: 20,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Your report will be reviewed by UTM animal welfare volunteers.',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.text.withValues(alpha: 0.68),
                          height: 1.45,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              ElevatedButton.icon(
                onPressed: _submit,
                icon: const Icon(Icons.pets),
                label: const Text('Submit Report'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    return null;
  }
}
