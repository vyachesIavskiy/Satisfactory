//
//  CloseButtonView.swift
//  CloseButtonView
//
//  Created by Slava Nagornyak on 17.07.2021.
//

import SwiftUI

struct CloseButtonView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
            HStack {
                Spacer()

                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .renderingMode(.template)
                        .font(.title2)
                        .padding(5)
                        .background(Material.regularMaterial)
                        .clipShape(Circle())
                }
                Spacer()
                    .frame(width: 30)
            }
    }
}

struct CloseButtonPreview: PreviewProvider {
    static var previews: some View {
        CloseButtonView()
    }
}
