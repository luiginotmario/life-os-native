# Life OS (Native)

**Mission Control for your Personal AI Agent.**
Native iOS & macOS interface for the [Life OS](https://github.com/Voltaic-Studio/simple-claw) ecosystem.

![Swift](https://img.shields.io/badge/Swift-5.9-orange.svg) ![Platform](https://img.shields.io/badge/Platform-iOS%20%7C%20macOS-lightgrey.svg) ![Status](https://img.shields.io/badge/Status-Alpha-blue.svg)

## 🍎 Philosophy
This app is built strictly following **Apple Human Interface Guidelines (HIG)**.
- **Native First:** SwiftUI, SF Symbols, SF Pro Typography.
- **Physical Feel:** Haptic feedback on all interactions.
- **Adaptive:** Automatic Light/Dark mode support.
- **Private:** Local-first architecture where possible.

## 🏗️ Architecture
The project is generated using [Tuist](https://tuist.io) to ensure modularity and reproducible builds.

### Targets
- **LifeOS_iOS:** The primary iPhone application (Mission Control).
- **LifeOS_macOS:** Native macOS companion app (not Catalyst).
- **LifeOSWidgets:** Live Activities & Home Screen widgets (Dynamic Island support).

### Key Features
- **Mission Control Dashboard:** Toggle active tools (WhatsApp, Calendar, Linear) with a tap.
- **Native Chat:** iMessage-style interface for talking to your Agent.
- **Live Activities:** Real-time status updates on the Lock Screen/Dynamic Island (e.g., "Booking Uber...").
- **Smart Onboarding:** "Premium SaaS" flow for configuring Intelligence (LLM) and Channels.

## 🚀 Getting Started

### Prerequisites
- Xcode 15+
- [Tuist](https://tuist.io) (`curl -Ls https://install.tuist.io | bash`)

### Build & Run
1.  Clone the repo:
    ```bash
    git clone https://github.com/Voltaic-Studio/life-os-native.git
    cd life-os-native
    ```
2.  Generate the Xcode project:
    ```bash
    tuist generate
    ```
3.  Open `LifeOS.xcodeproj` and run on a Simulator (iPhone 15 Pro recommended).

## 🔒 Security
- **Authentication:** Sign in with Google (planned: Apple Sign-In).
- **Data:** Communicates securely with the Life OS "Supervisor" API (Hetzner VPS).
- **Biometrics:** FaceID integration ready for sensitive actions (Wallet/Payments).

## 🤝 Contributing
1.  Fork the repo.
2.  Create a branch (`feature/amazing-feature`).
3.  Commit changes.
4.  Push to branch.
5.  Open a Pull Request.

---
© 2026 Voltaic Studio.
