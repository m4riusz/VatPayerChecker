import ProjectDescription
import ProjectDescriptionHelpers

enum Projects {
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
}
