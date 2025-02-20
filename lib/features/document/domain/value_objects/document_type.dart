enum DocumentType {
  resume,
  certificate,
  transcript,
  portfolio,
  contract,
  report,
  other;

  String get displayName {
    switch (this) {
      case DocumentType.resume:
        return 'Resume';
      case DocumentType.certificate:
        return 'Certificate';
      case DocumentType.transcript:
        return 'Transcript';
      case DocumentType.portfolio:
        return 'Portfolio';
      case DocumentType.contract:
        return 'Contract';
      case DocumentType.report:
        return 'Report';
      case DocumentType.other:
        return 'Other';
    }
  }

  bool get isRequired =>
    this == DocumentType.resume ||
    this == DocumentType.transcript;

  bool get isConfidential => this == DocumentType.contract;
  
  List<String> get allowedFileTypes {
    switch (this) {
      case DocumentType.resume:
      case DocumentType.certificate:
      case DocumentType.transcript:
      case DocumentType.contract:
        return ['.pdf', '.doc', '.docx'];
      case DocumentType.portfolio:
        return ['.pdf', '.doc', '.docx', '.zip', '.rar'];
      case DocumentType.report:
        return ['.pdf', '.doc', '.docx', '.xls', '.xlsx'];
      case DocumentType.other:
        return ['.pdf', '.doc', '.docx', '.zip', '.rar', '.txt'];
    }
  }
} 