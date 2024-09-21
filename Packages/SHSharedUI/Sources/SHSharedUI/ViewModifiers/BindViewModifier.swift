import SwiftUI

extension View {
    public func bind<Bindable: Equatable>(_ lhs: Binding<Bindable>, _ rhs: Binding<Bindable>) -> some View {
        onChange(of: lhs.wrappedValue) { oldValue, newValue in
            guard oldValue != newValue else { return }
            
            rhs.wrappedValue = newValue
        }
        .onChange(of: rhs.wrappedValue) { oldValue, newValue in
            guard oldValue != newValue else { return }
            
            lhs.wrappedValue = newValue
        }
    }
}
