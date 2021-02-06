import ProjectDescription

public enum Projects {
    public static let organizationName = "MSut"
    public static let bundleId = "pl.msut"
    
    case testKit
    case common
    case core
    case mobileApp
    
    var name: String {
        switch self {
        case .testKit:
            return "TestKit"
        case .common:
            return "Common"
        case .core:
            return "Core"
        case .mobileApp:
            return "MobileApp"
        }
    }
    
    public var path: Path {
        .relativeToRoot(name)
    }
    
    var targets: [Targets] {
        switch self {
        case .testKit:
            return [.testKit]
        case .common:
            return [.common, .commonTests]
        case .core:
            return [.core, .coreTests]
        case .mobileApp:
            return [.mobileApp, .mobileAppTests, .mobileAppUITests]
        }
    }
    
    var schemes: [Scheme] {
        switch self {
        case .mobileApp:
            return [
                MobileAppScheme.dev.scheme,
                MobileAppScheme.staging.scheme,
                MobileAppScheme.production.scheme,
                MobileAppScheme.uiTests.scheme
            ]
        default:
            return []
        }
    }
    
    var settings: Settings? {
        nil
    }
    
    var packages: [Package] {
        [.package(url: "https://github.com/tcldr/Entwine.git", from: Version(0, 9, 1)),
         .package(url: "https://github.com/Swinject/Swinject.git", from: Version(2, 7, 1)),
         .package(url: "https://github.com/pointfreeco/swift-snapshot-testing.git", from: Version(1, 8, 1)),
         .package(url: "https://github.com/piknotech/SFSafeSymbols.git", from: Version(2, 1, 0))]
    }
    
    var additionalFiles: [FileElement] {
        []
    }
    
    var relativeManifestPath: Path {
        .relativeToManifest("../\(name)")
    }
}

extension Projects: CaseIterable {}
