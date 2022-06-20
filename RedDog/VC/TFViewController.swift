import UIKit

class TFViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var yesButton: RoundedButton!
    
    @IBOutlet weak var noButton: RoundedButton!
    
    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    var answer = ""
    let scam = Bool.random()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideAll()
        loader.showLoader()
        
        
        NetworkManager.sharedInstance.parseJSON(urlStr: "https://dog.ceo/api/breeds/image/random") { str in
            self.imageView.imageFromServerURL(urlString: str) {
                DispatchQueue.main.async {
                    UIView.animate(withDuration: 1) {
                        self.putAll()
                        self.loader.hideLoader()
                        self.yesButton.backgroundColor = .systemGreen
                    }
                    self.setLabel()
                }
            }
        }
    }
    
    func hideAll() {
        imageView.alpha = 0
        noButton.alpha = 0
        textLabel.alpha = 0
        yesButton.alpha = 0
    }
    
    func putAll() {
        imageView.alpha = 1
        noButton.alpha = 1
        yesButton.alpha = 1
        textLabel.alpha = 1
    }
    

    @IBAction func yesNoCheckTapped(_ sender: UIButton) {
        
        let breed = giveBreed(link: NetworkManager.sharedInstance.linkString)
        switch scam {
        case true:
            if (sender.tag == 1) {
                textLabel.text = "No, this is a " + breed
                textLabel.textColor = .systemRed
            } else {
                textLabel.textColor = .systemGreen
                textLabel.text = "Correct! This is a " + breed
            }
        case false:
            if (sender.tag == 1) {
                textLabel.textColor = .systemGreen
                textLabel.text = "Correct! This is a " + breed
            } else {
                textLabel.textColor = .systemRed
                textLabel.text = "No, this is a " + breed
            }
        default:
            print("=))")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.loader.showLoader()
            UIView.animate(withDuration: 1) {
                self.hideAll()
            } completion: { _ in
                self.textLabel.textColor = .black
                NetworkManager.sharedInstance.parseJSON(urlStr: "https://dog.ceo/api/breeds/image/random") { str in
                    self.imageView.imageFromServerURL(urlString: str) {
                        DispatchQueue.main.async {
                            UIView.animate(withDuration: 1) {
                                self.putAll()
                                self.loader.hideLoader()
                            }
                            self.setLabel()
                        }
                    }
                }
            }
            
            
        }
    }
    
    func setLabel() {
        
        if (scam) {
            answer = anotherBreeds.randomElement()!
            textLabel.text = "Is this a " + answer + "?"
        } else {
            answer = giveBreed(link: NetworkManager.sharedInstance.linkString)
            textLabel.text = "Is this a " + answer + "?"
        }
    }
    
    func nextDog(sender: UIButton) {
        UIView.transition(with: imageView, duration: 1, options: .transitionCrossDissolve, animations: {
            NetworkManager.sharedInstance.parseJSON(urlStr: "https://dog.ceo/api/breeds/image/random") { str in
                self.imageView.imageFromServerURL(urlString: str) {
                    DispatchQueue.main.async {
                        self.setLabel()
                    }
                }
                
                
            }
        }, completion: nil)
    }
    
}
