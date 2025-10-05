import SwiftUI

@main
struct ConferencePlanningApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            StartDemoActivityView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        /// Keep in mind that this might be called while your app is in the background if a live activity
        /// is started remotely. Pay a specific attention to protected data availability for instance
        /// (keychain, user defaults, file system...)
        ///
        /// Also, since your app might have been killed with an active live activity, a stale/outdated
        /// activity might still exist, that you might not always expect. You probably want to dismiss
        /// it in this situation.
        /// See: https://developer.apple.com/documentation/activitykit/displaying-live-data-with-live-activities#Observe-active-Live-Activities

        let demo = SwiftConnectionActivityDemo()
        demo.getRemoteLiveActivityPushToStartToken()
        demo.getLiveActivitiesUpdates()

        return true
    }

}
