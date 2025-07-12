
import SwiftUI

struct SavedRidesView: View {
    @ObservedObject var rideService: RideService
    @EnvironmentObject var appSettings: AppSettings
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            ForestBackground()
                .ignoresSafeArea(.all)
            
            if rideService.savedRides.isEmpty {
                VStack(spacing: 20) {
                    Image(systemName: "bicycle")
                        .font(.system(size: 80, weight: .bold))
                        .foregroundColor(BikeThemeColors.secondary)
                    
                    Text(LocalizedString("No rides saved yet"))
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(Color.black)
                    
                    Text(LocalizedString("Start tracking your adventures!"))
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(Color.black.opacity(0.8))
                }
                .bikeCard()
                .padding()
            } else {
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(rideService.savedRides.sorted(by: { $0.date > $1.date })) { ride in
                            VStack(alignment: .leading, spacing: 12) {
                                HStack {
                                    Image(systemName: "calendar")
                                        .foregroundColor(BikeThemeColors.primary)
                                        .font(.system(size: 16, weight: .semibold))
                                    Text("\(ride.date, formatter: itemFormatter)")
                                        .font(.system(size: 18, weight: .bold))
                                        .foregroundColor(Color.black)
                                    Spacer()
                                }
                                
                                HStack(spacing: 24) {
                                    VStack(alignment: .leading, spacing: 4) {
                                        HStack {
                                            Image(systemName: "location")
                                                .foregroundColor(BikeThemeColors.secondary)
                                            Text("\(String(format: "%.2f", ride.distance / (appSettings.distanceUnit == .kilometers ? 1000 : 1609.34))) \(LocalizedString(appSettings.distanceUnit == .kilometers ? "km" : "mi"))")
                                                .font(.system(size: 16, weight: .semibold))
                                                .foregroundColor(Color.black)
                                        }
                                        
                                        HStack {
                                            Image(systemName: "clock")
                                                .foregroundColor(BikeThemeColors.accent)
                                            Text("\(Int(ride.duration / 60)):\(String(format: "%02d", Int(ride.duration.truncatingRemainder(dividingBy: 60))))")
                                                .font(.system(size: 16, weight: .semibold))
                                                .foregroundColor(Color.black)
                                        }
                                    }
                                    
                                    Spacer()
                                    
                                    VStack(alignment: .trailing, spacing: 4) {
                                        HStack {
                                            Text("\(String(format: "%.1f", ride.averageSpeed * (appSettings.distanceUnit == .kilometers ? 3.6 : 2.23694)))")
                                                .font(.system(size: 20, weight: .bold))
                                                .foregroundColor(BikeThemeColors.primary)
                                            Text(LocalizedString(appSettings.distanceUnit.speedUnit))
                                                .font(.system(size: 12, weight: .medium))
                                                .foregroundColor(Color.black.opacity(0.8))
                                        }
                                        Text(LocalizedString("avg speed"))
                                            .font(.system(size: 10, weight: .medium))
                                            .foregroundColor(BikeThemeColors.onSurface.opacity(0.7))
                                    }

                                    VStack(alignment: .trailing, spacing: 4) {
                                        HStack {
                                            Text("\(String(format: "%.1f", ride.topSpeed * (appSettings.distanceUnit == .kilometers ? 3.6 : 2.23694)))")
                                                .font(.system(size: 20, weight: .bold))
                                                .foregroundColor(BikeThemeColors.primary)
                                            Text(LocalizedString(appSettings.distanceUnit.speedUnit))
                                                .font(.system(size: 12, weight: .medium))
                                                .foregroundColor(Color.black.opacity(0.8))
                                        }
                                        Text(LocalizedString("top speed"))
                                            .font(.system(size: 10, weight: .medium))
                                            .foregroundColor(BikeThemeColors.onSurface.opacity(0.7))
                                    }
                                }
                            }
                            .bikeCard()
                        }
                        .onDelete(perform: rideService.deleteRide)
                    }
                    .padding()
                }
            }
        }
        .navigationTitle(LocalizedString("Saved Rides"))
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(BikeThemeColors.primary, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    HStack(spacing: 6) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 16, weight: .semibold))
                        Text(LocalizedString("Back Button"))
                            .font(.system(size: 17))
                    }
                    .foregroundColor(.white)
                }
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    return formatter
}()

struct SavedRidesView_Previews: PreviewProvider {
    static var previews: some View {
        SavedRidesView(rideService: RideService())
            .environmentObject(AppSettings())
    }
}
