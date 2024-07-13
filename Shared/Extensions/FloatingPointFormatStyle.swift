import Foundation

extension FormatStyle where Self == FloatingPointFormatStyle<Float64> {
    static var fractionFromZeroToFour: FloatingPointFormatStyle<Float64> { .number.precision(.fractionLength(0...4)) }
}
