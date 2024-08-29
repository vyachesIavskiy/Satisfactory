import SwiftUI

public extension Color {
    enum sh {
        public static let primary = Color("Primary", bundle: .module)
        public static let secondary = Color("Secondary", bundle: .module)
        
        public static let recipeOutput = Color("Recipe Output", bundle: .module)
        public static let fluid = Color("Fluid", bundle: .module)
        
        public static let byproduct1  = Color("Byproduct - 1",  bundle: .module)
        public static let byproduct2  = Color("Byproduct - 2",  bundle: .module)
        public static let byproduct3  = Color("Byproduct - 3",  bundle: .module)
        public static let byproduct4  = Color("Byproduct - 4",  bundle: .module)
        public static let byproduct5  = Color("Byproduct - 5",  bundle: .module)
        public static let byproduct6  = Color("Byproduct - 6",  bundle: .module)
        public static let byproduct7  = Color("Byproduct - 7",  bundle: .module)
        public static let byproduct8  = Color("Byproduct - 8",  bundle: .module)
        public static let byproduct9  = Color("Byproduct - 9",  bundle: .module)
        public static let byproduct10 = Color("Byproduct - 10", bundle: .module)
    }
}

#if DEBUG
import SHDebug

private struct ColorPreview: View {
    let name: String
    let hex: String
    let darkHex: String
    let color: Color
    
    var body: some View {
        HStack(alignment: .top, spacing: 30) {
            ZStack {
                Rectangle()
                    .trim(from: 0, to: 0.5)
                    .foregroundStyle(color)
                    .rotationEffect(.degrees(-90))

                Rectangle()
                    .trim(from: 0, to: 0.5)
                    .foregroundStyle(color)
                    .rotationEffect(.degrees(90))
                    .environment(\.colorScheme, .dark)
                
                Rectangle()
                    .foregroundStyle(color)
                    .frame(height: 2)
                    .rotationEffect(.degrees(-45))
            }
            .frame(maxWidth: 120, maxHeight: 120)
            .aspectRatio(1, contentMode: .fit)
            .clipShape(Circle())
            .overlay(color, in: Circle().stroke(lineWidth: 2))
            
            VStack(alignment: .leading) {
                Text(name)
                    .font(.title2)
                
                Divider()
                
                HStack {
                    VStack(alignment: .leading) {
                        Text(verbatim: "Light: ")
                        Text(verbatim: "Dark: ")
                    }
                    
                    VStack(alignment: .leading) {
                        Text(hex.uppercased())
                        Text(darkHex.uppercased())
                    }
                    .font(.body.monospaced())
                    .bold()
                }
            }
            .padding(.top, 8)
        }
        .padding()
        .background(
            .background.shadow(.drop(color: color.opacity(0.2), radius: 12, y: 4)),
            in: RoundedRectangle(cornerRadius: 20)
        )
        .padding(.horizontal)
    }
}

#Preview("General colors") {
    VStack(spacing: 50) {
        ColorPreview(
            name: "Primary",
            hex: "#E59243",
            darkHex: "#DA9D62",
            color: .sh.primary
        )
        
        ColorPreview(
            name: "Secondary",
            hex: "#1D2243",
            darkHex: "#BBC0E6",
            color: .sh.secondary
        )
    }
    .previewBackground()
}

#Preview("Recipe colors") {
    VStack(spacing: 50) {
        ColorPreview(
            name: "Recipe Output",
            hex: "#8C8C8C",
            darkHex: "#8C8C8C",
            color: .sh.recipeOutput
        )
        
        ColorPreview(
            name: "Fluid",
            hex: "#5BA6C5",
            darkHex: "#5BA6C5",
            color: .sh.fluid
        )
    }
    .previewBackground()
}

#Preview("Byproduct colors") {
    ScrollView {
        VStack(spacing: 50) {
            ColorPreview(
                name: "Byproduct - 1",
                hex: "#C74646",
                darkHex: "#C74646",
                color: .sh.byproduct1
            )
            
            ColorPreview(
                name: "Byproduct - 2",
                hex: "#DDCD29",
                darkHex: "#DDCD29",
                color: .sh.byproduct2
            )
            
            ColorPreview(
                name: "Byproduct - 3",
                hex: "#BAD70A",
                darkHex: "#BAD70A",
                color: .sh.byproduct3
            )
            
            ColorPreview(
                name: "Byproduct - 4",
                hex: "#46AC0E",
                darkHex: "#46AC0E",
                color: .sh.byproduct4
            )
            
            ColorPreview(
                name: "Byproduct - 5",
                hex: "#307BBA",
                darkHex: "#307BBA",
                color: .sh.byproduct5
            )
            
            ColorPreview(
                name: "Byproduct - 6",
                hex: "#6457C5",
                darkHex: "#6457C5",
                color: .sh.byproduct6
            )
            
            ColorPreview(
                name: "Byproduct - 7",
                hex: "#B060BA",
                darkHex: "#B060BA",
                color: .sh.byproduct7
            )
            
            ColorPreview(
                name: "Byproduct - 8",
                hex: "#A4722F",
                darkHex: "#A4722F",
                color: .sh.byproduct8
            )
            
            ColorPreview(
                name: "Byproduct - 9",
                hex: "#78B1B1",
                darkHex: "#78B1B1",
                color: .sh.byproduct9
            )
            
            ColorPreview(
                name: "Byproduct - 10",
                hex: "#FF76AD",
                darkHex: "#FF76AD",
                color: .sh.byproduct10
            )
        }
    }
    .previewBackground()
}
#endif
