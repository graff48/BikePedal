
import SwiftUI

struct ContentView: View {
    @StateObject private var rideService = RideService()
    @EnvironmentObject var appSettings: AppSettings

    var body: some View {
        NavigationStack {
            ZStack {
                ForestBackground()
                    .ignoresSafeArea(.all)
                VStack(spacing: 16) {
                    Spacer()
                    
                    // Statistics Card
                    VStack(spacing: 16)
                    {
                        
                        VStack(spacing: 8) {
                            Text("\(String(format: "%.2f", rideService.distance / (appSettings.distanceUnit == .kilometers ? 1000 : 1609.34)))")
                                .font(.system(size: 36, weight: .black))
                                .foregroundColor(BikeThemeColors.primary)
                            Text(LocalizedString(appSettings.distanceUnit.rawValue.uppercased()))
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(BikeThemeColors.onSurface.opacity(0.8))
                                .tracking(1)
                        }
                        
                        HStack(spacing: 40) {
                            VStack(spacing: 4) {
                                Text("\(Int(rideService.currentDuration / 60)):\(String(format: "%02d", Int(rideService.currentDuration.truncatingRemainder(dividingBy: 60))))")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(BikeThemeColors.secondary)
                                Text(LocalizedString("TIME"))
                                    .font(.system(size: 10, weight: .bold))
                                    .foregroundColor(BikeThemeColors.onSurface.opacity(0.8))
                                    .tracking(1)
                            }
                            
                            VStack(spacing: 4) {
                                Text("\(String(format: "%.1f", rideService.speed * (appSettings.distanceUnit == .kilometers ? 3.6 : 2.23694)))")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(BikeThemeColors.accent)
                                Text(LocalizedString(appSettings.distanceUnit.speedUnit.uppercased()))
                                    .font(.system(size: 10, weight: .bold))
                                    .foregroundColor(BikeThemeColors.onSurface.opacity(0.8))
                                    .tracking(1)
                            }
                        }
                        
                        VStack(spacing: 4) {
                            Text("\(String(format: "%.1f", rideService.topSpeed * (appSettings.distanceUnit == .kilometers ? 3.6 : 2.23694)))")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(BikeThemeColors.accent)
                            Text(LocalizedString("TOP SPEED"))
                                .font(.system(size: 10, weight: .bold))
                                .foregroundColor(BikeThemeColors.onSurface.opacity(0.8))
                                .tracking(1)
                        }
                    }.ignoresSafeArea(.all)
                        .bikeCard()
                    
                    Spacer()
                    
                    VStack(spacing: 20) {
                        HStack(spacing: 16) {
                            Button(action: {
                                rideService.isPaused ? rideService.start() : rideService.pause()
                            }) {
                                Text(rideService.isPaused ? LocalizedString("START") : LocalizedString("PAUSE"))
                                    .bikeButton(
                                        backgroundColor: rideService.isPaused ? BikeThemeColors.secondary : BikeThemeColors.primary,
                                        textColor: BikeThemeColors.onPrimary
                                    )
                            }
                            
                            Button(action: {
                                rideService.reset()
                            }) {
                                Text(LocalizedString("RESET"))
                                    .bikeButton(
                                        backgroundColor: BikeThemeColors.error,
                                        textColor: BikeThemeColors.onPrimary
                                    )
                            }
                        }
                        
                        Button(action: {
                            rideService.saveCurrentRide()
                        }) {
                            Text(LocalizedString("SAVE RIDE"))
                                .bikeButton(
                                    backgroundColor: BikeThemeColors.accent,
                                    textColor: BikeThemeColors.onPrimary
                                )
                        }
                        
                        NavigationLink(destination: SavedRidesView(rideService: rideService)) {
                            Text(LocalizedString("VIEW SAVED RIDES"))
                                .bikeButton(
                                    backgroundColor: BikeThemeColors.surfaceVariant,
                                    textColor: BikeThemeColors.primary,
                                    elevated: false
                                )
                        }
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 16)
                .ignoresSafeArea(.all)
                
                .navigationTitle(LocalizedString("Bike Tracker"))
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(BikeThemeColors.primary, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbarColorScheme(.dark, for: .navigationBar)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: SettingsView()) {
                            Image(systemName: "gearshape.fill")
                                .font(.system(size: 15))
                        }
                    }
                }
            }
        }
    }

}

#Preview {
    ContentView()
        .environmentObject(AppSettings())
}
