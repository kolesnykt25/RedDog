
import UIKit

class TrainingSoundViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    @IBAction func chooseSoundTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            sender.backgroundColor = .systemGreen
        } completion: { _ in
            UIView.animate(withDuration: 0.3) {
                sender.backgroundColor = UIColor(red: 0.92, green: 0.29, blue: 0.26, alpha: 1.00)
            }
            
        }
        var name = ""
        switch sender.tag {
        case 1:
            name = "toy"
        case 2:
            name = "policeSiren"
        case 3:
            name = "catMeow"
        case 4:
            name = "bird"
        case 5:
            name = "carHorn"
        case 6:
            name = "dingDon"
        case 7:
            name = "whistle"
        case 8:
            name = "food"
        case 9:
            name = "door"
        default :
            name = "toy"
        }
         SoundManager.sharedInstance.playSound(name: name)
    }
}
