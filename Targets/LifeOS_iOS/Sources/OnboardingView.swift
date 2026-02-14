import SwiftUI

struct OnboardingView: View {
    @Binding var isLoggedIn: Bool
    @State private var selectedBrain: String?
    @State private var selectedChannel: String?
    @State private var showChannelSheet = false
    @State private var activeChannelForSheet: String?
    @State private var isProvisioning = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                
                // Header
                VStack(spacing: 8) {
                    Text("Configure your Agent")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    Text("Choose a brain and connect your channels.")
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 40)
                
                // Section 1: Brain
                VStack(alignment: .leading, spacing: 16) {
                    Text("1. SELECT INTELLIGENCE")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(.secondary)
                        .padding(.horizontal)
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                        BrainCard(
                            title: "No Preference",
                            subtitle: "We pick best",
                            icon: "sparkles",
                            color: .purple,
                            isSelected: selectedBrain == "default"
                        ) { selectedBrain = "default" }
                        
                        BrainCard(
                            title: "Claude 3.5",
                            subtitle: "Nuanced & human",
                            icon: "brain.head.profile",
                            color: .orange,
                            isSelected: selectedBrain == "claude"
                        ) { selectedBrain = "claude" }
                        
                        BrainCard(
                            title: "Gemini 1.5",
                            subtitle: "Fast & huge context",
                            icon: "bolt.fill",
                            color: .blue,
                            isSelected: selectedBrain == "gemini"
                        ) { selectedBrain = "gemini" }
                        
                        BrainCard(
                            title: "GPT-4o",
                            subtitle: "Smart reasoning",
                            icon: "circle.grid.2x2.fill", // OpenAI-ish
                            color: .green,
                            isSelected: selectedBrain == "gpt4"
                        ) { selectedBrain = "gpt4" }
                    }
                    .padding(.horizontal)
                }
                
                // Section 2: Channels
                VStack(alignment: .leading, spacing: 16) {
                    Text("2. CONNECT CHANNELS")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(.secondary)
                        .padding(.horizontal)
                    
                    VStack(spacing: 12) {
                        ChannelRow(
                            name: "WhatsApp (Official)",
                            detail: "Business API • Secure",
                            icon: "message.circle.fill",
                            color: .green,
                            isConnected: selectedChannel == "whatsapp"
                        ) {
                            activeChannelForSheet = "whatsapp"
                            showChannelSheet = true
                        }
                        
                        ChannelRow(
                            name: "iMessage",
                            detail: "Apple Native Integration",
                            icon: "message.fill",
                            color: .blue,
                            isConnected: selectedChannel == "imessage"
                        ) {
                            activeChannelForSheet = "imessage"
                            showChannelSheet = true
                        }
                        
                        ChannelRow(
                            name: "Telegram",
                            detail: "Bot API Integration",
                            icon: "paperplane.fill",
                            color: .cyan,
                            isConnected: selectedChannel == "telegram"
                        ) {
                            activeChannelForSheet = "telegram"
                            showChannelSheet = true
                        }
                    }
                    .padding(.horizontal)
                }
                
                // Complete Button
                Button(action: {
                    withAnimation { isProvisioning = true }
                    // Simulate provisioning delay
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation { isLoggedIn = true }
                    }
                }) {
                    HStack {
                        if isProvisioning {
                            ProgressView()
                                .tint(Color(uiColor: .systemBackground))
                                .padding(.trailing, 4)
                            Text("Finalizing...")
                        } else {
                            Text("Complete Setup")
                            Image(systemName: "arrow.right")
                        }
                    }
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(uiColor: .systemBackground))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.primary)
                    .clipShape(Capsule())
                    .opacity((selectedBrain == nil) ? 0.5 : 1)
                }
                .disabled(selectedBrain == nil || isProvisioning)
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
            }
        }
        .sheet(isPresented: $showChannelSheet) {
            ChannelSetupSheet(channel: activeChannelForSheet) {
                selectedChannel = activeChannelForSheet
                showChannelSheet = false
            }
        }
    }
}

struct BrainCard: View {
    let title: String
    let subtitle: String
    let icon: String
    let color: Color
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Image(systemName: icon)
                        .font(.title2)
                        .foregroundStyle(color)
                        .padding(8)
                        .background(color.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    Spacer()
                    if isSelected {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundStyle(Color.primary)
                    }
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.headline)
                        .foregroundStyle(.primary)
                    Text(subtitle)
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }
            }
            .padding(12)
            .background(Color(uiColor: .secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(isSelected ? Color.primary : Color.clear, lineWidth: 2)
            )
        }
        .buttonStyle(.plain)
    }
}

struct ChannelRow: View {
    let name: String
    let detail: String
    let icon: String
    let color: Color
    let isConnected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundStyle(color)
                    .frame(width: 44, height: 44)
                    .background(color.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(name)
                        .font(.headline)
                        .foregroundStyle(.primary)
                    Text(detail)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                
                HStack(spacing: 4) {
                    Text(isConnected ? "Connected" : "Connect")
                        .font(.subheadline)
                        .foregroundStyle(isConnected ? .green : .secondary)
                    
                    Image(systemName: "chevron.right")
                        .font(.caption)
                        .foregroundStyle(.tertiary)
                }
            }
            .padding(16)
            .background(Color(uiColor: .secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(isConnected ? Color.green.opacity(0.5) : Color.clear, lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }
}

struct ChannelSetupSheet: View {
    let channel: String?
    let onConnect: () -> Void
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Split View Layout
                GeometryReader { geometry in
                    if geometry.size.width > 600 {
                        // iPad / Mac Layout (Split)
                        HStack(spacing: 0) {
                            instructionsView
                                .frame(width: geometry.size.width * 0.55)
                            Divider()
                            placeholderView
                                .frame(width: geometry.size.width * 0.45)
                                .background(Color(uiColor: .secondarySystemBackground))
                        }
                    } else {
                        // iPhone Layout (Vertical)
                        VStack(spacing: 0) {
                            instructionsView
                            // No video placeholder on mobile to save vertical space, 
                            // or could be a small card. Keeping clean for now.
                        }
                    }
                }
            }
            .navigationTitle(channelTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
    
    var channelTitle: String {
        switch channel {
        case "whatsapp": return "Connect WhatsApp"
        case "telegram": return "Connect Telegram"
        case "imessage": return "Connect iMessage"
        default: return "Connect"
        }
    }
    
    var instructionsView: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                if channel == "whatsapp" {
                    // WhatsApp Instructions
                    Text("We use the official WhatsApp Cloud API for maximum reliability. Your assistant gets its own dedicated number.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        InstructionStep(num: 1, text: "Create a Meta Business Account.")
                        InstructionStep(num: 2, text: "Add a phone number (receive OTP).")
                        InstructionStep(num: 3, text: "Paste your System User Token below.")
                    }
                    .padding()
                    .background(Color(uiColor: .secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Access Token").font(.caption).fontWeight(.semibold)
                        SecureField("EAA...", text: .constant(""))
                            .textFieldStyle(.roundedBorder)
                    }
                    
                } else if channel == "telegram" {
                    // Telegram Instructions
                    VStack(alignment: .leading, spacing: 16) {
                        InstructionStep(num: 1, text: "Open @BotFather in Telegram.")
                        InstructionStep(num: 2, text: "Send /newbot and follow instructions.")
                        InstructionStep(num: 3, text: "Copy the HTTP API Token provided.")
                    }
                    .padding()
                    .background(Color(uiColor: .secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Bot Token").font(.caption).fontWeight(.semibold)
                        TextField("123456:ABC-DEF...", text: .constant(""))
                            .textFieldStyle(.roundedBorder)
                    }
                    
                } else {
                    // iMessage Instructions
                    VStack(spacing: 20) {
                        Image(systemName: "macbook.and.iphone")
                            .font(.system(size: 60))
                            .foregroundStyle(.blue)
                        Text("iMessage integration requires a Mac running as a server (which you are!). We will install the local relay bridge.")
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.secondary)
                    }
                    .padding()
                }
                
                Spacer()
                
                Button(action: onConnect) {
                    Text("Connect")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                }
                .padding(.top, 20)
            }
            .padding()
        }
    }
    
    var placeholderView: some View {
        VStack {
            Spacer()
            // Placeholder for Video/GIF
            Image(systemName: "iphone")
                .font(.system(size: 80))
                .foregroundStyle(.tertiary)
            Text("Mobile Walkthrough Video")
                .font(.caption)
                .foregroundStyle(.secondary)
                .padding(.top, 8)
            Spacer()
        }
    }
}

struct InstructionStep: View {
    let num: Int
    let text: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Text("\(num)")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .frame(width: 24, height: 24)
                .background(Color.blue)
                .clipShape(Circle())
            Text(text)
                .font(.subheadline)
        }
    }
}
