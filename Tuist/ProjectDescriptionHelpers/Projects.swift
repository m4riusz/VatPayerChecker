import ProjectDescription

public enum Projects {
    public static let organizationName = "MSut"
    public static let bundleId = "pl.msut"
    
    case common
    case core
    case vatPayerChecker
    
    var name: String {
        switch self {
        case .common:
            return "Common"
        case .core:
            return "Core"
        case .vatPayerChecker:
            return "VatPayerChecker"
        }
    }
    
    public var path: ProjectDescription.Path {
        .relativeToRoot(name)
    }
    
    var targets: [Targets] {
        switch self {
        case .common:
            return [.common, .commonTests]
        case .core:
            return [.core, .coreTests]
        case .vatPayerChecker:
            return [.vatPayerChecker, .vatPayerCheckerTests, .vatPayerCheckerUITests]
        }
    }
    
    var relativeManifestPath: Path {
        .relativeToManifest("../\(name)")
    }
}

extension Projects: CaseIterable {}
