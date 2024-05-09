import Models
import StaticModels

private extension Part.Static {
    init(id: String) {
        self.init(id: id, category: .special, form: .solid, isNaturalResource: true)
    }
}

extension V2.Parts {
    static let baconAgaric = Part.Static(id: "part-bacon-agaric")
    static let berylNut = Part.Static(id: "part-beryl-nut")
    static let paleberry = Part.Static(id: "part-paleberry")
    static let somersloop = Part.Static(id: "part-somersloop")
    static let mercerSphere = Part.Static(id: "part-mercer-sphere")
    static let coupon = Part.Static(id: "part-ficsit-coupon")
    static let hardDrive = Part.Static(id: "part-hard-drive")
    static let HUBParts = Part.Static(id: "part-hub-parts")
    
    static let specialParts = [
        baconAgaric,
        berylNut,
        paleberry,
        somersloop,
        mercerSphere,
        coupon,
        hardDrive,
        HUBParts
    ]
}
