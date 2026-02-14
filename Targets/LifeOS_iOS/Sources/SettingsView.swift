import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Gateway")) {
                    HStack {
                        Text("Status")
                        Spacer()
                        Text("Online")
                            .foregroundStyle(.green)
                    }
                    HStack {
                        Text("Server")
                        Spacer()
                        Text("CPX11 (Hetzner)")
                            .foregroundStyle(.secondary)
                    }
                }
                
                Section(header: Text("Integrations")) {
                    Toggle("WhatsApp Business", isOn: .constant(true))
                    Toggle("Telegram", isOn: .constant(true))
                    Toggle("iMessage Relay", isOn: .constant(false))
                }
                
                Section(header: Text("Brain")) {
                    HStack {
                        Text("Model")
                        Spacer()
                        Text("Claude 3.5 Sonnet")
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}
