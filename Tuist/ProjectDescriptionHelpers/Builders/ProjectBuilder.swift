import ProjectDescription

public final class ProjectBuilder {
    private var name = ""
    private var organizationName = ""
    private var packages: [Package] = []
    private var settings: Settings? = nil
    private var targets: [Target] = []
    private var schemes: [Scheme] = []
    private var additionalFiles: [FileElement] = []
    
    public init() { /* Nop */ }
    
    public func setName(_ name: String) -> ProjectBuilder {
        self.name = name
        return self
    }
    
    public func setOrganizationName(_ organizationName: String) -> ProjectBuilder {
        self.organizationName = organizationName
        return self
    }
    
    public func setPackages(_ packages: [Package]) -> ProjectBuilder {
        self.packages = packages
        return self
    }
    
    public func setSettings(_ settings: Settings?) -> ProjectBuilder {
        self.settings = settings
        return self
    }
    
    public func setTargets(_ targets: [Target]) -> ProjectBuilder {
        self.targets = targets
        return self
    }
    
    public func setSchemes(_ schemes: [Scheme]) -> ProjectBuilder {
        self.schemes = schemes
        return self
    }
    
    public func setAdditionalFiles(_ additionalFiles: [FileElement]) -> ProjectBuilder {
        self.additionalFiles = additionalFiles
        return self
    }
    
    public func build() -> Project {
        Project(name: name,
                organizationName: organizationName,
                packages: packages,
                settings: settings,
                targets: targets,
                schemes: schemes,
                additionalFiles: additionalFiles)
    }
}
