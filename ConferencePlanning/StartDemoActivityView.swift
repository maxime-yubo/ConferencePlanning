import SwiftUI

import OSLog

struct StartDemoActivityView: View {

    let demo = SwiftConnectionActivityDemo()

    var body: some View {
        VStack {
            Button("Start activity") {
                Task {
                    do {
                        let activity = try demo.startActivity()
                        await demo.delay()
                        await demo.updateActivity(activity)
                        await demo.delay()
                        await demo.endActivity(activity)
                    } catch {
                        Logger.conferencePlanning.error("Couldn't start the demo activity: \(error)")
                    }
                }
            }
        }
        .padding()
    }
}
