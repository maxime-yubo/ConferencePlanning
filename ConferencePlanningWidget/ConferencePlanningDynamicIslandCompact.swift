//
//  ConferencePlanningDynamicIslandCompact.swift
//  ConferencePlanningWidget
//
//  Created by Maxime de Chalendar on 03/10/2025.
//

import SwiftUI
import WidgetKit
import ActivityKit

struct ConferencePlanningDynamicIslandCompact: View {

    enum DisplayMode {
        case leading
        case trailing
        case minimal
    }

    let mode: DisplayMode
    let context: ActivityViewContext<ConferencePlanningAttributes>

    var body: some View {
        VStack {
            switch mode {
            case .leading:
                Text(context.state.activeTalk)
                    .minimumScaleFactor(0.3)
            case .trailing:
                Text("Open Q&A")
            case .minimal:
                Text("Q&A")
            }
        }
        .multilineTextAlignment(.center)
        .font(.caption2)
    }

}

#Preview(
    as: .dynamicIsland(.compact),
    using: ConferencePlanningAttributes.swiftConnection,
    widget: ConferencePlanningLiveActivity.init,
    contentStates: ConferencePlanningAttributes.ContentState.allCases
)

#Preview(
    as: .dynamicIsland(.minimal),
    using: ConferencePlanningAttributes.swiftConnection,
    widget: ConferencePlanningLiveActivity.init,
    contentStates: ConferencePlanningAttributes.ContentState.allCases
)
