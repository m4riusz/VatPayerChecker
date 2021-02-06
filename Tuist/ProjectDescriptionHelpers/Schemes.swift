import ProjectDescription

enum MobileAppScheme {
    case dev
    case staging
    case production
    case uiTests
    
    var name: String {
        switch self {
        case .dev:
            return "\(Projects.mobileApp.name)-Dev"
        case .staging:
            return "\(Projects.mobileApp.name)-Staging"
        case .production:
            return "\(Projects.mobileApp.name)-Production"
        case .uiTests:
            return "\(Projects.mobileApp.name)-UITests"
        }
    }
    
    var arguments: Arguments {
        switch self {
        case .dev:
            return Arguments(environment: [:], launchArguments: ["Dev": true])
        case .staging:
            return Arguments(environment: [:], launchArguments: ["Staging": true])
        case .production:
            return Arguments(environment: [:], launchArguments: [:])
        case .uiTests:
            return Arguments(environment: [:], launchArguments: ["Dev": true])
        }
    }
    
    var presetConfig: PresetBuildConfiguration {
        switch self {
        case .dev:
            return .debug
        case .staging:
            return .debug
        case .production:
            return .release
        case .uiTests:
            return .debug
        }
    }
    
    var testableTargets: [TestableTarget] {
        switch self {
        case .dev, .staging, .production:
            return [TestableTarget(target: TargetReference(projectPath: Projects.mobileApp.path, target: Targets.mobileAppTests.name))
            ]
        case .uiTests:
            return [TestableTarget(target: TargetReference(projectPath: Projects.mobileApp.path, target: Targets.mobileAppUITests.name))]
        }
    }
    
    var buildAction: BuildAction? {
        BuildAction(targets: [
            TargetReference(projectPath: Projects.mobileApp.path, target: Targets.mobileApp.name)
        ])
    }
    
    var testAction: TestAction? {
        TestAction(targets: testableTargets,
                   arguments: arguments,
                   config: presetConfig,
                   coverage: true,
                   codeCoverageTargets: [.project(path: Projects.mobileApp.path, target: Targets.mobileApp.name)],
                   preActions: [],
                   postActions: [],
                   diagnosticsOptions: presetConfig == .debug ? [.mainThreadChecker] : [],
                   language: "pl",
                   region: "PL")
    }
    
    var archiveAction: ArchiveAction? {
        ArchiveAction(configurationName: presetConfig.rawValue)
    }
    
    var profileAction: ProfileAction? {
        ProfileAction(configurationName: presetConfig.rawValue)
    }
    
    var analyzeAction: AnalyzeAction {
        AnalyzeAction(configurationName: presetConfig.rawValue)
    }
    
    var scheme: Scheme {
        SchemeBuilder()
            .setName(name: name)
            .setBuildAction(buildAction: buildAction)
            .setTestAction(testAction: testAction)
            .setArchiveAction(archiveAction: archiveAction)
            .setProfileAction(profileAction: profileAction)
            .setAnalyzeAction(analyzeAction: analyzeAction)
            .build()
    }
}
