import SHModels
import SHStaticModels

private extension Part.Static {
    init(id: String) {
        self.init(id: id, category: .matters, form: .gas)
    }
}

extension V2.Parts {
    static let excitedPhotonicMatter = Part.Static(id: "part-excited-photonic-matter")
    static let darkMatterResidue = Part.Static(id: "part-dark-matter-residue")
    
    static let matterParts = [
        excitedPhotonicMatter,
        darkMatterResidue,
    ]
}
