import ProjectDescription

extension Project {
    public static func project(_ project: Projects) -> Project {
        ProjectBuilder()
            .setName(project.name)
            .setOrganizationName(Projects.organizationName)
            .setTargets(project.targets.map { $0.target })
            .setSchemes(project.schemes)
            .setSettings(project.settings)
            .setPackages(project.packages)
            .setAdditionalFiles(project.additionalFiles)
            .build()
    }
}
