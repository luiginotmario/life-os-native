import SwiftUI

struct ContentView: View {
    @State private var isLoggedIn = false
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Group {
            if isLoggedIn {
                TabView {
                    DashboardView()
                        .tabItem {
                            Label("Mission Control", systemImage: "square.grid.2x2.fill")
                        }
                    
                    ChatView()
                        .tabItem {
                            Label("Chat", systemImage: "message.fill")
                        }
                        
                    SettingsView()
                        .tabItem {
                            Label("Settings", systemImage: "gear")
                        }
                }
                .tint(Color.primary)
            } else {
                OnboardingView(isLoggedIn: $isLoggedIn)
            }
        }
    }
}
