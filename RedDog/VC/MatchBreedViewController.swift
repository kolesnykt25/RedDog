import UIKit

var anotherBreeds = ["Terrier-Sealyham","Finnish-Lapphund","Dhole","Hound-Ibizan","Hound-Plott","Kuvasz","Labrador","Pointer-German","Terrier-Norwich","Saluki","Puggle","Spaniel-Sussex","Affenpinscher","Whippet","Chow","Hound-Ibizan","Terrier-Norfolk","Clumber","Chihuahua","Germanshepherd","Terrier-American","Terrier-Wheaten","Terrier-Silky","Setter-English","Hound-Ibizan","Terrier-Cairn","Cotondetulear","Appenzeller","Saluki"]

class MatchBreedViewController: UIViewController {
    
    @IBOutlet weak var firstButton: RoundedButton!
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var secondButton: RoundedButton!
    
    @IBOutlet weak var thirdButton: RoundedButton!
    
    @IBOutlet weak var fourthButton: RoundedButton!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var nameOfBreed = ""
    
    var arrOfButton = [UIButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loader.showLoader()
        arrOfButton = [firstButton, secondButton, thirdButton, fourthButton]
        arrOfButton.forEach { btn in
            btn.alpha = 0
        }
        imageView.alpha = 0
        parseAndPutText()
    }
    
    @IBAction func checkMatch(_ sender: UIButton) {
        if (sender.tag == 1) {
            UIView.animate(withDuration: 1) {
                sender.backgroundColor = .green
            } completion: { _ in
                
                UIView.animate(withDuration: 1) {
                    self.arrOfButton.forEach { btn in
                        btn.backgroundColor = UIColor(red: 0.92, green: 0.29, blue: 0.26, alpha: 1.00)
                        btn.tag = 0
                    }
                }
                UIView.transition(with: self.imageView, duration: 1, options: .transitionCrossDissolve, animations: {
                    self.loader.showLoader()
                    self.parseAndPutText()
                }, completion: nil)
            }
            
            
        } else {
            sender.backgroundColor = .red
        }
    }
    
    func setCorrectButton() {
        
        UIView.animate(withDuration: 1) {
            self.arrOfButton.forEach { btn in
                btn.alpha = 1
            }
        } completion: { _ in
            UIView.animate(withDuration: 1) {
                self.imageView.alpha = 1
            }
        }
        
        let answer = giveBreed(link: NetworkManager.sharedInstance.linkString)
        let randAnswer = arrOfButton.randomElement()
        randAnswer?.tag = 1
        randAnswer?.titleLabel?.text = answer
        randAnswer?.setTitle(answer, for: .normal)
        let rand = Int.random(in: 0...anotherBreeds.count - 5)
        var counter = 0
        arrOfButton.forEach { btn in
            if (btn.tag != 1) {
                if (anotherBreeds[rand + counter] == answer) {
                    btn.titleLabel?.text = "Pooch"
                } else {
                    btn.setTitle(anotherBreeds[rand + counter], for: .normal)
                    btn.titleLabel?.text = anotherBreeds[rand + counter]
                }
                counter += 1
            }
        }
    }
    
    func parseAndPutText() {
        
        NetworkManager.sharedInstance.parseJSON(urlStr: "https://dog.ceo/api/breeds/image/random") { str in
            self.imageView.imageFromServerURL(urlString: str) {
                self.nameOfBreed = giveBreed(link: str)
                DispatchQueue.main.async {
                    self.setCorrectButton()
                    self.loader.hideLoader()
                }
            }
            
        }
    }
    
    
}
func giveBreed(link: String) -> String {
    var arrLink = link.components(separatedBy: "/")
    let indexOfBreed = arrLink.firstIndex(of: "breeds")! + 1
    return arrLink[indexOfBreed].capitalized
}

extension UIActivityIndicatorView {
    func showLoader() {
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1
        }
        self.startAnimating()
    }
    
    func hideLoader() {
        UIView.animate(withDuration: 0.3) {
            self.alpha = 0
        }
        self.stopAnimating()
    }
}
