
import SwiftUI

@main
struct BicycleRideTrackerApp: App {
    @StateObject private var appSettings = AppSettings()

    var body: some Scene {
        WindowGroup {
            SplashScreenView()
                .environmentObject(appSettings)
        }
    }
}
