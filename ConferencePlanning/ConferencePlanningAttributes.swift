import ActivityKit
import Foundation

struct ConferencePlanningAttributes: ActivityAttributes {

    let name: String

    struct ContentState: Codable, Hashable {
        let activeTalk: String
        let upcomingTalk: String
        let upcomingTalkStart: Date?
    }

}

// For Previews
extension ConferencePlanningAttributes {
    static let swiftConnection: Self = .init(
        name: "🇫🇷 Swift Connection"
    )
}

extension ConferencePlanningAttributes.ContentState {
    static let initialState: Self = .init(
        activeTalk: "Live Activities",
        upcomingTalk: "Swift on Linux on Mac",
        upcomingTalkStart: Date(timeIntervalSinceNow: 60)
    )

    static let updatedState: Self = .init(
        activeTalk: "Swift on Linux on Mac",
        upcomingTalk: "🧀🍷 Swift Connection Party",
        upcomingTalkStart: Date(timeIntervalSinceNow: 60)
    )

    static let finalState: Self = .init(
        activeTalk: "🧀🍷 Swift Connection Party",
        upcomingTalk: "🛌",
        upcomingTalkStart: nil
    )

    static func allCases() -> [Self] { [
        .initialState,
        .updatedState,
        .finalState
    ] }
}
