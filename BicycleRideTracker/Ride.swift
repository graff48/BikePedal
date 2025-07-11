import Foundation

struct Ride: Codable, Identifiable {
    let id: UUID
    let distance: Double
    let duration: TimeInterval
    let date: Date
    let topSpeed: Double

    var averageSpeed: Double {
        return distance / duration
    }
}