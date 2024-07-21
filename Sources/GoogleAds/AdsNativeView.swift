import SwiftUI
import GoogleMobileAds

public struct AdsNativeView: UIViewRepresentable {
    public typealias UIViewType = GADNativeAdView
    
    @ObservedObject private var viewModel: AdsNativeViewModel
    private var adView: GADNativeAdView
    
    public init(viewModel: AdsNativeViewModel, adView: GADNativeAdView) {
        self.viewModel = viewModel
        self.adView = adView
    }
    
    public func makeUIView(context: Context) -> GADNativeAdView {
        adView
    }
    
    public func updateUIView(_ uiView: GADNativeAdView, context: Context) {
        guard let nativeAd = viewModel.nativeAd else {
            return
        }
        
        (uiView.headlineView as? UILabel)?.text = nativeAd.headline
        
        uiView.mediaView?.mediaContent = nativeAd.mediaContent
        
        (uiView.bodyView as? UILabel)?.text = nativeAd.body
        
        (uiView.iconView as? UIImageView)?.image = nativeAd.icon?.image
        
//        (uiView.starRatingView as? UIImageView)?.image = imageOfStars(from: nativeAd.starRating)
        
        (uiView.storeView as? UILabel)?.text = nativeAd.store
        
        (uiView.priceView as? UILabel)?.text = nativeAd.price
        
        (uiView.advertiserView as? UILabel)?.text = nativeAd.advertiser
        
        (uiView.callToActionView as? UIButton)?.setTitle(nativeAd.callToAction, for: .normal)
        
        // In order for the SDK to process touch events properly, user interaction should be disabled.
        uiView.callToActionView?.isUserInteractionEnabled = false
        
        // Associate the native ad view with the native ad object. This is required to make the ad clickable.
        // Note: this should always be done after populating the ad views.
        uiView.nativeAd = nativeAd
    }
}
