//
//  DbManager.swift
//  ShadiDotCom
//
//  Created by Rohit on 16/01/25.
//

import CoreData

final class DbManager {
    //1
    static let shared = DbManager()
    private var context : NSManagedObjectContext
    // var viewContext : NSManagedObjectContext
    
    let persistenceController = PersistenceController.shared
    //2.
    private init() {
        context =  persistenceController.container.viewContext
    }
    
    //TODO: store added player info
    func saveContext() {
        persistenceController.saveContext(context: context)
        
    }
    func fetchCount(entity : String, predicate: NSPredicate? = nil) -> Int{
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entity)
        fetchRequest.predicate = predicate
        
        var recordsCount = 0
        do{
            recordsCount = try context.count(for: fetchRequest)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        print("Record_Count\(recordsCount)")
        
        return recordsCount
    }
    
    func savePersonsInDataBase(data :[Result]?, completion: () -> ()) -> Void {
        if let persons = data {
            for personData in persons {
                                
                if let userId = personData.phone,DbManager.shared.fetchCount(entity: "Person", predicate: NSPredicate(format: "phone = %@",userId)) == 0{
                    let entity = NSEntityDescription.entity(forEntityName: "Person", in: context)
                    let newUser = NSManagedObject(entity: entity!, insertInto: context)
                    newUser.setValuesForKeys(personData.toDictionary!)
                    
                }else{
                    //already exist
                }
            }
        }
        persistenceController.saveContext(context: context)
        completion()
    }
    
//    func createEntity(entityName : String) -> NSManagedObject? {
//        let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)
//        let newUser = NSManagedObject(entity: entity!, insertInto: context)
//        //printLog("Created managed object data \(entityName)")
//        return newUser
//    }
    
    
    func fetchPerson() -> [Person] {
        var persons = [Person]()
        let fetchrequest = Person.fetchRequest()
        
        do{
            let personArr = try context.fetch(fetchrequest)
            if personArr.count > 0 {
                persons = personArr
                print("objectCount\(personArr.count)")
            }
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        return persons
    }
}
