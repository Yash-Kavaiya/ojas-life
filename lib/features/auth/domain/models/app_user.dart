/// Immutable domain model for a signed-in Ojas Healing user.
/// Firestore serialization is handled via fromFirestoreDoc / toFirestoreDoc
/// so the model stays free of any Firebase dependency.
class AppUser {
  const AppUser({
    required this.uid,
    this.displayName,
    this.email,
    this.phoneNumber,
    this.photoUrl,
    this.isAnonymous = false,
    required this.createdAt,
    this.isPremium = false,
    this.premiumExpiresAt,
    this.preferredLanguage = 'en',
  });

  final String uid;
  final String? displayName;
  final String? email;
  final String? phoneNumber;
  final String? photoUrl;
  final bool isAnonymous;
  final DateTime createdAt;
  final bool isPremium;
  final DateTime? premiumExpiresAt;
  final String preferredLanguage;

  bool get isHindi => preferredLanguage == 'hi';

  /// Display name with fallback to email prefix or phone.
  String get displayLabel =>
      displayName ??
      email?.split('@').first ??
      phoneNumber ??
      'Seeker';

  AppUser copyWith({
    String? displayName,
    String? email,
    String? phoneNumber,
    String? photoUrl,
    bool? isAnonymous,
    DateTime? createdAt,
    bool? isPremium,
    DateTime? premiumExpiresAt,
    String? preferredLanguage,
  }) {
    return AppUser(
      uid: uid,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      photoUrl: photoUrl ?? this.photoUrl,
      isAnonymous: isAnonymous ?? this.isAnonymous,
      createdAt: createdAt ?? this.createdAt,
      isPremium: isPremium ?? this.isPremium,
      premiumExpiresAt: premiumExpiresAt ?? this.premiumExpiresAt,
      preferredLanguage: preferredLanguage ?? this.preferredLanguage,
    );
  }

  factory AppUser.fromFirestoreDoc(Map<String, dynamic> data, String uid) {
    return AppUser(
      uid: uid,
      displayName: data['displayName'] as String?,
      email: data['email'] as String?,
      phoneNumber: data['phoneNumber'] as String?,
      photoUrl: data['photoUrl'] as String?,
      // Firestore Timestamps expose a .toDate() method
      createdAt:
          (data['createdAt'] as dynamic)?.toDate() as DateTime? ?? DateTime.now(),
      isPremium: data['isPremium'] as bool? ?? false,
      premiumExpiresAt:
          (data['premiumExpiresAt'] as dynamic)?.toDate() as DateTime?,
      preferredLanguage: data['preferredLanguage'] as String? ?? 'en',
    );
  }

  Map<String, dynamic> toFirestoreDoc() => {
        'uid': uid,
        'displayName': displayName,
        'email': email,
        'phoneNumber': phoneNumber,
        'photoUrl': photoUrl,
        'isPremium': isPremium,
        'preferredLanguage': preferredLanguage,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppUser &&
          runtimeType == other.runtimeType &&
          uid == other.uid;

  @override
  int get hashCode => uid.hashCode;

  @override
  String toString() => 'AppUser(uid: $uid, name: $displayLabel)';
}
