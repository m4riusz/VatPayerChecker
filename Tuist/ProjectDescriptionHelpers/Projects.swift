import ProjectDescription

public enum Projects {
    public static let organizationName = "MSut"
    public static let bundleId = "pl.msut"
    
    case testKit
    case common
    case core
    case vatPayerChecker
    
    var name: String {
        switch self {
        case .testKit:
            return "TestKit"
        case .common:
            return "Common"
        case .core:
            return "Core"
        case .vatPayerChecker:
            return "VatPayerChecker"
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
        case .vatPayerChecker:
            return [.vatPayerChecker, .vatPayerCheckerTests, .vatPayerCheckerUITests]
        }
    }
    
    var schemes: [Scheme] {
        []
    }
    
    var settings: Settings? {
        nil
    }
    
    var packages: [Package] {
        []
    }
    
    var additionalFiles: [FileElement] {
        []
    }
    
    var relativeManifestPath: Path {
        .relativeToManifest("../\(name)")
    }
}

extension Projects: CaseIterable {}
