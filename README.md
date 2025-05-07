<a id="readme-top"></a>

> [!WARNING]
> 1) This app may contain explicit content, so viewer discretion is **strongly advised**. 
> 2) This app is in dormant mode, and there are some known issues specifically about the local collection. Hopefully will be maintained again in somewhere in 2025 ~ early 2026 :).

<!-- Banner -->
<img src="./media/banner.png" align="center"></img>

<!-- Title & Description -->
<h1 align="center"> [VNDB Lite] </h1>
<p align="center">A lite open-source mobile version of your favorite vndb.org website. </p>

<!-- Badges -->
<div align="center">
    <a href="https://flutter.dev">
        <img src="https://img.shields.io/badge/Platform-Flutter-02569B?logo=flutter"
        alt="Platform" />
    </a>
    <img src="https://img.shields.io/github/license/Daniel-C-J/vndb-lite" alt="license"></img>
    <img src="https://img.shields.io/github/v/release/Daniel-C-J/vndb-lite" alt="release"></img>
</div>

<br/>

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#quick-start">Quick Start</a></li>
    <li>
    <a href="#disclaimer">Disclaimer</a>
    <li> <a href="#about-the-project">About The Project</a></li>
      <ul>
        <li><a href="#community-and-support">Community and Support</a></li>
        <li><a href="#main-features">Main Features</a></li>
        <li><a href="#built-with">Built With</a></li>
        <li><a href="#history">History</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>

## Quick Start
Currently, this app only supports for Android. I am unable to test the app for IOS platform, since I don't have any apple device. Contact me if you want to help me testing for IOS platform! :D

[Download latest version here.](https://github.com/Daniel-C-J/vndb-lite/releases)

<p align="right">(<a href="#readme-top">back to top</a>)</p>


## Disclaimer
This project, **VNDB Lite**, is not an official app advertised by the official [website](https://vndb.org/) itself. It is simply just a personal project that the developer himself found interesting, and worthwhile expanding his skills and knowledge in mobile development.

<p align="right">(<a href="#readme-top">back to top</a>)</p>


## About The Project

### Community and support
This is a very new project with a lot of potential to improve. If you'd like to help out, please give it a star 🌟 and share it with the others! You can also jump in and start contributing right away! Just fork the project and suggest any changes you'd like me to consider. That'll be very helpful for a small developer like me.

And hey, I'm always open for donation!

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/P5P4L666F)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



### About VNDB
It is a website that houses a large public database of Visual Novels, hence the name stands for Visual Novel DataBase (VNDB). You can learn more about the website itself [here](https://vndb.org/).

<p align="right">(<a href="#readme-top">back to top</a>)</p>


### About VNDB Lite

> Do read the disclaimer above first please.

This app is still in development, and is heavily inspired by Tachiyomi (A digital comic reading app), someone from reddit which I forgot, and a picture I found from the internet which looks really cool! That picture gave me a lot of inspiration. I tried to make one like that, but I ended up having a lite version and a sleep apnea instead.

<img src="./media/inspiration.png" width="350px" height = "250px"></img>

If you ever use Tachiyomi or similar app, then I assure you can adapt fast with this app's UI.

VNDB Lite is currently released for **Android only**, and it only supports **Android 5.0+**. 

Unfortunately and currently, I don't have any IOS device to neither build nor even test the app. But as the framework (Flutter) itself supports cross-platform, you can build yourself the app from the source code for your own specific platform, and then test it.

<p align="right">(<a href="#readme-top">back to top</a>)</p>


### Main Features
As the name stated: **Lite**, this app does not cover the entire feature you might found in the original website itself, though, some of the fundamentals are covered in this app.

Here are the features:
1. Up to 11 VNDB official themes (though some of them sucks, I really am following the official theme, so don't blame me lol)

2. Previews of VNs (Based on latest user collection, and Top-bys)
<br>[![Previews](https://img.icons8.com/ios-filled/50/000000/video.png)](https://github.com/Daniel-C-J/vndb-lite/raw/refs/heads/master/media/feature/preview.mkv)

3. Advanced search
<br>[![Previews](https://img.icons8.com/ios-filled/50/000000/video.png)](https://github.com/Daniel-C-J/vndb-lite/raw/refs/heads/master/media/feature/adv_search.mkv)

4.   Easy to save vn selection and multiselection
<br><img src ="./media/feature/selection.png" width=150></img>

5. VNDB latest statistics chart (I know it's ugly, but at least it can **spin**)
<br><img src ="./media/feature/chart.png" width=150></img>

6. Local collection
   
7. VNDB account synchronization
<br><img src ="./media/feature/sync.png" width=150></img>

8. Offline mode (Once entering vn detail screen)
<br><img src ="./media/feature/offline_mode.gif" width=150></img>

9. Double-click to censor/uncensor cover 👀
10. (งツ)ว And many more...!

> [!WARNING]
> VNDB Lite Synchronization does not support the following:
> 1. Custom status other than the built-in ones, such as: `playing, finished, stalled, dropped, wishlist, and blacklist`. Other than that will be considered invalid and will not be synchronized.
> 2. A VN item which has multiple status on it, such as: `playing`, and `dropped` in a single item, that is not fully valid. Synchronization with VNDB Lite will only take **one** from the two. But any of the built-in status with `voted` is valid.
> 3. Saving the changes made from the cloud to the local once successfully synchronized. VNDB Lite's synchronization is local-oriented, so once user synchronized, any change from the cloud, such as **editing** an already existing item, will not be tolerated, and will be overrided instead by the local existing ones instead the moment user synchronizing again. 
> The same thing happens when **deleting** an item from the cloud, once synchronizing again, if the item still exists in local, then it will go back to the cloud (in a form of a backup). The only thing that local tolerated with cloud changes, is that **adding** a new item from the cloud, and that will be saved in the local.
> 4. The ability to immediately synchronize lot of vns (probably 60+) at once in a single synchronization. There are times when your cloud vns are not fully synchronized in the local collection after the first time synchronization, especially if you've lots of vns in your vndb collection. Make sure that after a short delay, try to synchronize again until it fully indexing all of your cloud vns in the local collection.
>
> **Consider changing your collection via vndb.org first to make sure that all of your VNs are valid when synchronizing using this app.**

<br>

TODOS:
- Landscape mode optimization
- Detail screen UI update
- Filter & Sort mechanism
- Better collection methods
- Vn review
- Vn self-note (Add note to a certain vn)
- New vn releases news

Dev note:
- No, there will be no localizations. – =͟͟͞͞ =͟͟͞͞ ﾍ( ´Д`)ﾉ I can engrish

<p align="right">(<a href="#readme-top">back to top</a>)</p>


### Built With

<img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)"></img>

With main dependencies such as:
- [Riverpod](https://pub.dev/packages/riverpod)
- [GoRouter](https://pub.dev/packages/go_router)
- [Dio](https://pub.dev/packages/dio)
- [Local Notifications](https://pub.dev/packages/flutter_local_notifications)
- [SharedPreferences](https://pub.dev/packages/sharedpreferences)

[See Changelog](./CHANGELOG.md)

<p align="right">(<a href="#readme-top">back to top</a>)</p>


### History
Migrated to an upcoming blog site 🚛...


<!-- GETTING STARTED -->
## Getting Started

### Prerequisites

To avoid incompatibility, it is recommended that at least you have flutter's engine with version of **3.29.2** (stable). Here's how to check yours.

```sh
flutter --version
```

Also do check whether there's anything wrong with the engine.

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

3. Type `flutter build --help` then head down to the `Available subcommands:` section, you'll be able to found the platform specific options to build the app. 
```sh
flutter build --help 
flutter build apk --release # If you choose to build android app.
```

4. The output path is usually in `./build`, for android specifically it is in `./build/app/outputs/flutter-apk/` alongside with the `sha-1` hash.
```sh
start . # To quickly opens file explorer to see for yourself the output.
```

5. And you're done! Congrats 🎉!
   
<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- USAGE EXAMPLES -->
## Usage   

Well there's no real official documentation yet for this project, and it is as simple as managing your own library. So have fun, and experiment with it!

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

Distributed under the [Apache-2.0 License](./LICENSE).

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- CONTACT -->
## Contact

Daniel CJ - dcj.dandy800@passinbox.com

Project Link: [https://github.com/Daniel-C-J/vndb-lite](https://github.com/Daniel-C-J/vndb-lite)


<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- ACKNOWLEDGMENTS -->
## Acknowledgments

- Synchronized data is stored in vndb.org via its official API.
- The icon used for this app is not mine, it's one of majikoi's CG, and I'm just using it just for fun.
  
<p align="right">(<a href="#readme-top">back to top</a>)</p>
