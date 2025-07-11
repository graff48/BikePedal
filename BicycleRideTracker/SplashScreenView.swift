
import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5

    var body: some View {
        if isActive {
            ContentView()
        } else {
            ZStack {
                ForestBackground()
                    .ignoresSafeArea(.all)
                
                VStack(spacing: 30) {
                    VStack(spacing: 20) {
                        Image(systemName: "bicycle")
                            .font(.system(size: 100, weight: .bold))
                            .foregroundColor(BikeThemeColors.secondary)
                            .shadow(color: Color.black.opacity(0.3), radius: 4, x: 0, y: 2)
                        
                        Text("🚴 Bike Pedal")
                            .font(.system(size: 32, weight: .black))
                            .foregroundColor(BikeThemeColors.primary)
                            .shadow(color: Color.black.opacity(0.5), radius: 2, x: 0, y: 1)
                            .multilineTextAlignment(.center)
                        
                        Text("Track Your Rides")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(BikeThemeColors.primary.opacity(0.9))
                            .shadow(color: Color.black.opacity(0.3), radius: 1, x: 0, y: 1)
                    }
                    .padding(30)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(BikeThemeColors.surface)
                            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                    )
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 0.9
                        self.opacity = 1.0
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation(.easeOut(duration: 0.5)) {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
