import Foundation

class SatisfactoryNumberFormatter: NumberFormatter {
    override init() {
        super.init()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func string(from double: Double) -> String? {
        super.string(from: NSNumber(value: double))
    }
}

final class ItemAmountNumberFormatter: SatisfactoryNumberFormatter {
    override init() {
        super.init()
        
        maximumFractionDigits = 4
    }
}

extension Double {
    func string(with formatter: SatisfactoryNumberFormatter) -> String? {
        formatter.string(from: self)
    }
}
