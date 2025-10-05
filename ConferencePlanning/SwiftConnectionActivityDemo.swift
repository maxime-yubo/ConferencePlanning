//
//  ConferencePlanningActivity.swift
//  ConferencePlanning
//
//  Created by Maxime de Chalendar on 02/10/2025.
//

import Foundation
import ActivityKit
import OSLog

struct SwiftConnectionActivityDemo {

    // MARK: - Helpers
    let simulatedDelay: TimeInterval = 15

    func delay() async {
        try? await Task.sleep(for: .seconds(simulatedDelay))
    }

    // MARK: - Activity life-cycle
    func startActivity() throws -> Activity<ConferencePlanningAttributes> {

        let swiftConnection = ConferencePlanningAttributes.swiftConnection

        let initialState = ConferencePlanningAttributes.ContentState.initialState

        let activity = try Activity.request(
            attributes: swiftConnection,
            content: .init(state: initialState, staleDate: nil),
            pushType: .token
        )

        return activity
    }

    func updateActivity(_ activity: Activity<ConferencePlanningAttributes>) async {

        let updatedState = ConferencePlanningAttributes.ContentState.updatedState

        let alertConfiguration = AlertConfiguration(
            title: "New talk has started",
            body: "Don't miss out on the fun!",
            sound: .default
        )

        await activity.update(
            .init(state: updatedState, staleDate: nil),
            alertConfiguration: alertConfiguration
        )
    }

    func endActivity(_ activity: Activity<ConferencePlanningAttributes>) async {

        let finalState = ConferencePlanningAttributes.ContentState.finalState

        await activity.end(
            .init(state: finalState, staleDate: nil),
            dismissalPolicy: .default
        )
    }

    // MARK: - Remote live activities handling
    func getRemoteLiveActivityPushToStartToken() {
        func sendPushToStartTokenToServer(_ token: Data) async {
            Logger.conferencePlanning.debug("Activity: Push To Start has been updated: \(token.pushTokenHumanReadableDescription)")
        }

        Task {
            let tokenUpdates = Activity<ConferencePlanningAttributes>.pushToStartTokenUpdates
            for await token in tokenUpdates {
                await sendPushToStartTokenToServer(token)
            }
        }
    }

    func getLiveActivitiesUpdates() {
        Task {
            for await activity in Activity<ConferencePlanningAttributes>.activityUpdates {
                // This is just a simple implementation, however, it should definitely be improved upon,
                // for things such as cancellation, not listening to the push token for same activity twice, etc.
                self.getLiveActivityPushToken(activity)
                self.getLiveActivityContentUpdates(activity)
            }
        }
    }

    func getLiveActivityPushToken(_ activity: Activity<ConferencePlanningAttributes>) {
        func sendPushTokenToServer(_ token: Data) async {
            Logger.conferencePlanning.debug("Activity [\(activity.id)]: Push Token has been updated: \(token.pushTokenHumanReadableDescription)")
        }

        Task {
            for await token in activity.pushTokenUpdates {
                await sendPushTokenToServer(token)
            }
        }
    }

    func getLiveActivityContentUpdates(_ activity: Activity<ConferencePlanningAttributes>) {
        Task {
            for await status in activity.activityStateUpdates {
                switch status {
                case .active:
                    Logger.conferencePlanning.debug("Activity [\(activity.id)]: is active")
                case .stale:
                    Logger.conferencePlanning.debug("Activity [\(activity.id)]: is stale")
                case .ended:
                    Logger.conferencePlanning.debug("Activity [\(activity.id)]: has ended")
                case .dismissed:
                    Logger.conferencePlanning.debug("Activity [\(activity.id)]: has been dismissed by the user")
                @unknown default:
                    Logger.conferencePlanning.debug("Activity [\(activity.id)]: state has changed to an unknown value")
                }
            }
        }

        Task {
            for await content in activity.contentUpdates {
                Logger.conferencePlanning.debug("Activity [\(activity.id)]: ContentState has been updated: \(content.description)")
            }
        }
    }

}
