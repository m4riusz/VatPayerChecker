import ProjectDescription

enum Targets {
    case testKit
    case common
    case commonTests
    case core
    case coreTests
    case vatPayerChecker
    case vatPayerCheckerTests
    case vatPayerCheckerUITests
    
    var name: String {
        switch self {
        case .testKit:
            return "TestKit"
        case .common, .commonTests:
            return "Common"
        case .core, .coreTests:
            return "Core"
        case .vatPayerChecker, .vatPayerCheckerTests, .vatPayerCheckerUITests:
            return "VatPayerChecker"
        }
    }
    
    var actions: [TargetAction] {
        switch self {
        case .common, .core, .vatPayerChecker:
            return [.pre(tool: "swiftlint",
                         arguments: ["--path ../"],
                         name: "Swiftlint script")]
        default:
            return []
        }
    }
    
    var dependencies: [TargetDependency] {
        switch self {
        case .testKit:
            return [.xctest]
        case .common:
            return []
        case .commonTests:
            return [.target(name: name),
                    .project(target: Targets.testKit.name,
                             path: Projects.testKit.relativeManifestPath)]
        case .core:
            return [.project(target: Targets.common.name,
                             path: Projects.common.relativeManifestPath)]
        case .coreTests:
            return [.target(name: name),
                    .package(product: "EntwineTest"),
                    .project(target: Targets.testKit.name,
                             path: Projects.testKit.relativeManifestPath)]
        case .vatPayerChecker:
            return [.package(product: "Swinject"),
                    .project(target: Targets.common.name,
                             path: Projects.common.relativeManifestPath),
                    .project(target: Targets.core.name,
                             path: Projects.core.relativeManifestPath)]
        case .vatPayerCheckerTests:
            return [.package(product: "SnapshotTesting"),
                    .target(name: Targets.vatPayerChecker.name),
                    .project(target: Targets.testKit.name,
                             path: Projects.testKit.relativeManifestPath)]
        case .vatPayerCheckerUITests:
            return [.target(name: Targets.vatPayerChecker.name),
                    .project(target: Targets.testKit.name,
                             path: Projects.testKit.relativeManifestPath)]
        }
    }
    
    var product: Product {
        switch self {
        case .testKit, .common, .core:
            return .framework
        case .vatPayerChecker:
            return .app
        case .commonTests, .coreTests, .vatPayerCheckerTests:
            return .unitTests
        case .vatPayerCheckerUITests:
            return .uiTests
        }
    }
    
    var settings: Settings? {
        return nil
    }
    
    var target: Target {
        TargetBuilder()
            .setName(name)
            .setProduct(product)
            .setBaseBundleId(Projects.bundleId)
            .setDependencies(dependencies)
            .setSettings(settings)
            .setActions(actions)
            .build()
    }
}
