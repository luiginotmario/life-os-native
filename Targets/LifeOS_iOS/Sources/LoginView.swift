import SwiftUI
import AuthenticationServices

struct LoginView: View {
    @Binding var isLoggedIn: Bool
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            // Background Image (Placeholder for "Mountain inside Paper")
            // In a real app, this would be: Image("mountain_paper_bg").resizable().scaledToFill()
            LinearGradient(
                colors: [Color(hex: "FDFBF7"), Color(hex: "E2E2E2")],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            // Subtle "Paper" Texture overlay or shapes
            GeometryReader { proxy in
                Circle()
                    .fill(Color.blue.opacity(0.05))
                    .blur(radius: 60)
                    .frame(width: 300, height: 300)
                    .position(x: proxy.size.width * 0.2, y: proxy.size.height * 0.3)
                
                Circle()
                    .fill(Color.orange.opacity(0.05))
                    .blur(radius: 60)
                    .frame(width: 250, height: 250)
                    .position(x: proxy.size.width * 0.8, y: proxy.size.height * 0.6)
            }
            
            VStack {
                Spacer()
                
                // Main Content
                VStack(spacing: 16) {
                    // App Logo (Serif 'L' on Circle)
                    ZStack {
                        Circle()
                            .fill(.white)
                            .frame(width: 80, height: 80)
                            .shadow(color: .black.opacity(0.1), radius: 10, y: 5)
                        
                        Text("L")
                            .font(.system(size: 40, weight: .semibold, design: .serif))
                            .italic()
                            .foregroundStyle(.black)
                    }
                    .padding(.bottom, 8)
                    
                    Text("Life OS")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(.black)
                    
                    Text("Your second brain.\nRunning locally.")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.gray)
                }
                
                Spacer()
                
                // Auth Buttons Container
                VStack(spacing: 16) {
                    // Continue with Google
                    Button(action: {
                        withAnimation { isLoggedIn = true }
                    }) {
                        HStack {
                            Image(systemName: "globe") // Google G placeholder
                            Text("Continue with Google")
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .clipShape(Capsule())
                        .shadow(color: .black.opacity(0.1), radius: 5, y: 2)
                    }
                    
                    // Terms
                    Text("By clicking continue, you agree to our Terms and Privacy Policy.")
                        .font(.caption2)
                        .foregroundStyle(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 50)
            }
        }
    }
}

// Hex Color Helper
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
