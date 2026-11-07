<<<<<<< SEARCH
struct GameManager {
    var player: Player
    
    init(_ player) { self.player = player }
=======
struct GameManager {
    var player: Player
    
    init(_ player) { self.player = player }
    
    func calculateEnergyFromClicks(_ clicksPerSecond: Int) -> Double {
        // Формула расчёта energy points
        let baseEnergy = 50.0 + clicksPerSecond * 0.5
        
        if baseEnergy > 100 {
            return 100
        }
        
        return min(baseEnergy, 200)
    }
>>>>>>> REPLACE
