//
//  LocalDataSource.swift
//  Sportify
//
//  Created by Ali_Kotb on 01/06/2025.
//

import Foundation
import UIKit
import CoreData

class LocalDataSource {
    static let shared = LocalDataSource()

    let managedContext: NSManagedObjectContext

    private init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.managedContext = appDelegate.persistentContainer.viewContext
    }
    
    func saveLeague(obj: LeagueLocal){
            if let entity = NSEntityDescription.entity(forEntityName: "FavoriteDB", in: managedContext) {
                let newObj = NSManagedObject(entity: entity, insertInto: managedContext)
                newObj.setValue(obj.leagueKey, forKey: "leagueKey")
                newObj.setValue(obj.leagueLogo, forKey: "leagueLogo")
                newObj.setValue(obj.leagueName, forKey: "leagueName")
                newObj.setValue(obj.sport, forKey: "sport")
                newObj.setValue(obj.isFavorite, forKey: "isFavorite")
            }
        do {
            try managedContext.save()
            print("Data cached successfully.")
        } catch {
            print("Failed to save data: \(error.localizedDescription)")
        }
    }
    
    func deleteLeague(obj: LeagueLocal) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteDB")
        fetchRequest.predicate = NSPredicate(format: "leagueKey == %d", obj.leagueKey)

        do {
            let results = try managedContext.fetch(fetchRequest)
            for item in results {
                managedContext.delete(item)
            }

            try managedContext.save()
            print("League deleted successfully.")
        } catch {
            print("Failed to delete league: \(error.localizedDescription)")
        }
    }

    
    
    
    func getAllLeague() -> [LeagueLocal] {
        var list: [LeagueLocal] = []
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteDB")

        do {
            let results = try managedContext.fetch(fetchRequest)
            for item in results {
                guard let leagueKey = item.value(forKey: "leagueKey") as? Int16,
                      let leagueLogo = item.value(forKey: "leagueLogo") as? String,
                      let leagueName = item.value(forKey: "leagueName") as? String,
                      let sport = item.value(forKey: "sport") as? String else {
                    continue
                }

                let isFavorite = item.value(forKey: "isFavorite") as? Bool ?? false
                let league = LeagueLocal(
                    leagueKey: leagueKey,
                    leagueName: leagueName,
                    leagueLogo: leagueLogo,
                    sport: sport,
                    isFavorite: isFavorite
                )

                list.append(league)
            }
        } catch {
            print("Fetch error: \(error.localizedDescription)")
        }

        return list
    }

    
    func checkIsFavorite(leagueName: String) ->Bool{
        let list = self.getAllLeague()
        
        for item in list{
            if item.leagueName == leagueName{
                return true
            }
        }
        return false
    }
}

