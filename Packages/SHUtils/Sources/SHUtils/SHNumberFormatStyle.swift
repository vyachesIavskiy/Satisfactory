import Foundation

public extension FormatStyle where Self == FloatingPointFormatStyle<Double> {
    static func shNumber(fractionLength: UInt = 4) -> FloatingPointFormatStyle<Double> {
        .number.precision(.fractionLength(0...Int(fractionLength)))
    }
}

public extension FormatStyle where Self == FloatingPointFormatStyle<Double>.Percent {
    static var shPercent: FloatingPointFormatStyle<Double>.Percent { .percent.precision(.fractionLength(0...2)) }
}
