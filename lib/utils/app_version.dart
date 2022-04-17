class AppVersion {
  int _major = 0;
  int _minor = 0;
  int _patch = 0;

  AppVersion(String rawVersion) {
    final versions = rawVersion.split('.');
    if (versions.isNotEmpty) _major = int.tryParse(versions[0]) ?? 0;
    if (versions.length > 1) _minor = int.tryParse(versions[1]) ?? 0;
    if (versions.length > 2) _patch = int.tryParse(versions[2]) ?? 0;
  }

  int get major => _major;
  int get minor => _minor;
  int get patch => _patch;

  int compareTo(AppVersion other) {
    if (major == other.major && minor == other.minor && patch == other.patch) {
      return 0;
    }
    if (major > other.major ||
        (major == other.major && minor > other.minor) ||
        (major == other.major && minor == other.minor && patch > other.patch)) {
      return 1;
    }

    return -1;
  }

  @override
  String toString() => '$major.$minor.$patch';
}
