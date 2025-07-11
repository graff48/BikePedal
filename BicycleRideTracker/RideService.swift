
import Foundation
import CoreLocation

class RideService: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var distance: Double = 0.0
    @Published var speed: Double = 0.0
    @Published var topSpeed: Double = 0.0
    @Published var isPaused: Bool = true
    @Published var savedRides: [Ride] = []
    @Published var currentDuration: TimeInterval = 0.0

    private let locationManager = CLLocationManager()
    private var locations: [CLLocation] = []
    private var startTime: Date?
    private var timer: Timer?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        loadRide()
        loadSavedRides()
    }

    func start() {
        isPaused = false
        if startTime == nil {
            startTime = Date()
        }
        locationManager.startUpdatingLocation()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self, let startTime = self.startTime else { return }
            self.currentDuration = Date().timeIntervalSince(startTime)
        }
    }

    func pause() {
        isPaused = true
        locationManager.stopUpdatingLocation()
        timer?.invalidate()
        saveRide()
    }

    func reset() {
        distance = 0.0
        speed = 0.0
        topSpeed = 0.0
        locations.removeAll()
        startTime = nil
        currentDuration = 0.0
        timer?.invalidate()
        timer = nil
        saveRide()
    }

    func saveCurrentRide() {
        guard let startTime = startTime else { return }
        let duration = Date().timeIntervalSince(startTime)
        let newRide = Ride(id: UUID(), distance: distance, duration: duration, date: Date(), topSpeed: topSpeed)
        savedRides.append(newRide)
        saveSavedRides()
        reset() // Reset the current ride after saving
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }

        if !isPaused {
            if let lastLocation = self.locations.last {
                distance += location.distance(from: lastLocation)
            }

            self.locations.append(location)
            speed = location.speed
            if speed > topSpeed {
                topSpeed = speed
            }
        }
    }

    private func saveRide() {
        let locationsData = try? NSKeyedArchiver.archivedData(withRootObject: locations, requiringSecureCoding: false)
        UserDefaults.standard.set(distance, forKey: "distance")
        UserDefaults.standard.set(locationsData, forKey: "locations")
        UserDefaults.standard.set(startTime, forKey: "startTime")
    }

    private func loadRide() {
        distance = UserDefaults.standard.double(forKey: "distance")
        if let locationsData = UserDefaults.standard.data(forKey: "locations") {
            if let locations = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(locationsData) as? [CLLocation] {
                self.locations = locations
            }
        }
        startTime = UserDefaults.standard.object(forKey: "startTime") as? Date
    }

    private func saveSavedRides() {
        if let encoded = try? JSONEncoder().encode(savedRides) {
            UserDefaults.standard.set(encoded, forKey: "savedRides")
        }
    }

    private func loadSavedRides() {
        if let savedRidesData = UserDefaults.standard.data(forKey: "savedRides") {
            if let decodedRides = try? JSONDecoder().decode([Ride].self, from: savedRidesData) {
                savedRides = decodedRides
            }
        }
    }

    func deleteRide(at offsets: IndexSet) {
        savedRides.remove(atOffsets: offsets)
        saveSavedRides()
    }
}
