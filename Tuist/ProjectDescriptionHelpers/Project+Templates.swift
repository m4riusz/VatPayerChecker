import ProjectDescription

extension Project {
    
    private static func bundleId(_ name: String) -> String {
        "pl.msut.\(name)"
    }
    
    private static func bundleIdUnitTest(_ name: String) -> String {
        bundleId("\(name)Tests")
    }
    
    private static func bundleIdUITest(_ name: String) -> String {
        bundleId("\(name)UITests")
    }
    
    public static func framework(name: String,
                                 platform: Platform,
                                 dependencies: [TargetDependency]) -> Project {
        Project(name: name,
                targets: [
                    Target(name: name,
                           platform: platform,
                           product: .framework,
                           bundleId: bundleId(name),
                        infoPlist: .file(path: .relativeToManifest("./\(name).plist")),
                        sources: ["Sources/**"],
                        resources: ["Resources/**"],
                        dependencies: dependencies),
                    Target(name: "\(name)Tests",
                        platform: platform,
                        product: .unitTests,
                        bundleId: bundleIdUnitTest(name),
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
                           bundleId: bundleId(name),
                        infoPlist: .file(path: .relativeToManifest("./\(name).plist")),
                        sources: ["Sources/**"],
                        resources: ["Resources/**"],
                        dependencies: dependencies),
                    Target(name: "\(name)Tests",
                        platform: platform,
                        product: .unitTests,
                        bundleId: bundleIdUnitTest(name),
                        infoPlist: .file(path: .relativeToManifest("./\(name)Tests.plist")),
                        sources: "Tests/**",
                        dependencies: [
                            .target(name: "\(name)"),
                            .xctest
                    ]),
                    Target(name: "\(name)UITests",
                        platform: platform,
                        product: .uiTests,
                        bundleId: bundleIdUITest(name),
                        infoPlist: .file(path: .relativeToManifest("./\(name)UITests.plist")),
                        sources: "UITests/**",
                        dependencies: [
                            .target(name: "\(name)"),
                            .xctest
                    ])
        ])
    }
}
