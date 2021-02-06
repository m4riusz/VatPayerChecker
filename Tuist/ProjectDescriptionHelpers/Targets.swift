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
        case .common:
            return "Common"
        case .commonTests:
            return "CommonTests"
        case .core:
            return "Core"
        case .coreTests:
            return "CoreTests"
        case .mobileApp:
            return "MobileApp"
        case .mobileAppTests:
            return "MobileAppTests"
        case .mobileAppUITests:
            return "MobileAppUITests"
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
            return [.target(name: Targets.common.name),
                    .project(target: Targets.testKit.name,
                             path: Projects.testKit.relativeManifestPath)]
        case .core:
            return [.project(target: Targets.common.name,
                             path: Projects.common.relativeManifestPath)]
        case .coreTests:
            return [.target(name: Targets.core.name),
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
                    .package(product: "EntwineTest"),
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
