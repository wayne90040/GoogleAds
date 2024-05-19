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
    
    public init(id: String, size: Size = .medium) {
        self.id = id
        self.size = size
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator()
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
        public func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
            debugPrint("bannerViewDidReceiveAd")
        }
        
        public func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
            debugPrint("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
        }
        
        public func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
            debugPrint("bannerViewDidRecordImpression")
        }
        
        public func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
            debugPrint("bannerViewWillPresentScreen")
        }
        
        public func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
            debugPrint("bannerViewWillDIsmissScreen")
        }
        
        public func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
            debugPrint("bannerViewDidDismissScreen")
        }
    }
}

extension AdsBanner.Size {
    public var adsize: GADAdSize {
        switch self {
        case .normal:
            return GADAdSizeBanner
            
        case .large:
            return GADAdSizeLargeBanner
            
        case .medium:
            return GADAdSizeMediumRectangle
            
        case .fullBanner:
            return GADAdSizeFullBanner
            
        case .leaderboard:
            return GADAdSizeLeaderboard
            
        case .skyscraper:
            return GADAdSizeSkyscraper
            
        case .fluid:
            return GADAdSizeFluid
            
        case .invalid:
            return GADAdSizeInvalid
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
