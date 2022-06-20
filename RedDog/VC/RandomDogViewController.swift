import UIKit

class RandomDogViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var like: UIButton!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    var counter = 0
    let defaults = UserDefaults.standard
    var imageUrl = ""
    
    @IBOutlet weak var nextButton: RoundedButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.sharedInstance.parseAllBreedsJSON {
            print("")
        }
        loader.startAnimating()
        
        
        NetworkManager.sharedInstance.parseJSON(urlStr: "https://dog.ceo/api/breeds/image/random") { str in
            DispatchQueue.main.async {
                self.loader.stopAnimating()
            }
            self.imageView.imageFromServerURL(urlString: str) {
                print("=)")
            }
        }
        
        
        
//        NetworkManager.sharedInstance.parseJSON(urlStr: "https://dog.ceo/api/breeds/image/random") {
//            DispatchQueue.main.async {
//                self.loader.stopAnimating()
//            }
//            self.imageView.imageFromServerURL(urlString: NetworkManager.sharedInstance.linkString) {
//                print("=)")
//            }
//        }
    }
    
    @IBAction func likeTapped(_ sender: Any) {
        self.like.isUserInteractionEnabled = false
        self.nextButton.isUserInteractionEnabled = false
        var arrayString = defaults.stringArray(forKey: "arr") ?? [String]()
        arrayString.append(NetworkManager.sharedInstance.linkString)
        defaults.set(arrayString, forKey: "arr")
        counter += 1
        
        UIView.animate(withDuration: 0.5) {
            self.like.backgroundColor = UIColor(red: 0.40, green: 0.9, blue: 0.56, alpha: 1.00)
        } completion: { _ in
            UIView.animate(withDuration: 0.5) {
                self.like.backgroundColor = UIColor(red: 0.92, green: 0.29, blue: 0.26, alpha: 1.00)
            } completion: { _ in
                self.like.isUserInteractionEnabled = true
                self.nextButton.isUserInteractionEnabled = true
            }
            self.newDog()
        }
    }
    
    
    @IBAction func nextDogTapped(_ sender: Any) {
        newDog()
    }
    
    func newDog() {
        UIView.transition(with: imageView, duration: 1, options: .transitionCrossDissolve, animations: {
            NetworkManager.sharedInstance.parseJSON(urlStr: "https://dog.ceo/api/breeds/image/random") { str in
                self.imageView.imageFromServerURL(urlString: str) {
                    print("=)")
                }
            }
        }, completion: nil)
    }

}
extension UIImageView {
public func imageFromServerURL(urlString: String, completion: @escaping () -> Void) {
//    self.image = nil
    let urlStringNew = urlString.replacingOccurrences(of: " ", with: "%20")
    URLSession.shared.dataTask(with: NSURL(string: urlStringNew)! as URL, completionHandler: { (data, response, error) -> Void in
        if error != nil {
            print(error as Any)
            return
        }
        DispatchQueue.main.async(execute: { () -> Void in
            let image = UIImage(data: data!)
            self.image = image
            completion()
        })

    }).resume()
}}
