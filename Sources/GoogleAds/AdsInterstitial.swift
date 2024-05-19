import GoogleMobileAds

/// 插頁式廣告
public class AdsInterstitial: NSObject {
    private var interstitialAd: GADInterstitialAd?
    
    enum Error: Swift.Error {
        case adsNotReady
    }
    
    public func loadAds(id: String) async throws {
        interstitialAd = try await GADInterstitialAd.load(withAdUnitID: id, request: GADRequest())
        interstitialAd?.fullScreenContentDelegate = self
    }
    
    public func showAd() throws {
        guard let interstitialAd = interstitialAd else {
            throw Error.adsNotReady
        }
        interstitialAd.present(fromRootViewController: nil)
    }
}

// MARK: - GADFullScreenContentDelegate methods
extension AdsInterstitial: GADFullScreenContentDelegate {
    public func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        interstitialAd = nil
    }
}
