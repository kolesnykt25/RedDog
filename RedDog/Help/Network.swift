import Foundation

struct Dog: Decodable {
    var message: String
}

struct Breeds: Decodable {
    var message: [String:[String]]
}

var allBreeds = [String]()
var imageForEachBreeds = [String]()

class NetworkManager {
    static let sharedInstance = NetworkManager()
    
    var linkString = ""
    
    
    func parseJSON(urlStr: String, completion: @escaping (String) -> Void) {
        let urlString = urlStr
//        let urlString = "https://dog.ceo/api/breeds/image/random"
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, responce, error) in
            guard let data = data else {return}
            guard error == nil else {return}
            
            do{
                let tmp = try JSONDecoder().decode(Dog.self, from: data)
                self.linkString = tmp.message
                completion(tmp.message)
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
    func parseAllBreedsJSON(completion: @escaping () -> Void) {
        let urlString = "https://dog.ceo/api/breeds/list/all"
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, responce, error) in
            guard let data = data else {return}
            guard error == nil else {return}
            
            do{
                let tmp = try JSONDecoder().decode(Breeds.self, from: data)
                allBreeds = tmp.message.map {$0.0}
                allBreeds.sort()
                completion()
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
}
