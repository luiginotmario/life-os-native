import ProjectDescription

let project = Project(
    name: "LifeOS",
    packages: [
        .remote(url: "https://github.com/google/GoogleSignIn-iOS", requirement: .upToNextMajor(from: "7.0.0"))
    ],
    targets: [
        // iOS App Target
        Target(
            name: "LifeOS_iOS",
            platform: .iOS,
            product: .app,
            bundleId: "com.voltaic.lifeos",
            deploymentTarget: .iOS(targetVersion: "17.0", devices: [.iphone, .ipad]),
            infoPlist: .extendingDefault(with: [
                "UILaunchScreen": [
                    "UIColorName": "",
                    "UIImageName": ""
                ],
                "NSFaceIDUsageDescription": "Life OS uses Face ID to secure your Agent's Mission Control.",
                "NSSupportsLiveActivities": true,
                "GIDClientID": "$(GID_CLIENT_ID)",
                "CFBundleURLTypes": [
                    [
                        "CFBundleURLSchemes": ["$(GID_REVERSED_CLIENT_ID)"]
                    ]
                ]
            ]),
            sources: ["Targets/LifeOS_iOS/Sources/**"],
            resources: ["Targets/LifeOS_iOS/Resources/**"],
            dependencies: [
                .package(product: "GoogleSignIn")
            ],
            settings: .settings(configurations: [
                .debug(name: "Debug", settings: [
                    "GID_CLIENT_ID": "YOUR_CLIENT_ID",
                    "GID_REVERSED_CLIENT_ID": "YOUR_REVERSED_CLIENT_ID"
                ]),
                .release(name: "Release", settings: [
                    "GID_CLIENT_ID": "YOUR_CLIENT_ID",
                    "GID_REVERSED_CLIENT_ID": "YOUR_REVERSED_CLIENT_ID"
                ])
            ])
        ),
        // macOS App Target (Catalyst or Native)
        Target(
            name: "LifeOS_macOS",
            platform: .macOS,
            product: .app,
            bundleId: "com.voltaic.lifeos.mac",
            deploymentTarget: .macOS(targetVersion: "14.0"),
            infoPlist: .default,
            sources: ["Targets/LifeOS_macOS/Sources/**"],
            resources: ["Targets/LifeOS_macOS/Resources/**"],
            dependencies: []
        ),
        // Widget Extension (Shared)
        Target(
            name: "LifeOSWidgets",
            platform: .iOS,
            product: .appExtension,
            bundleId: "com.voltaic.lifeos.widgets",
            infoPlist: .extendingDefault(with: [
                "NSExtension": [
                    "NSExtensionPointIdentifier": "com.apple.widget-extension"
                ]
            ]),
            sources: ["Targets/LifeOSWidgets/Sources/**"],
            resources: ["Targets/LifeOSWidgets/Resources/**"],
            dependencies: []
        )
    ]
)
