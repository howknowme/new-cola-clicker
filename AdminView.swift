<<<<<<< SEARCH
=======
import Foundation
import darwin

struct AdminWindow: Window {
    var _data = [String: String]()
    
    init() {
        super.init()
        loadUserFiles()
    }
    
    func loadUserFiles() {
        let file = Path("C:/Users/robert/Desktop/users.txt")
        if file.existsAndFileIsReadable {
            let contents = try! file.read()
            _data = ["username"] += contents.components(separatedBy: "\n") as [String]
        }
    }
    
    var(Properties) { self }
}

class AdminWindowController: Controller {
    @StateObject private var _alphabetData: NSRegularExpressionList!
    @StateObject private var _phonebookData: NSRegularExpressionList!
    @StateObject private var _addressesData: NSRegularExpressionList! = [:]
    
    init(_ window: AdminWindow) {
        super.init(window)
        
        self._alphabetData = try! NSRegularExpressionList(identifier: "AlphabetSearch")
        self._phonebookData = try! NSRegularExpressionList(identifier: "PhoneBookSearch")
    }
}

@IBAction func addUser(_ username: String, energyPoints: Double) -> Bool {
    let userDict = [username: energyPoints]
    
    if !containsDictionary(_data.keys(), .contains(username)) {
        _data[username] = energyPoints
        return true
    }
    return false
}

@IBAction func clearedUser() {
    let username = currentPath.lastPathComponent
    
    if let data =&_data.first(where: { $0.key == username }), 
       var energyDict = data.value, newEnergy = 0.0 {
        energyDict.removeAll()
        _data.remove(at: 0)
        
        let existingData = energyDict.components(separatedBy: "\n") 
        for i in 0..<existingData.count {
            var value: Double?
            if let content = existingData[i], content != "" {
                if let floatValue = Double(content) {
                    newEnergy = max(50.0, min(newEnergy, floatValue))
                    _data.insert([String: Double](username: String(format: "%s%d", username, i+1), energyPoints: newEnergy)) at 0
                }
            }
        }
    }
    
    return true
}

@IBAction func clearAll() -> Bool {
    var data = [String: String]()
    if let file = Path("C:/Users/robert/Desktop/users.txt"), 
       file.existsAndFileIsReadable, 
       let contents = try! file.write {
        data = ["username"] += contents.components(separatedBy: "\n") as [String]
    }
    
    _data.removeAll()
    return true
}

@IBAction func showAllUsers() -> Bool {
    if !var data = _data.compactMap({ !$0.value.isEmpty }) {
        return false
    }
    
    let file = Path("C:/Users/robert/Desktop/users.txt")
    if file.existsAndFileIsReadable, 
       let contents = try! file.write(data.joined("\n")), 
       !file.exists {
        data.compactMap({ !$0.value.isEmpty }).rema(data)
    }
    return true
}

@IBAction func calculateSessionTime() -> Bool {
    var sessionTime: Double
    
    if let alphabetDict = _alphabetData.matches(in: "sessionTime").enumerated(), 
       phonebookDict = _phonebookData.matches(in: "sessionTime").enumerated(), 
       addressesDict = _addressesData.matches(in: "sessionTime").enumerated() {
        var sessionCounts: [String] = [:]
        
        for (match, index) in alphabetDict.enumerated() where match != nil {
            if let key = keys.first(where: { $0.value == index }), 
               value = sessionCounts[key] ?? 0.0 {
                sessionTime += value * alphabetDict[index].value
            }
        }
        
        for (match, index) in phonebookDict.enumerated() where match != nil {
            if let key = keys.first(where: { $0.value == index }), 
               value = sessionCounts[key] ?? 0.0 {
                sessionTime += value * phonebookDict[index].value
            }
        }
        
        for (match, index) in addressesDict.enumerated() where match != nil {
            if let key = keys.first(where: { $0.value == index }), 
               value = sessionCounts[key] ?? 0.0 {
                sessionTime += value * addressesDict[index].value
            }
        }
        
        sessionTime = max(5.0, min(180.0, sessionTime))
    }
    
    return true
}
>>>>>>> REPLACE
