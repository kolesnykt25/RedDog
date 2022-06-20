
import UIKit

class PictureByBreedViewController: UIViewController {

    @IBOutlet weak var imageView: RoundedImage!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    var nameOfBreed = ""
    override func viewDidLoad() {
        super.viewDidLoad()
//    https://dog.ceo/api/breed/corgi/images/random
        loader.showLoader()
        newImage()
    }
    
    func newImage() {
        loader.showLoader()
        var linkStr = "https://dog.ceo/api/breed/" + nameOfBreed + "/images/random"
        NetworkManager.sharedInstance.parseJSON(urlStr: linkStr) { str in
            self.imageView.imageFromServerURL(urlString: str) {
                self.loader.hideLoader()
            }
        }
    }
    @IBAction func nextDogTapped(_ sender: Any) {
        newImage()
    }

}
