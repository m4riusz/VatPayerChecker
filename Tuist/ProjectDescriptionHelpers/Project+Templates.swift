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
                           dependencies: dependencies,
                           settings: Settings(configurations: [
                            .debug(name: "Debug", settings: [
                                "PRODUCT_NAME": .string("\(name) (debug)"),
                                "PRODUCT_BUNDLE_IDENTIFIER": .string("pl.msut.\(name)Debug")]),
                            .release(name: "Release", settings: [
                                "PRODUCT_NAME": .string(name),
                                "PRODUCT_BUNDLE_IDENTIFIER": .string("pl.msut.\(name)")]),
                           ])),
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
            ],
                schemes: [
                    Scheme(name: "\(name) (debug)",
                        buildAction: BuildAction(targets: [.init(stringLiteral: name)]),
                        testAction: TestAction(targets: [TestableTarget(stringLiteral: "\(name)Test"),
                                                         TestableTarget(stringLiteral: "\(name)UTTest")]),
                        runAction: RunAction(configurationName: "Debug"),
                        archiveAction: ArchiveAction(configurationName: "Debug"),
                        profileAction: ProfileAction(configurationName: "Debug"),
                        analyzeAction: AnalyzeAction(configurationName: "Debug")),
                    Scheme(name: "\(name) (Release)",
                        buildAction: BuildAction(targets: [.init(stringLiteral: name)]),
                        testAction: TestAction(targets: []),
                        runAction: RunAction(configurationName: "Release"),
                        archiveAction: ArchiveAction(configurationName: "Release"),
                        profileAction: ProfileAction(configurationName: "Release"),
                        analyzeAction: AnalyzeAction(configurationName: "Release"))
        ])
    }
}
