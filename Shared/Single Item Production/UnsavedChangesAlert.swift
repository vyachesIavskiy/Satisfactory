import SwiftUI

struct UnsavedChangesAlert: View {
    var onCancel: () -> Void
    var onSaveAndExit: () -> Void
    var onExit: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            LinearGradient(colors: [.black.opacity(0.1), .black.opacity(0.35)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea(edges: .top)
                .onTapGesture(perform: onCancel)
                .zIndex(1)
            
            VStack(spacing: 4) {
                VStack(spacing: 8) {
                    Text("You have unsaved changes")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("If you close production now, all unsaved changes will be lost. Would you like to save those changes?")
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                }
                
                VStack(spacing: 16) {
                    HStack(spacing: 24) {
                        Button(action: onExit) {
                            Text("Don't save")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.shBordered)
                        .tint(.sh(.red))
                        
                        Button(action: onSaveAndExit) {
                            Text("Save and exit")
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.shBordered)
                    }
                    
                    Button(action: onCancel) {
                        Text("Cancel")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.shBordered)
                    .tint(.sh(.gray80))
                }
                .padding(.top, 24)
            }
            .fixedSize(horizontal: false, vertical: true)
            .padding(24)
            .background(.background, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
            .drawingGroup()
            .padding(.horizontal, 16)
            .background(.black.opacity(0.35))
            .zIndex(2)
            
            LinearGradient(colors: [.black.opacity(0.35), .black.opacity(0.1)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea(edges: .bottom)
                .onTapGesture(perform: onCancel)
                .zIndex(1)
        }
        .transition(.opacity.animation(.default.speed(2)))
        .zIndex(2)
    }
}

#if DEBUG
#Preview {
    UnsavedChangesAlert(onCancel: {}, onSaveAndExit: {}, onExit: {})
}
#endif
