import SwiftUI

struct DashboardView: View {
    // Mock Data for Tools/Integrations
    @State private var tools: [ToolItem] = [
        ToolItem(name: "WhatsApp", icon: "message.circle.fill", color: .green, isActive: true),
        ToolItem(name: "iMessage", icon: "message.fill", color: .blue, isActive: false),
        ToolItem(name: "Calendar", icon: "calendar", color: .red, isActive: true),
        ToolItem(name: "Linear", icon: "checklist", color: .purple, isActive: true),
        ToolItem(name: "Gmail", icon: "envelope.fill", color: .orange, isActive: true),
        ToolItem(name: "Notion", icon: "doc.text.fill", color: .black, isActive: false),
        ToolItem(name: "Coinbase", icon: "bitcoinsign.circle.fill", color: .blue, isActive: false),
        ToolItem(name: "ClawdTalk", icon: "phone.fill", color: .green, isActive: true)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    
                    // Header (Apple Style)
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Good Afternoon")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .fontWeight(.medium)
                            Text("Luigi")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                        }
                        Spacer()
                        Image(systemName: "person.crop.circle.fill")
                            .font(.system(size: 40))
                            .foregroundStyle(.secondary)
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                    
                    // Tools Grid
                    VStack(alignment: .leading) {
                        Text("Active Tools")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                            ForEach($tools) { $tool in
                                ToolCard(tool: $tool)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.bottom)
            }
            .navigationBarHidden(true)
        }
    }
}

struct ToolItem: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    let color: Color
    var isActive: Bool
}

struct ToolCard: View {
    @Binding var tool: ToolItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top) {
                Image(systemName: tool.icon)
                    .font(.title2)
                    .foregroundStyle(.white)
                    .frame(width: 40, height: 40)
                    .background(tool.color)
                    .clipShape(Circle())
                
                Spacer()
                
                Toggle("", isOn: $tool.isActive)
                    .labelsHidden()
                    .scaleEffect(0.8)
            }
            
            Text(tool.name)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundStyle(.primary)
        }
        .padding(16)
        .background(Color(uiColor: .secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
