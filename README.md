# GoogleAds
This is a quick tutorial on using the Google Mobile Ads SDK with SwiftUI.

## Installation
### Swift Package Manager
```swift
dependencies: [
    .package(url: "httpshttps://github.com/wayne90040/GoogleAds")
]
```

## Usage
#### Please refer to [Google's quick start guide](https://developers.google.com/admob/ios/quick-start?hl=zh-tw) to complete the preliminary `info.plist` setup.

#### Initialize the Mobile Ads SDK
```swift
@main
struct MainApp: App {
    init() {
       GoogleAds.register() 
    }
    
    var body: some Scene { 
        ...
    }
}
```

#### Banner 
```swift
AdsBanner(id: "ca-app-pub-3940256099942544/2934735716", size: .normal)
```

#### Interstitial
```swift

extension AdsInterstitial {
    func loadAds() async {
        do {
            try await loadAds(id: "")
        }
        catch {
            debugPrint("")
        }
    }
}

struct CreateView: View {
    private let ads = AdsInterstitial()

    var body: some View {
        ...
        .onAppear {
            Task {
                await ads.loadAds(ads: "ca-app-pub-3940256099942544/4411468910")
            }
        }
    }
    
    private var nextPageButton: some View {
        Button {
            try? ads.showAd()
            isNextPageActive.toggle()
        } label: {
            Text("Next Page")
        }
    }
```
