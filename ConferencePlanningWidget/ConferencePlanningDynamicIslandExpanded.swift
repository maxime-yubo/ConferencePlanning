//
//  ConferencePlanningDynamicIslandExpanded.swift
//  ConferencePlanningWidget
//
//  Created by Maxime de Chalendar on 03/10/2025.
//

import SwiftUI
import WidgetKit
import ActivityKit

// MARK: - Leading
struct ConferencePlanningDynamicIslandLeading: View {

    var body: some View {
        // Should use the AppIntent framework instead
        // This is for demo purposes only
        // See: https://developer.apple.com/documentation/widgetkit/adding-interactivity-to-widgets-and-live-activities
        Button("Ask Q&A") { }
    }

}

// MARK: - Trailing
struct ConferencePlanningDynamicIslandTrailing: View {

    let context: ActivityViewContext<ConferencePlanningAttributes>

    var body: some View {
        Text("Up next: \(Text(context.state.upcomingTalk).fontWeight(.regular))")
            .font(.caption)
            .bold()
            .id(context.state.upcomingTalk)
            .transition(.push(from: .bottom))
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.trailing)
    }

}

// MARK: - Bottom
struct ConferencePlanningDynamicIslandBottom: View {

    let context: ActivityViewContext<ConferencePlanningAttributes>

    var body: some View {
        VStack {

            HStack(spacing: 0) {
                Text(context.state.activeTalk)
                    .font(.title2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .id(context.state.activeTalk)
                    .transition(.push(from: .bottom))

                if let upcomingTalkStart = context.state.upcomingTalkStart {
                    Text("Ends at ")
                    Text(upcomingTalkStart, style: .time)
                }
            }

            if let upcomingTalkStart = context.state.upcomingTalkStart {
                ProgressView(timerInterval: Date.now...upcomingTalkStart, countsDown: false)
                    .labelsHidden()
            }

        }
        .frame(maxHeight: .infinity)
    }

}

#Preview(
    as: .dynamicIsland(.expanded),
    using: ConferencePlanningAttributes.swiftConnection,
    widget: ConferencePlanningLiveActivity.init,
    contentStates: ConferencePlanningAttributes.ContentState.allCases
)
