import ActivityKit
import WidgetKit
import SwiftUI

struct LifeOSActivityAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic state updated by the agent
        var activeTask: String
        var status: String
    }
    
    // Static data
    var agentName: String
}

struct LifeOSWidgetsLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: LifeOSActivityAttributes.self) { context in
            // Lock Screen / Banner UI
            VStack {
                HStack {
                    Image(systemName: "brain.head.profile")
                        .foregroundStyle(.purple)
                    Text("Life OS working...")
                        .font(.caption)
                    Spacer()
                    Text(context.state.status)
                        .bold()
                }
                Text(context.state.activeTask)
                    .font(.headline)
            }
            .padding()
            .activityBackgroundTint(Color.black.opacity(0.8))
            .activitySystemActionForegroundColor(Color.white)
            
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI
                DynamicIslandExpandedRegion(.leading) {
                    Label("Life OS", systemImage: "brain")
                        .font(.caption)
                        .foregroundStyle(.purple)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text(context.state.status)
                        .font(.caption)
                        .foregroundStyle(.green)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text(context.state.activeTask)
                        .font(.headline)
                        .multilineTextAlignment(.center)
                }
            } compactLeading: {
                Image(systemName: "brain.fill")
                    .foregroundStyle(.purple)
            } compactTrailing: {
                Text(context.state.status)
                    .font(.caption2)
                    .foregroundStyle(.green)
            } minimal: {
                Image(systemName: "brain.fill")
                    .foregroundStyle(.purple)
            }
        }
    }
}
