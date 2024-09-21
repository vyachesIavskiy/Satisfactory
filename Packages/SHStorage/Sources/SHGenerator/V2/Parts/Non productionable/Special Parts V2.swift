import SHModels
import SHStaticModels

private extension Part.Static {
    init(id: String) {
        self.init(id: id, category: .special, form: .solid, isNaturalResource: true)
    }
}

extension V2.Parts {
    static let hardDrive = Part.Static(id: "part-hard-drive")
    static let coupon = Part.Static(id: "part-ficsit-coupon")
//    static let mercerSphere = Part.Static(id: "part-mercer-sphere")
//    static let somersloop = Part.Static(id: "part-somersloop")
    
    static let specialParts = [
        hardDrive,
        coupon,
//        mercerSphere,
//        somersloop,
    ]
}
