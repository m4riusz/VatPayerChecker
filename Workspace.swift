import ProjectDescription
import ProjectDescriptionHelpers

let workspace = Workspace(name: "VatPayerChecker",
                          projects: Projects.allCases.map { $0.path })
