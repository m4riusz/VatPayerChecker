import ProjectDescription

final class TargetBuilder {
    private var name = ""
    private var baseBundleId = ""
    private var platform: Platform = .iOS
    private var product: Product = .app
    private var dependencies: [TargetDependency] = []
    private var settings: Settings?
    private var actions: [TargetAction] = []
    
    func setName(_ name: String) -> TargetBuilder {
        self.name = name
        return self
    }
    
    func setBaseBundleId(_ bundleId: String) -> TargetBuilder {
        self.baseBundleId = bundleId
        return self
    }
    
    func setPlatform(_ platform: Platform) -> TargetBuilder {
        self.platform = platform
        return self
    }
    
    func setProduct(_ product: Product) -> TargetBuilder {
        self.product = product
        return self
    }
    
    func setDependencies(_ dependencies: [TargetDependency]) -> TargetBuilder {
        self.dependencies = dependencies
        return self
    }
    
    func setSettings(_ settings: Settings?) -> TargetBuilder {
        self.settings = settings
        return self
    }
    
    func setActions(_ actions: [TargetAction]) -> TargetBuilder {
        self.actions = actions
        return self
    }
    
    var fixedName: String {
        switch product {
        case .app, .framework:
            return name
        case .unitTests:
            return "\(name)Tests"
        case .uiTests:
            return "\(name)UITests"
        default:
            fatalError("Unknown name")
        }
    }
    
    var bundleId: String {
        "\(baseBundleId).\(fixedName)"
    }
    
    var sources: SourceFilesList {
        switch product {
        case .app, .framework:
            return ["Sources/**"]
        case .unitTests:
            return ["Tests/**"]
        case .uiTests:
            return ["UITests/**"]
        default:
            fatalError("Unknown target source")
        }
    }
    
    var resources: [FileElement]? {
        switch product {
        case .app, .framework:
            return ["Resources/**"]
        case .unitTests, .uiTests:
            return nil
        default:
            fatalError("Unknown target resource")
        }
    }
    
    var infoPlistName: String {
        "\(fixedName).plist"
    }
    
    func build() -> Target {
        Target(name: fixedName,
               platform: platform,
               product: product,
               bundleId: bundleId,
               infoPlist: .file(path: .relativeToManifest(infoPlistName)),
               sources: sources,
               resources: resources,
               actions: actions,
               dependencies: dependencies,
               settings: settings)
    }
}
