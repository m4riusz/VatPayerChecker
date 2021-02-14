import ProjectDescription

final class TargetBuilder {
    private var name = ""
    private var bundleId = ""
    private var platform: Platform = .iOS
    private var product: Product = .app
    private var dependencies: [TargetDependency] = []
    private var settings: Settings?
    private var actions: [TargetAction] = []
    
    func setName(_ name: String) -> TargetBuilder {
        self.name = name
        return self
    }
    
    func setBundleId(_ bundleId: String) -> TargetBuilder {
        self.bundleId = bundleId
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
        case .unitTests:
            return ["Tests/Resources/**"]
        case  .uiTests:
            return nil
        default:
            fatalError("Unknown target resource")
        }
    }
    
    var infoPlistName: String {
        "\(name).plist"
    }
    
    func build() -> Target {
        Target(name: name,
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
