import SwiftUI

@Observable
final class TestNumberProvider {
    struct Number {
        var number: Int
        
        var isMultipleOfTwo: Bool {
            number.isMultiple(of: 2)
        }
    }
    
    func streamNumbers() -> AsyncStream<Number> {
        ContinuousClock().timer(interval: .seconds(1)).map { _ in
            Number(number: Int.random(in: 1...10_000))
        }.eraseToStream()
    }
}

@Observable
final class TestRootViewModel {
    let numberProvider = TestNumberProvider()
    let tab1 = TestTab1ViewModel(number: 1)
    let tab2 = TestTab2ViewModel(isMultipleOfTwo: true)
    
    @MainActor
    func observeNumbers() async {
        for await number in numberProvider.streamNumbers() {
            tab1.number = number.number
            if tab2.isMultipleOfTwo != number.isMultipleOfTwo {
                tab2.isMultipleOfTwo = number.isMultipleOfTwo
            }
        }
    }
}

@Observable
final class TestTab1ViewModel {
    var number: Int
    
    init(number: Int) {
        self.number = number
    }
}

@Observable
final class TestTab2ViewModel {
    var isMultipleOfTwo: Bool
    
    init(isMultipleOfTwo: Bool) {
        self.isMultipleOfTwo = isMultipleOfTwo
    }
}

private struct TestRootView: View {
    let viewModel = TestRootViewModel()
    
    var body: some View {
        TabView {
            TestTab1View(viewModel: viewModel.tab1)
                .tabItem {
                    Label("Tab 1", systemImage: "square")
                }
            
            TestTab2View(viewModel: viewModel.tab2)
                .tabItem {
                    Label("Tab 2", systemImage: "triangle")
                }
        }
        .task {
            await viewModel.observeNumbers()
        }
    }
}

private struct TestTab1View: View {
    var viewModel: TestTab1ViewModel
    
    var body: some View {
        Text(viewModel.number, format: .number)
    }
}

private struct TestTab2View: View {
    var viewModel: TestTab2ViewModel
    
    var body: some View {
        let _ = Self._printChanges()
        Text(viewModel.isMultipleOfTwo ? "Is" : "Is not") + Text(" multiple of 2")
    }
}

#Preview("Test") {
    TestRootView()
}
