
import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var appSettings: AppSettings

    var body: some View {
        ZStack {
            ForestBackground()
                .ignoresSafeArea(.all)
            List {
                Section {
                    Toggle(isOn: $appSettings.isMetric) {
                        Text(LocalizedString("Use Metric Units"))
                    }
                }
                .listRowBackground(Color.clear)
                .padding(.vertical, 10)
                .padding(.horizontal, 16)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(BikeThemeColors.surfaceVariant)
                        .shadow(color: Color.black.opacity(0.15), radius: 8, x: 0, y: 4)
                )
            }
            .scrollContentBackground(.hidden)
            .navigationTitle(LocalizedString("Settings"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(BikeThemeColors.primary, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .onDisappear {
                appSettings.save()
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsView()
                .environmentObject(AppSettings())
        }
    }
}
