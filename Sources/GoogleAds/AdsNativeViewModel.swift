import Combine
import GoogleMobileAds

public class AdsNativeViewModel: NSObject, ObservableObject {
    
    @Published var nativeAd: GADNativeAd?
    
    private var loader: GADAdLoader?
    
    public func refresh(unitId: String) {
        loader = .init(
            adUnitID: unitId,
            rootViewController: nil,
            adTypes: [.native],
            options: nil)
        
        loader?.delegate = self
        loader?.load(.init())
    }
}

extension AdsNativeViewModel: GADNativeAdLoaderDelegate {
     public func adLoader(_ adLoader: GADAdLoader, didReceive nativeAd: GADNativeAd) {
        self.nativeAd = nativeAd
        nativeAd.delegate = self
    }
    
    public func adLoader(_ adLoader: GADAdLoader, didFailToReceiveAdWithError error: Error) {
#if DEBUG
        debugPrint("\(adLoader) failed with error: \(error.localizedDescription)")
#endif
    }
}

extension AdsNativeViewModel: GADNativeAdDelegate {
    public func nativeAdDidRecordClick(_ nativeAd: GADNativeAd) {
#if DEBUG
        debugPrint("\(#function) called")
#endif
    }
    
    public func nativeAdDidRecordImpression(_ nativeAd: GADNativeAd) {
#if DEBUG
        debugPrint("\(#function) called")
#endif
    }
    
    public func nativeAdWillPresentScreen(_ nativeAd: GADNativeAd) {
#if DEBUG
        debugPrint("\(#function) called")
#endif
    }
    
    public func nativeAdWillDismissScreen(_ nativeAd: GADNativeAd) {
#if DEBUG
        debugPrint("\(#function) called")
#endif
    }
    
    public func nativeAdDidDismissScreen(_ nativeAd: GADNativeAd) {
#if DEBUG
        debugPrint("\(#function) called")
#endif
    }
}
