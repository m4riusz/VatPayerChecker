import ProjectDescription

extension Project {
    
    public static func framework(name: String,
                                 platform: Platform,
                                 dependencies: [TargetDependency]) -> Project {
        Project(name: name,
                targets: [
                    Target(name: name,
                           platform: platform,
                           product: .framework,
                           bundleId: "io.tuist.\(name)",
                        infoPlist: .file(path: .relativeToManifest("./\(name).plist")),
                        sources: ["Sources/**"],
                        resources: ["Resources/**"],
                        dependencies: dependencies),
                    Target(name: "\(name)Tests",
                        platform: platform,
                        product: .unitTests,
                        bundleId: "io.tuist.\(name)Tests",
                        infoPlist: .file(path: .relativeToManifest("./\(name)Tests.plist")),
                        sources: "Tests/**",
                        dependencies: [
                            .target(name: "\(name)"),
                            .xctest
                    ])
        ])
    }
    
    public static func app(name: String,
                           
                           platform: Platform,
                           dependencies: [TargetDependency]) -> Project {
        Project(name: name,
                targets: [
                    Target(name: name,
                           platform: platform,
                           product: .app,
                           bundleId: "io.tuist.\(name)",
                        infoPlist: .file(path: .relativeToManifest("./\(name).plist")),
                        sources: ["Sources/**"],
                        resources: ["Resources/**"],
                        dependencies: dependencies),
                    Target(name: "\(name)Tests",
                        platform: platform,
                        product: .unitTests,
                        bundleId: "io.tuist.\(name)Tests",
                        infoPlist: .file(path: .relativeToManifest("./\(name)Tests.plist")),
                        sources: "Tests/**",
                        dependencies: [
                            .target(name: "\(name)"),
                            .xctest
                    ]),
                    Target(name: "\(name)UITests",
                        platform: platform,
                        product: .uiTests,
                        bundleId: "io.tuist.\(name)UITests",
                        infoPlist: .file(path: .relativeToManifest("./\(name)UITests.plist")),
                        sources: "UITests/**",
                        dependencies: [
                            .target(name: "\(name)"),
                            .xctest
                    ])
        ])
    }
}
