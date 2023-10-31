import StaticModels

private extension Part {
    init(id: String) {
        self.init(id: id, category: .special, form: .solid, isNaturalResource: true)
    }
}

extension V2.Parts {
    static let baconAgaric = Part(id: "part-bacon-agaric")
    static let berylNut = Part(id: "part-beryl-nut")
    static let paleberry = Part(id: "part-paleberry")
    static let somersloop = Part(id: "part-somersloop")
    static let mercerSphere = Part(id: "part-mercer-sphere")
    static let coupon = Part(id: "part-ficsit-coupon")
    static let hardDrive = Part(id: "part-hard-drive")
    static let HUBParts = Part(id: "part-hub-parts")
    
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
