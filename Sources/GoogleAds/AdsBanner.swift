import SwiftUI
import GoogleMobileAds

public struct AdsBanner: UIViewRepresentable {
    
    public enum Size {
        /// iPhone and iPod Touch ad size. Typically 320x50.
        case normal
        /// Taller version of GADAdSizeBanner. Typically 320x100.
        case large
        /// Medium Rectangle size for the iPad (especially in a UISplitView's left pane). Typically 300x250.
        case medium
        /// Full Banner size for the iPad (especially in a UIPopoverController or in
        /// UIModalPresentationFormSheet). Typically 468x60.
        case fullBanner
        /// Leaderboard size for the iPad. Typically 728x90.
        case leaderboard
        /// Skyscraper size for the iPad. Mediation only. AdMob/Google does not offer this size. Typically
        /// 120x600.
        case skyscraper
        /// An ad size that spans the full width of its container, with a height dynamically determined by
        /// the ad.
        case fluid
        /// Invalid ad size marker.
        case invalid
    }
    
    /// unitID
    public var id: String
    public var size: Size
    public var onReceived: (() -> Void)?
    public var onFailed: ((Error) -> Void)?
    
    public init(
        id: String,
        size: Size = .medium,
        onReceived: (() -> Void)? = nil,
        onFailed: ((Error) -> Void)? = nil
    ) {
        self.id = id
        self.size = size
        self.onReceived = onReceived
        self.onFailed = onFailed
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(
            onReceived: {
                onReceived?()
            },
            onFailed: {
                onFailed?($0)
            })
    }
    
    public func makeUIView(context: Context) -> GADBannerView {
        let adView = GADBannerView(adSize: size.adsize)
        adView.adUnitID = id
        adView.rootViewController = UIApplication.shared.getRootViewController()
        adView.delegate = context.coordinator
        adView.load(GADRequest())
        return adView
    }
    
    public func updateUIView(_ uiView: GADBannerView, context: Context) { }
    
    public class Coordinator: NSObject, GADBannerViewDelegate {
        
        let onReceived: (()->Void)?
        let onFailed: ((Error) -> Void)?
        
        init(
            onReceived: (()->Void)?,
            onFailed: ( (Error) -> Void)?
        ) {
            self.onReceived = onReceived
            self.onFailed = onFailed
        }
        
        public func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
            onReceived?()
#if DEBUG
            debugPrint("bannerViewDidReceiveAd")
#endif
        }
        
        public func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
            onFailed?(error)
#if DEBUG
            debugPrint("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
#endif
        }
        
        public func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
#if DEBUG
            debugPrint("bannerViewDidRecordImpression")
#endif
        }
        
        public func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
#if DEBUG
            debugPrint("bannerViewWillPresentScreen")
#endif
        }
        
        public func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
#if DEBUG
            debugPrint("bannerViewWillDIsmissScreen")
#endif
        }
        
        public func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
#if DEBUG
            debugPrint("bannerViewDidDismissScreen")
#endif
        }
    }
}

extension AdsBanner.Size {
    public var adsize: GADAdSize {
        switch self {
        case .normal:
            GADAdSizeBanner
            
        case .large:
            GADAdSizeLargeBanner
            
        case .medium:
            GADAdSizeMediumRectangle
            
        case .fullBanner:
            GADAdSizeFullBanner
            
        case .leaderboard:
            GADAdSizeLeaderboard
            
        case .skyscraper:
            GADAdSizeSkyscraper
            
        case .fluid:
            GADAdSizeFluid
            
        case .invalid:
            GADAdSizeInvalid
        }
    }
}

extension UIApplication {
    func getRootViewController()->UIViewController {
        guard let screen = self.connectedScenes.first as? UIWindowScene else {return .init()}
        guard let root = screen.windows.first?.rootViewController else {return .init()}
        return root
    }
}
