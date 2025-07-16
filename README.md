<a id="readme-top"></a>

> [!WARNING]
> 1) This app may contain explicit content, so viewer discretion is **strongly advised**. 
> 2) This app is in dormant mode, and there are some known issues specifically about the local collection. It will hopefully be back to an active state again somewhere in 2025 ~ early 2026. :)

<!-- Banner -->
<img src="./media/banner.png" align="center">

<!-- Title & description -->
<h1 align="center">[VNDB Lite]</h1>
<p align="center">A lite, free, and open-source mobile version of your favorite website, vndb.org.</p>

<!-- Badges -->
<div align="center">
    <a href="https://flutter.dev">
        <img src="https://img.shields.io/badge/Platform-Flutter-02569B?logo=flutter"
        alt="Platform" />
    </a>
    <img src="https://img.shields.io/github/license/Daniel-C-J/vndb-lite" alt="license">
    <img src="https://img.shields.io/github/v/release/Daniel-C-J/vndb-lite" alt="release">
</div>

<br>

<!-- Standalone Obtainium badge -->
<div align="center">
  <a href="http://apps.obtainium.imranr.dev/redirect.html?r=obtainium://app/%7B%22id%22:%22com.vndblite.dcj%22,%22url%22:%22https://github.com/Daniel-C-J/vndb-lite%22,%22author%22:%22DanielCJ%22,%22name%22:%22VNDB%20Lite%22,%22preferredApkIndex%22:0,%22additionalSettings%22:%22%7B%5C%22includePrereleases%5C%22:false,%5C%22fallbackToOlderReleases%5C%22:true,%5C%22filterReleaseTitlesByRegEx%5C%22:%5C%22%5C%22,%5C%22filterReleaseNotesByRegEx%5C%22:%5C%22%5C%22,%5C%22verifyLatestTag%5C%22:false,%5C%22dontSortReleasesList%5C%22:false,%5C%22useLatestAssetDateAsReleaseDate%5C%22:false,%5C%22trackOnly%5C%22:false,%5C%22versionExtractionRegEx%5C%22:%5C%22%5C%22,%5C%22matchGroupToUse%5C%22:%5C%22%5C%22,%5C%22versionDetection%5C%22:true,%5C%22releaseDateAsVersion%5C%22:false,%5C%22useVersionCodeAsOSVersion%5C%22:false,%5C%22apkFilterRegEx%5C%22:%5C%22%5C%22,%5C%22invertAPKFilter%5C%22:false,%5C%22autoApkFilterByArch%5C%22:true,%5C%22appName%5C%22:%5C%22VNDB%20Lite%5C%22,%5C%22exemptFromBackgroundUpdates%5C%22:false,%5C%22skipUpdateNotifications%5C%22:false,%5C%22about%5C%22:%5C%22A%20lite,%20free,%20and%20open-source,%20mobile%20version%20of%20your%20favorite%20website,%20vndb.org.%5C%22,%5C%22appAuthor%5C%22:%5C%22DanielCJ%5C%22%7D%22%7D">
    <img src="./media/badge_obtainium.png" alt="Make sure you have Obtainium installed!" title="Make sure you have Obtainium installed!" height="80">
  </a>
</div>

<br/>
est. read time: <b>6.5 minutes</b>
<br/><br/>

<!-- INDEX -->
<details>
  <summary>Index</summary>
  <ol>
    <li><a href="#quick-start">Quick start</a></li>
    <li>
    <a href="#disclaimer">Disclaimer</a>
    <li> <a href="#about-the-project">About the project</a></li>
      <ul>
        <li><a href="#community-and-support">Community and support</a></li>
        <li><a href="#main-features">Main features</a></li>
        <li><a href="#built-with">Built with</a></li>
        <li><a href="#history">History</a></li>
        <li><a href="#changelog">Changelog</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
    <li><a href="#contributors">Contributors</a></li>
  </ol>
</details>

## Quick start

[Download the latest version here.](https://github.com/Daniel-C-J/vndb-lite/releases)

N.B. - currently, this app only supports Android. I am unable to test the app for iOS, because I don't have any device from Apple. Contact me if you want to help me test VNDB Lite for iOS! :D

<p align="right">(<a href="#readme-top">back to top</a>)</p>


## Disclaimer

This project, **VNDB Lite**, is not an official app supported by [VNDB.org](https://vndb.org/) itself. It is simply a personal project that the developer found interesting, and that it was worthwhile to expand his competences and knowledge in mobile application development.

<p align="right">(<a href="#readme-top">back to top</a>)</p>


## About the project

### Community and support

This is a relatively new project with a lot of potential for new improvements. If you'd like to help out, please give it a star 🌟 and share it with others! You can also jump in and start contributing right away! Just fork the project and suggest changes you'd like me to consider. That'll be very helpful for a small developer like me.

Credit to flat-gal-expert for refactoring this README file and other files!

And hey, I also accept donations!

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/P5P4L666F)

<p align="right">(<a href="#readme-top">back to top</a>)</p>


### About VNDB

It is a website that hosts a large public database of visual novels, and as the name suggests, VNDB stands for the Visual Novel DataBase. You can learn more about the website itself [here](https://vndb.org/d7).

<p align="right">(<a href="#readme-top">back to top</a>)</p>


### About VNDB Lite

> Please read the disclaimer above first.

This app is still in development. It is heavily inspired by Tachiyomi (a digital comic reading application), someone from Reddit which I forgot, and an image I found from the Internet which looked really cool! That image gave me a lot of inspiration. I tried to make something resembling it, but I ended up having a lite version and a sleep apnea instead.

<img src="./media/inspiration.png" width="350px" height = "250px">

If you ever used Tachiyomi or some similar app, then I assure you that you will adapt rapidly to this app's interface.

VNDB Lite is currently released for **Android only**, and it only supports **Android 5.0+**. 

Currently, unfortunately, I have no iOS device to compile or even test the app. But as the framework (Flutter) itself is cross-platform, you can compile yourself the app from the source code for your own specific platform, and then test it.

<p align="right">(<a href="#readme-top">back to top</a>)</p>


### Main features

As the name implies: this is a **lite** application, it does not cover all of the features you might find on the original website itself, but most of the fundamentals are covered by this app.

Here are the primary features:
1. Up to 11 VNDB official themes (well, some of them suck, but these are the official themes, so don't blame me XD)
2. Previews of VNs (based on the latest user collection, and top VNs)
<br>[![Previews](https://img.icons8.com/ios-filled/50/000000/video.png)](https://github.com/Daniel-C-J/vndb-lite/raw/refs/heads/master/media/feature/preview.mkv)
3. Advanced search
<br>[![Previews](https://img.icons8.com/ios-filled/50/000000/video.png)](https://github.com/Daniel-C-J/vndb-lite/raw/refs/heads/master/media/feature/adv_search.mkv)
4. Easy way to save VN selection and multi-selection
<br><img src ="./media/feature/selection.png" width=150>
5. A chart of VNDB's latest statistics (I know it's ugly, but at least it can **spin** XD)
<br><img src ="./media/feature/chart.png" width=150>
6. Local collection
7. VNDB account synchronization
<br><img src ="./media/feature/sync.png" width=150>
8. Offline mode (for the VN details)
<br><img src ="./media/feature/offline_mode.gif" width=150>
9. Double-click to censor/uncensor cover 👀
10. (งツ)ว And many more...!

> [!WARNING]
> VNDB Lite's synchronization feature does not support the following:
> 1. Custom status other than the built-in ones, i.e. `playing, finished, stalled, dropped, wishlist, blacklist`. Anything other than that will be considered invalid and will not be synchronized. (Yet)
> 2. Decimal values for VN score. (It will eventually be rounded)
> 3. A VN item which has multiple status on it, such as: `playing`, and `dropped`, is currently not going to be considered fully valid. Synchronization with VNDB Lite will only take **one** from the two. But any of the built-in status with `voted` is valid.
> 4. ~~Saving the changes made from the VNDB server to the local storage once successfully synchronized. VNDB Lite's synchronization is local-oriented, so once the user synchronized his/her collection, any change from the VNDB server, such as **modifying** an already existing item, will not be tolerated, and will be over-written instead by the existing local ones instead whenever the user decides to synchronize again. The same thing happens when **deleting** an item from the VNDB server, once synchronizing again, if the item still exists in your local collection, then it will go back to the VNDB server (in the form of a backup). The only thing that is tolerated with VNDB server changes, is that **adding** a new item from the VNDB server, and that will be saved in the local collection.~~ Client-server semi-full synchronization is now supported starting from version 3.0.0
> 5. The ability to immediately synchronize lots of VNs (approximately 60+ items) at once in a single synchronization. There are times when your VNDB.org collection VNs are not fully synchronized with the local collection after the first time synchronization, especially if you have lots of VNs in your VNDB.org collection. Make sure to try to synchronize again after some delay until it fully indexes all of your VNDB.org collection VNs within the local collection.
>
> **Consider changing your collection via vndb.org first to make sure that all of your VNs are valid when synchronizing using this app.**

<br>

TODOS:
- BBCode
- Better logic
- Landscape mode optimization
- Custom background
- Detail screen UI update
- Filter & sort mechanism
- Better collection methods
- VN review
- VN note (Add note to a certain vn)
- New VN releases news

Dev note:
- No, there will be no localizations. – =͟͟͞͞ =͟͟͞͞ ﾍ( ´Д`)ﾉ I can engrish

<p align="right">(<a href="#readme-top">back to top</a>)</p>


### Built with

<img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)">

VNDB Lite mainly depends on these dependencies:
- [Riverpod](https://pub.dev/packages/riverpod)
- [GoRouter](https://pub.dev/packages/go_router)
- [Dio](https://pub.dev/packages/dio)
- [Local Notifications](https://pub.dev/packages/flutter_local_notifications)
- [SharedPreferences](https://pub.dev/packages/sharedpreferences)

But that's not all...!


<p align="right">(<a href="#readme-top">back to top</a>)</p>


### History

Migrated to an upcoming blog site 🚛...


### Changelog

[See the change-log](./CHANGELOG.md)

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- GETTING STARTED -->
## Getting started

### Prerequisites

To avoid incompatibility, it is recommended that you have at least Flutter's engine >= version **3.29.2** (stable). Here's how to verify the version.

```sh
flutter --version
```

Also do check if there's anything wrong with the engine.

```sh
flutter doctor -v
```


### Installation

1. Clone this repository 
```sh
git clone https://github.com/Daniel-C-J/vndb-lite.git
```

2. Open your terminal and `cd` to the root path of the repository, for example:
```sh
cd vndb-lite
```

3. Type `flutter build --help` then head down to the `Available subcommands:` section, you'll be able to find the platform specific options to compile the app. 
```sh
flutter build --help 
flutter build apk --release # This compiles the Android application.
```

4. The output path is usually in `./build`, for Android specifically it is in `./build/app/outputs/flutter-apk/` alongside with the `sha-1` hash.
```batch
start . # This opens Windows's file explorer to check out the output.
```

5. And you're done! Congratulations 🎉!

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- USAGE EXAMPLES -->
## Usage   

While there is no real official documentation yet for this project, it is as simple as managing your own VNDB.org collection. So have fun, and experiment with it!

<img src="./media/screenshots/Screenshot_01.png" alt="screenshot" width=180  style="padding: 5px;" ></img>
<img src="./media/screenshots/Screenshot_02.png" alt="screenshot" width=180  style="padding: 5px;" ></img>
<img src="./media/screenshots/Screenshot_03.png" alt="screenshot" width=180  style="padding: 5px;" ></img>
<img src="./media/screenshots/Screenshot_04.png" alt="screenshot" width=180  style="padding: 5px;" ></img>
<img src="./media/screenshots/Screenshot_05.png" alt="screenshot" width=180  style="padding: 5px;" ></img>
<img src="./media/screenshots/Screenshot_06.png" alt="screenshot" width=180  style="padding: 5px;" ></img>
<img src="./media/screenshots/Screenshot_07.png" alt="screenshot" width=180  style="padding: 5px;" ></img>
<img src="./media/screenshots/Screenshot_08.png" alt="screenshot" width=180  style="padding: 5px;" ></img>
<img src="./media/screenshots/Screenshot_09.png" alt="screenshot" width=180  style="padding: 5px;" ></img>
<img src="./media/screenshots/Screenshot_10.png" alt="screenshot" width=180  style="padding: 5px;" ></img>

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- LICENSE -->
## License

Distributed under terms of the [Apache-2.0 License](./LICENSE).

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- CONTACT -->
## Contact

Daniel CJ - dcj.dandy800@passinbox.com

VNDB Lite's Git repositories: [https://github.com/Daniel-C-J/vndb-lite](https://github.com/Daniel-C-J/vndb-lite), [https://codeberg.org/daniel-c-j/vndb-lite/](https://codeberg.org/daniel-c-j/vndb-lite/)

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- ACKNOWLEDGMENTS -->
## Acknowledgments

- Synchronized data is stored back to vndb.org via its official API.
- The icon used for this app is an edited high resolution version of vndb's original icon.

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- CONTRIBUTORS -->
## Contributors

- [micah686](https://vndb.org/u28821) - Helped suggesting having a backup repo. (Availability and thicker OSS solution matters)
- [flat-gal-expert](https://vndb.org/u305047) - Or should I say linguistic expert to help this app's engrish.
- [OG-Yorhel](https://vndb.org/u2) - Helped with synchronization logic!
  
And many others that helped me outside the code spectrum — your support is greatly appreciated! You rock!
  
<p align="right">(<a href="#readme-top">back to top</a>)</p>
