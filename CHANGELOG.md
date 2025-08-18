# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).


## [Unreleased]

### Added

- None.

## [3.6.0] - 2025-08-18

### Added

- Random VN preview.

### Changed

- License year + name.
- Minor code refactor.
- Riverpod migration v2 to v3.
- Better performance.
- Home big preview.
- Animated search bar text.
- Home screen redesign.

### Fixed

- Collection section header bug.
- Toggle blur bug.
- Zoom X icon.

## [3.5.2] - 2025-07-16

### Fixed

- Collection selection dialog snackbar message.
- Synchronization note bug.
  
### Changed

- Home big preview index shuffle.


## [3.5.1] - 2025-07-14

### Fixed

- Flags icon.
- Vn selection dialog reappearing bug.

### Changed

- Vn item & detail performance.
- Vn item & detail cache system.
- MasonryGrid layout.
- Minor Scrollbar visual.
- Bottom sheet sort and filter header.


## [3.5.0] - 2025-07-13

### Fixed

- Flags icon.
- Platform icon.

### Added

- Touhou theme is back. (a little bit broken, but still okay)


## [3.4.1] - 2025-07-12

### Fixed

- Textfield bug.
  

## [3.4.0] - 2025-07-12

### Added

- More platform options.

### Changed

- Dropped touhou theme. 😟 (Way too broken)
- Bottom navigation bar.
- VN visibility measure.
- Origin language options.

### Fixed

- Searchbar focus node bug.


## [3.3.0] - 2025-07-08

### Changed

- Home visual noise. (e.g labels)
- Home screen layout.
- Bottom navigation bar.
- General performance.
- Code refactor.

### Added

- More language selections.
- Performance aware widgets.
  
### Fixed

- Homescreen lag.
- Minor theme.
- Padding consistency.


## [3.1.1] - 2025-06-27

### Fixed

- Not aligned well labels.


## [3.1.0] - 2025-06-26

### Added

- SafeArea-aware widgets.

### Changed

- App's font.
- Code refactor.
- Reduced app's size significantly.
- Increase app's performance.


## [3.0.3] - 2025-06-14

### Changed

- App & Splash screen icon.
- Synchronization message limit.
  

## [3.0.2] - 2025-06-03

### Fixed

- Failed synchronization bug.


## [3.0.1] - 2025-06-03

### Fixed

- Search screen search bar scroll bug.
- Remove all collection cache bug.


## [3.0.0] - 2025-06-03

### Added

- Codeberg profile.
- Home big preview swiper indicator.
- Filter selected option indicator.

### Changed

- Code refactor.
- Buttons consistency.
- Version check control system.
- Dio configuration.
- Synchronization can now aware of changes made from cloud and not local restricted anymore.
- Bottom Navigation Bar's scrolling visibility.
- VN detail screen platforms and languages UI rendering.

### Fixed

- Typos.
  

## [2.0.0] - 2025-05-07

### Added

- Home predefined search section.
- Home searchbar redirection.
- Home big preview.

### Changed

- Minor code refactor.
- Dependencies version.
- Project structure.
- Framework update.
- App theme configuration.
- Buttons.
- Refresh indicator.
- Scrolling behaviour.

### Fixed

- Error image text design inconsistency at VN detail screen background.


## [1.2.0] - 2024-xx-xx

### Fixed

- Non-instant collection items disappearance when changing status.

### Changed

- Collection item management.

### Added

- Progress circular indicator when refreshing collection screen.


## [1.1.2] - 2024-xx-xx

### Fixed

- Blinking when entering multiselection mode.
- Multiselection indicator overlay stuck when dismissing dialog from FAB.
- Inkwell bug in back button VN detail screen.
- Big memory consumption.


## [1.1.0] - 2024-xx-xx

### Added

- User vote value in VN detail summary shortcut.

### Changed

- Collection status change indicators.
- App theme changes.
- Scrolling experience.
- App performance.
- App structure.


## [1.0.0] - 2024-xx-xx

### Added

- Pre-configuration.

### Fixed

- Empty VN status category item duplicate data.
- Multiselection indicator stuck.
- Status option widgets stuck.
- Severe dancing cover.
- Search query clash with multi-selection mode.
- Searching while applying filter bug.
- Sync bug not changing value.
- Persistent problem on progress linear on the bottom navigation bar when refreshing.
- VN item grid asking for null URL.
- Clicking tag item from VN detail screen showing null UI in the filters.
- Floating action button in VN detail screen won't appear.
- Tight landscape search field.


## [0.9.0] - 2024-xx-xx

### Fixed

- Filter search query disappear when sorting.
- Search icon highlight when there's no query nor filter.

### Changed

- Scrolling experience.


## [0.8.0] - 2024-xx-xx

### Fixed

- App crash when there's a long list in collection screen.
- Search in collection screen isn't working.
- Synchronization with missing VNs.
- Multiselection mode issue where VN moved into different category became corrupted (null).

### Added

- VN cover offline accessibility.

### Changed

- Clearing cache option in settings.


## [0.7.0] - 2024-xx-xx

### Fixed

- Stacking notification when syncing more than one data batch.
- Landscape VN preview cover title cropped.
- VN detail screen lag.
- Sort tab in collection screen in landscape mode can't scroll down.
- Laggy language flag options.
- Bottom linear progression issue when syncing and refreshing.

### Changed

- Collections algorithm.
- Scrolling experience.
- Internet connection handling.
- Add VN to collection UI dialog.
- Sort and filters UI and UX.
- Blurry VN cover.

### Added

- Scrollbar.


## [0.6.0] - 2024-xx-xx

### Fixed

- Super laggy behaviour in search screen.
- Automatically/instantly updating collection list UI.
- Cannot initiate a sync with the cloud.
- Not saved value after a successful sync.
- Sync for a big list.
- Bug in collection screen when search field text filtering being empty when refreshing the screen even though the text is still there.
- Snackbar cropped UI design.

### Added

- Gradient in tab bar view in VN detail screen.
- Better vote dropdown button UI.


## [0.4.0] - 2024-xx-xx

### Added

- Feature to zoom VN cover with animation.
- Faint highlight animation when cancelling long-press on VN relations inside VN detail screen.

### Fixed

- Appbar settings overriding data list tile.
- UI with SafeArea in landscape mode.
- AIR background theme.
- Rearrangement settings furthermore.
- Background not covering all screen.
- Splash screen.
- App icon.


## [0.3.0] - 2024-xx-xx

### Added

- Cache manager to store network images.

### Fixed

- Home screen laggy behaviour.
- Arrangement layout settings customisation.
- Multi-selection back button lag UI update.


## [0.2.2] - 2024-xx-xx

### Changed

- Splash screen.
- App icon.


## [0.2.1] - 2024-xx-xx

### Fixed

- Frozen search result.
- Loop progress linear on the bottom navigation bar when refreshing.
- Uncancelled timer for snackbar warning.


## [0.2.0] - 2024-xx-xx

### Added

- Splash screen.
- Tags border color in detail screen according spoiler level.


## [0.1.0] - 2024-07-xx

### Added

- Basic functionality.
- App identity.
