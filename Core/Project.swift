import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.framework(name: "Core", dependencies: [
    .project(target: "Common", path: .relativeToManifest("../Common"))
])
