import ProjectDescription

extension Project {
    public static func project(_ project: Projects) -> Project {
        Project(name: project.name,
                organizationName: Projects.organizationName,
                targets: project.targets.map { $0.target })
    }
}
