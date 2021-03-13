import ProjectDescription

enum MobileAppScheme {
    case dev
    case production
    case uiTests
    
    var name: String {
        switch self {
        case .dev:
            return "\(Projects.mobileApp.name)-Dev"
        case .production:
            return "\(Projects.mobileApp.name)-Production"
        case .uiTests:
            return "\(Projects.mobileApp.name)-UITests"
        }
    }
    
    var arguments: Arguments {
        switch self {
        case .dev, .uiTests:
            return Arguments(environment: ["Dev": "YES",
                                           "ConsoleLog": "YES"],
                             launchArguments: [])
        case .production:
            return Arguments(environment: ["Dev": "YES",
                                           "ConsoleLog": "YES"],
                             launchArguments: [])
        }
    }
    
    var presetConfig: PresetBuildConfiguration {
        switch self {
        case .dev, .uiTests:
            return .debug
        case .production:
            return .release
        }
    }
    
    var diagnosticOptions: [SchemeDiagnosticsOption] {
        switch self {
        case .dev, .uiTests:
            return [.mainThreadChecker]
        case .production:
            return []
        }
    }
    
    var testableTargets: [TestableTarget] {
        switch self {
        case .dev, .production:
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
    
    var runAction: RunAction? {
        RunAction(config: presetConfig,
                  executable: TargetReference(projectPath: Projects.mobileApp.path, target: Targets.mobileApp.name),
                  arguments: arguments,
                  diagnosticsOptions: diagnosticOptions)
    }
    
    var testAction: TestAction? {
        TestAction(targets: testableTargets,
                   arguments: arguments,
                   config: presetConfig,
                   coverage: true,
                   codeCoverageTargets: [.project(path: Projects.mobileApp.path, target: Targets.mobileApp.name)],
                   preActions: [],
                   postActions: [],
                   diagnosticsOptions: diagnosticOptions,
                   language: "pl",
                   region: "PL")
    }
    
    var archiveAction: ArchiveAction? {
        switch self {
        case .dev, .uiTests:
            return ArchiveAction(configurationName: "Debug")
        case .production:
            return ArchiveAction(configurationName: "Release")
        }
    }
    
    var profileAction: ProfileAction? {
        switch self {
        case .dev, .uiTests:
            return ProfileAction(configurationName: "Debug")
        case .production:
            return ProfileAction(configurationName: "Release")
        }
    }
    
    var analyzeAction: AnalyzeAction {
        switch self {
        case .dev, .uiTests:
            return AnalyzeAction(configurationName: "Debug")
        case .production:
            return AnalyzeAction(configurationName: "Release")
        }
    }
    
    var scheme: Scheme {
        SchemeBuilder()
            .setName(name: name)
            .setBuildAction(buildAction: buildAction)
            .setRunAction(runAction: runAction)
            .setTestAction(testAction: testAction)
            .setArchiveAction(archiveAction: archiveAction)
            .setProfileAction(profileAction: profileAction)
            .setAnalyzeAction(analyzeAction: analyzeAction)
            .build()
    }
}
