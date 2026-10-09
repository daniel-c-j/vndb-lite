# VNPockets for Linux

The Linux desktop build is a native Flutter GTK application. From the project
root, build a release bundle with:

```sh
flutter pub get
flutter build linux --release
```

Run it with:

```sh
build/linux/x64/release/bundle/vnpockets
```

For distribution, copy the entire `build/linux/x64/release/bundle` directory;
the executable relies on the adjacent `data` and `lib` directories. The host
needs GTK 3 and its normal desktop runtime libraries. On Ubuntu/Debian, the
build prerequisites are `clang`, `cmake`, `ninja-build`, `pkg-config`,
`libgtk-3-dev`, and `liblzma-dev`.

Linux uses the native file chooser for custom cover/background images and for
importing backups. Exporting JSON and full ZIP backups opens a save dialog.
Sync notifications use the desktop notification service when available, but
their absence does not prevent the application from starting or syncing.

## AppImage

After building the release bundle, install or download the official
`appimagetool` and run:

```sh
APPIMAGETOOL=/path/to/appimagetool-x86_64.AppImage linux/package-appimage.sh
```

The script creates `build/appimage/VNPockets-<version>-x86_64.AppImage`.
`appimagetool` also needs network access to fetch its Type 2 runtime unless
`APPIMAGETOOL_RUNTIME_FILE` points to a local runtime file.
