import ProjectDescription

enum Targets {
    case testKit
    case common
    case commonTests
    case core
    case coreTests
    case mobileApp
    case mobileAppTests
    case mobileAppUITests
    
    var name: String {
        switch self {
        case .testKit:
            return "TestKit"
        case .common, .commonTests:
            return "Common"
        case .core, .coreTests:
            return "Core"
        case .mobileApp, .mobileAppTests, .mobileAppUITests:
            return "MobileApp"
        }
    }
    
    var actions: [TargetAction] {
        switch self {
        case .common, .core, .mobileApp:
            return [.pre(tool: "swiftlint",
                         arguments: ["--path ${SRCROOT} --config ../.swiftlint.yml"],
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
        case .mobileApp:
            return [.package(product: "Swinject"),
                    .package(product: "SFSafeSymbols"),
                    .project(target: Targets.common.name,
                             path: Projects.common.relativeManifestPath),
                    .project(target: Targets.core.name,
                             path: Projects.core.relativeManifestPath)]
        case .mobileAppTests:
            return [.package(product: "SnapshotTesting"),
                    .target(name: Targets.mobileApp.name),
                    .project(target: Targets.testKit.name,
                             path: Projects.testKit.relativeManifestPath)]
        case .mobileAppUITests:
            return [.target(name: Targets.mobileApp.name),
                    .project(target: Targets.testKit.name,
                             path: Projects.testKit.relativeManifestPath)]
        }
    }
    
    var product: Product {
        switch self {
        case .testKit, .common, .core:
            return .framework
        case .mobileApp:
            return .app
        case .commonTests, .coreTests, .mobileAppTests:
            return .unitTests
        case .mobileAppUITests:
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
