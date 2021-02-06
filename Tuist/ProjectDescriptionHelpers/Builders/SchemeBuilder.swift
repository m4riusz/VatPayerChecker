import ProjectDescription

final class SchemeBuilder {
    private var name = ""
    private var shared = true
    private var buildAction: BuildAction?
    private var testAction: TestAction?
    private var runAction: RunAction?
    private var archiveAction: ArchiveAction?
    private var profileAction: ProfileAction?
    private var analyzeAction: AnalyzeAction?
    
    public init() { /* Nop */ }
    
    public func setName(name: String) -> SchemeBuilder {
        self.name = name
        return self
    }
    
    public func setShared(shared: Bool) -> SchemeBuilder {
        self.shared = shared
        return self
    }
    
    public func setBuildAction(buildAction: BuildAction?) -> SchemeBuilder {
        self.buildAction = buildAction
        return self
    }
    
    public func setTestAction(testAction: TestAction?) -> SchemeBuilder {
        self.testAction = testAction
        return self
    }
    
    public func setRunAction(runAction: RunAction?) -> SchemeBuilder {
        self.runAction = runAction
        return self
    }
    
    public func setArchiveAction(archiveAction: ArchiveAction?) -> SchemeBuilder {
        self.archiveAction = archiveAction
        return self
    }
    
    public func setProfileAction(profileAction: ProfileAction?) -> SchemeBuilder {
        self.profileAction = profileAction
        return self
    }
    
    public func setAnalyzeAction(analyzeAction: AnalyzeAction?) -> SchemeBuilder {
        self.analyzeAction = analyzeAction
        return self
    }
    
    func build() -> Scheme {
        Scheme(name: name,
               shared: shared,
               buildAction: buildAction,
               testAction: testAction,
               runAction: runAction,
               archiveAction: archiveAction,
               profileAction: profileAction,
               analyzeAction: analyzeAction)
    }
}
