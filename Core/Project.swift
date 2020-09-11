import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.framework(name: "Core", platform: .iOS, dependencies: [
    .project(target: "Common", path: .relativeToManifest("../Common"))
])
