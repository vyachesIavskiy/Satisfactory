import Foundation

public extension FormatStyle where Self == FloatingPointFormatStyle<Double> {
    static var shNumber: FloatingPointFormatStyle<Double> { .number.precision(.fractionLength(0...4)) }
}

public extension FormatStyle where Self == FloatingPointFormatStyle<Double>.Percent {
    static var shPercent: FloatingPointFormatStyle<Double>.Percent { .percent.precision(.fractionLength(0...2)) }
}
