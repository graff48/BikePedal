
import Foundation

class AppSettings: ObservableObject {
    @Published var isMetric: Bool = false

    var distanceUnit: DistanceUnit {
        isMetric ? .kilometers : .miles
    }

    init() {
        // Load the saved setting, if any
        self.isMetric = UserDefaults.standard.bool(forKey: "isMetric")
    }

    func save() {
        UserDefaults.standard.set(isMetric, forKey: "isMetric")
    }
}

enum DistanceUnit: String, CaseIterable, Identifiable {
    case kilometers
    case miles

    var id: String { self.rawValue }

    var speedUnit: String {
        switch self {
        case .kilometers:
            return "kph"
        case .miles:
            return "mph"
        }
    }
}
