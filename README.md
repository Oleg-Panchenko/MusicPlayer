# MusicPlayer
Player looks similar to Apple Music, requesting data from iTunes API. App built using UIKit &amp; SwiftUI frameworks. Clean Swift architecture.

# Contains 

- UITabBarController, UINavigationController, UISearchController
- UITableView
- AVKit
- Itunes API
- Alamofire, SDWebImage(UIKit), URLImage(SwiftUI)
- UIPanGestureRecognizer(UIKit), LongPressGesture(SwiftUI)
- JSON
- UserDefaults

# Content

Player contains three screens: 
- [Library](#library) 
- [Search](#search) 
- [Detail](#detail)

# Library

This screen built using SwiftUI framework.

- This screen contains favourite songs. 
- Press left button to start playing your playlist or right button to refresh list.
- To open detail screen with all song information tap on a cell.
- You can delete a song by swiping or long pressing a cell.

<img width="320" src="https://user-images.githubusercontent.com/77533590/173417611-f27e1124-2c3c-4b9b-b0ff-6263dcadbdbf.mp4">     <img width="320" src="https://user-images.githubusercontent.com/77533590/173452038-2e2309bf-f7dd-468d-a3cd-15c472b3b6a2.mp4">  

# Search

- Type in the searchBar a song or an artist name and get suggestions for your search.
- Add a song to your favourites by clicking "plus".
- Tap on a liked song to play it and open detail screen.

<img width="320" src="https://user-images.githubusercontent.com/77533590/173541209-da7ccd36-cf57-447c-85f9-aba29e24524b.mp4">   <img width="320" src="https://user-images.githubusercontent.com/77533590/173541381-b2f8ed90-34fc-458c-875a-f78e4417c5e1.mp4"> 

# Detail

- On this screen you can control playing songs.
- Move tracks forward or back, change volume, rewind the track, play/pause.
- Transform big detail screen to mini and backwards by clicking on top centered button or by swiping. 

<img width="320" src="https://user-images.githubusercontent.com/77533590/173545629-bc30986d-9f24-45a1-bc34-fa283c86cfa2.mp4">   <img width="320" src="https://user-images.githubusercontent.com/77533590/173546674-5b407903-2562-44e1-852a-b0711cd1d5f6.mp4">
