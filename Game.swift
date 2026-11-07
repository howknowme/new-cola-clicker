import Foundation

func calculateEnergy(_ clicksPerSecond: Int) -> Double {
    var energy = (clicksPerSecond * 0.5) + 50.0
    if energy > 100 { return 100 }
    return min(energy, 200)
}

struct GameWindow: Window {
    private let _alphabetData: NSRegularExpressionList!
    private let _phonebookData: NSRegularExpressionList!
    private var _searchData = [:]
    
    init() {
        super.init()
        loadDatabaseData()
    }
    
    func searchAlphabet(for searchTerm: String) -> [String] {
        return alphabetData.matches(in: searchTerm).enumerated()
    }
    
    func searchPhoneBook(for searchTerm: String) -> [String] {
        return phonebookData.matches(in: searchTerm).enumerated()
    }
}
