//
//  ConferencePlanningLockScreen.swift
//  ConferencePlanningWidget
//
//  Created by Maxime de Chalendar on 03/10/2025.
//

import SwiftUI
import WidgetKit
import ActivityKit

struct ConferencePlanningLockScreen: View {

    let context: ActivityViewContext<ConferencePlanningAttributes>

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            currentTalk
            upcompingTalk
        }
        .font(.headline)
        .lineLimit(1)
        .padding()
    }

    @ViewBuilder
    private var currentTalk: some View {
        HStack {

            VStack(alignment: .leading, spacing: 0) {
                Text(context.state.activeTalk)
                    .id(context.state.activeTalk)
                    .transition(.push(from: .bottom))

                if let upcomingTalkStart = context.state.upcomingTalkStart {
                    ProgressView(timerInterval: Date.now...upcomingTalkStart, countsDown: false)
                        .labelsHidden()
                }
            }

            // Should use the AppIntent framework instead
            // This is for demo purposes only
            // See: https://developer.apple.com/documentation/widgetkit/adding-interactivity-to-widgets-and-live-activities
            Button("Ask a question") { }
        }
    }

    @ViewBuilder
    private var upcompingTalk: some View {
        Text("Up next: \(Text(context.state.upcomingTalk).font(.body))")
            .id(context.state.upcomingTalk)
            .transition(.push(from: .bottom))
            .foregroundStyle(.secondary)
    }

}

#Preview(
    as: .content,
    using: ConferencePlanningAttributes.swiftConnection,
    widget: ConferencePlanningLiveActivity.init,
    contentStates: ConferencePlanningAttributes.ContentState.allCases
)
