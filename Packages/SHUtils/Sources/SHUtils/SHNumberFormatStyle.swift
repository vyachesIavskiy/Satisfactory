import Foundation

public extension FormatStyle where Self == FloatingPointFormatStyle<Float64> {
    static var shNumber: FloatingPointFormatStyle<Float64> { .number.precision(.fractionLength(0...4)) }
}
