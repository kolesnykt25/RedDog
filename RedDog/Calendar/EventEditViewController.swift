import UIKit

class EventEditViewController: UIViewController
{
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        datePicker.date = selectedDate
    }
    
    @IBAction func saveAction(_ sender: Any)
    {

        var arrayOfEvents = [Event]()
        if let storedObject: Data = UserDefaults.standard.data(forKey: "eventArray")
        {
            do
            {
                arrayOfEvents = try PropertyListDecoder().decode([Event].self, from: storedObject)
                for event in arrayOfEvents
                {
                    print(event.name)
                    print(event.date)
                }
            }
            catch
            {
                print(error.localizedDescription)
            }
        }
        let newEvent = Event()
        newEvent.id = arrayOfEvents.count
        newEvent.name = nameTF.text
        newEvent.date = datePicker.date
        var arrEv = arrayOfEvents
        arrEv.append(newEvent)
        do
        {
            UserDefaults.standard.set(try PropertyListEncoder().encode(arrEv), forKey: "eventArray")
            UserDefaults.standard.synchronize()
        }
        catch
        {
            print(error.localizedDescription)
        }
        
        navigationController?.popViewController(animated: true)
    }
}
