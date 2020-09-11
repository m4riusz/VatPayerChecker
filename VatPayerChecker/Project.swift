import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.app(name: "VatPayerChecker", platform: .iOS, dependencies: [
    .project(target: "Core", path: .relativeToManifest("../Core")),
    .project(target: "Common", path: .relativeToManifest("../Common"))
])
