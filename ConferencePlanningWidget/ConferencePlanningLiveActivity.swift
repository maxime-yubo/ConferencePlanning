//
//  ConferencePlanningLiveActivity.swift
//  ConferencePlanningWidget
//
//  Created by Maxime de Chalendar on 02/10/2025.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct ConferencePlanningLiveActivity: Widget {

    var body: some WidgetConfiguration {
        ActivityConfiguration(
            for: ConferencePlanningAttributes.self,
            content: { context in
                ConferencePlanningLockScreen(context: context)
            },
            dynamicIsland: { context in
                DynamicIsland(
                    expanded: {
                        DynamicIslandExpandedRegion(.bottom) {
                            ConferencePlanningDynamicIslandBottom(context: context)
                        }

                        DynamicIslandExpandedRegion(.trailing) {
                            ConferencePlanningDynamicIslandTrailing(context: context)
                        }

                        DynamicIslandExpandedRegion(.leading) {
                            ConferencePlanningDynamicIslandLeading()
                        }
                    },
                    compactLeading: {
                        ConferencePlanningDynamicIslandCompact(mode: .leading, context: context)
                    },
                    compactTrailing: {
                        ConferencePlanningDynamicIslandCompact(mode: .trailing, context: context)
                    },
                    minimal: {
                        ConferencePlanningDynamicIslandCompact(mode: .minimal, context: context)
                    }
                )
            }
        )
    }

}
