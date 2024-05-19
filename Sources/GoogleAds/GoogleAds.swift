// The Swift Programming Language
// https://docs.swift.org/swift-book
import GoogleMobileAds

// https://developers.google.com/admob/ios/quick-start?hl=zh-tw
// https://github.com/googleads/googleads-mobile-ios-examples/tree/main/Swift/advanced/SwiftUIDemo
public enum GoogleAds {
    public static func register(completion: ((GADInitializationStatus) -> Void)? = nil) {
        GADMobileAds.sharedInstance().start(completionHandler: completion)
    }
}
