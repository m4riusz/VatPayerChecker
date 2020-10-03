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
                    .project(target: Targets.testKit.name,
                             path: Projects.testKit.relativeManifestPath)]
        case .vatPayerChecker:
            return [.project(target: Targets.common.name,
                             path: Projects.common.relativeManifestPath),
                    .project(target: Targets.core.name,
                             path: Projects.core.relativeManifestPath)]
        case .vatPayerCheckerTests:
            return [.target(name: name), .xctest]
        case .vatPayerCheckerUITests:
            return [.target(name: name), .xctest]
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
        switch self {
        case .vatPayerChecker:
            return Settings(configurations: [
                .debug(name: "Debug", settings: [
                    "PRODUCT_NAME": .string("\(name) (debug)"),
                    "PRODUCT_BUNDLE_IDENTIFIER": .string("\(Projects.bundleId).\(name)Debug")]),
                .release(name: "Release", settings: [
                    "PRODUCT_NAME": .string(name),
                    "PRODUCT_BUNDLE_IDENTIFIER": .string("\(Projects.bundleId).\(name)")]),
            ])
        default:
            return nil
        }
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
