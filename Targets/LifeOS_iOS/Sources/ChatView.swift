import SwiftUI

struct ChatView: View {
    @State private var text = ""
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    // Chat History
                    VStack(alignment: .leading, spacing: 12) {
                        Bubble(text: "Reschedule my 3pm call to tomorrow.", isUser: true)
                        Bubble(text: "Done. Moved 'Product Sync' to 10am tomorrow. Notified attendees.", isUser: false)
                        Bubble(text: "Book me an Uber to SFO for 5pm.", isUser: true)
                        Bubble(text: "UberX confirmed. Pickup at 5:00 PM. Est. arrival 5:45 PM.", isUser: false)
                    }
                    .padding()
                }
                
                // Input Area
                HStack {
                    TextField("Ask Life OS...", text: $text)
                        .padding(10)
                        .background(Color(uiColor: .secondarySystemBackground))
                        .clipShape(Capsule())
                    
                    Button(action: {}) {
                        Image(systemName: "mic.fill")
                            .font(.title2)
                            .foregroundStyle(.white)
                            .frame(width: 44, height: 44)
                            .background(Color.blue)
                            .clipShape(Circle())
                    }
                }
                .padding()
                .background(.ultraThinMaterial)
            }
            .navigationTitle("Comms")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct Bubble: View {
    let text: String
    let isUser: Bool
    
    var body: some View {
        HStack {
            if isUser { Spacer() }
            Text(text)
                .padding(12)
                .background(isUser ? Color.blue : Color(uiColor: .secondarySystemBackground))
                .foregroundStyle(isUser ? .white : .primary)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            if !isUser { Spacer() }
        }
    }
}
