#!/usr/bin/env bash
set -euo pipefail

project_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
bundle_dir="$project_root/build/linux/x64/release/bundle"
appdir="$project_root/build/appimage/VNPockets.AppDir"
output_dir="$project_root/build/appimage"
appimage_tool="${APPIMAGETOOL:-appimagetool}"
app_version="$(sed -n 's/^version: *\([^+]*\).*/\1/p' "$project_root/pubspec.yaml" | head -n 1)"

if [[ ! -x "$bundle_dir/vnpockets" ]]; then
  echo "Linux release bundle not found: $bundle_dir" >&2
  echo "Run 'flutter build linux --release' first." >&2
  exit 1
fi

if ! command -v "$appimage_tool" >/dev/null 2>&1 && [[ ! -x "$appimage_tool" ]]; then
  echo "appimagetool not found. Set APPIMAGETOOL to its executable path." >&2
  exit 1
fi

if [[ -z "$app_version" ]]; then
  echo "Could not determine the app version from pubspec.yaml." >&2
  exit 1
fi

mkdir -p "$appdir/usr/lib/vnpockets" "$output_dir"
cp -a "$bundle_dir/." "$appdir/usr/lib/vnpockets/"
cp "$project_root/assets/images/icon/app_icon.png" "$appdir/vnpockets.png"
cp "$project_root/linux/appimage/AppRun" "$appdir/AppRun"
cp "$project_root/linux/appimage/vnpockets.desktop" "$appdir/vnpockets.desktop"
ln -sf vnpockets.png "$appdir/.DirIcon"
chmod +x "$appdir/AppRun"

output="$output_dir/VNPockets-${app_version}-x86_64.AppImage"
runtime_options=()
if [[ -n "${APPIMAGETOOL_RUNTIME_FILE:-}" ]]; then
  runtime_options+=(--runtime-file "$APPIMAGETOOL_RUNTIME_FILE")
fi

APPIMAGE_EXTRACT_AND_RUN=1 ARCH=x86_64 VERSION="$app_version" \
  "$appimage_tool" --no-appstream "${runtime_options[@]}" "$appdir" "$output"

echo "Created $output"
