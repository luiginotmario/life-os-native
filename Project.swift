import ProjectDescription

let project = Project(
    name: "LifeOS",
    targets: [
        // iOS App Target
        Target(
            name: "LifeOS_iOS",
            platform: .iOS,
            product: .app,
            bundleId: "com.voltaic.lifeos",
            deploymentTarget: .iOS(targetVersion: "17.0", devices: [.iphone]),
            infoPlist: .extendingDefault(with: [
                "UILaunchScreen": [
                    "UIColorName": "",
                    "UIImageName": ""
                ],
                "NSFaceIDUsageDescription": "Life OS uses Face ID to secure your Agent's Mission Control.",
                "NSSupportsLiveActivities": true
            ]),
            sources: ["Targets/LifeOS_iOS/Sources/**"],
            resources: ["Targets/LifeOS_iOS/Resources/**"],
            dependencies: []
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
