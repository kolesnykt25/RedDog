import Foundation

var eventsList = [Event]()

class Event: Codable
{
    var id: Int!
    var name: String!
    var date: Date!
    
    func eventsForDate(date: Date) -> [AnyObject]
    {
        var daysEvents = [Event]()
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

        for event in arrayOfEvents
        {
            if(Calendar.current.isDate(event.date, inSameDayAs:date))
            {
                daysEvents.append(event)
            }
        }
        return daysEvents
    }
}
