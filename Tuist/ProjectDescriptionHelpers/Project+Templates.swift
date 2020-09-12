import ProjectDescription

extension Project {
    
    public static func framework(name: String,
                                 dependencies: [TargetDependency]) -> Project {
        let frameworkTarget = TargetBuilder()
            .setName(name)
            .setProduct(.framework)
            .setBaseBundleId("pl.msut")
            .setDependencies(dependencies)
            .build()
        
        let frameworkTargetTest = TargetBuilder()
            .setName(name)
            .setProduct(.unitTests)
            .setBaseBundleId("pl.msut")
            .setDependencies([
                .target(name: name),
                .xctest
            ])
            .build()
        
        return Project(name: name,
                       targets: [
                        frameworkTarget,
                        frameworkTargetTest
        ])
    }
    
    public static func app(name: String,
                            dependencies: [TargetDependency]) -> Project {
        let appTarget = TargetBuilder()
            .setName(name)
            .setProduct(.app)
            .setBaseBundleId("pl.msut")
            .setDependencies(dependencies)
            .setSettings(Settings(configurations: [
                .debug(name: "Debug", settings: [
                    "PRODUCT_NAME": .string("\(name) (debug)"),
                    "PRODUCT_BUNDLE_IDENTIFIER": .string("pl.msut.\(name)Debug")]),
                .release(name: "Release", settings: [
                    "PRODUCT_NAME": .string(name),
                    "PRODUCT_BUNDLE_IDENTIFIER": .string("pl.msut.\(name)")]),
            ]))
            .build()
        
        let appTargetTests = TargetBuilder()
            .setName(name)
            .setProduct(.unitTests)
            .setBaseBundleId("pl.msut")
            .setDependencies([
                .target(name: name),
                .xctest
            ])
            .build()
        
        let appTargetUITests = TargetBuilder()
            .setName(name)
            .setProduct(.uiTests)
            .setBaseBundleId("pl.msut")
            .setDependencies([
                .target(name: name),
                .xctest
            ])
            .build()
        
        return Project(name: name,
                       targets: [ appTarget, appTargetTests, appTargetUITests],
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
