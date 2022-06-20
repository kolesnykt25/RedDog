import Foundation

class Day {
    
    static let shared = Day()
    
    var day: Int {
        get {
            return UserDefaults.standard.integer(forKey: "uniqueLevel")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "uniqueLevel")
        }
    }
    
    
    var firstGame: Bool {
        get{
            return UserDefaults.standard.bool(forKey: "first")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "first")
        }
    }

    var nowPlaying = 0
    
    var chosedGame = ""
    
    init() {
        UserDefaults.standard.register(defaults: ["first" : true])
        UserDefaults.standard.register(defaults: ["uniqueLevel" : 1])
    }
}
