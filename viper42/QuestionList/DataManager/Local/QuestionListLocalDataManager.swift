//
//  QuestionListLocalDataManager.swift
//  viper42
//
//  Created by Udo von Eynern on 08.12.18.
//  Copyright © 2018 Udo von Eynern. All rights reserved.
//

import CoreData

protocol QuestionListLocalDataManagerProtocol: class {
    
    func retrieveQuestions(_ completion: @escaping (_ questions: [Question], _ error: Error?)-> Void)
    
    func saveQuestion(objectId: Int32, title: String, address: String, postalCode: String, city: String, country: String, latitude: Double, longitude: Double, imagePath: String) throws -> Question?
}

class QuestionListLocalDataManager: QuestionListLocalDataManagerProtocol {
    
    func retrieveQuestions(_ completion: @escaping (_ questions: [Question], _ error: Error?)-> Void) {
        
        let managedObjectContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        let request: NSFetchRequest<Question> = NSFetchRequest(entityName: String(describing: Question.self))
        
        do {
            let questions: [Question] = try managedObjectContext.fetch(request)
            
            completion(questions, nil)
            
        } catch let error {
            
            completion([], error)
        }
    }
    
    func saveQuestion(objectId: Int32, title: String, address: String, postalCode: String, city: String, country: String, latitude: Double, longitude: Double, imagePath: String) throws -> Question? {
        
        if let question = self.getOrCreateQuestionByObjectId(objectId: objectId) {
            question.updatedAt = NSDate()
            question.title = title
            question.address = address
            question.postalCode = postalCode
            question.city = city
            question.country = country
            question.latitude = latitude
            question.longitude = longitude
            question.imagePath = imagePath
            
            return question
        }
        
        throw PersistenceError.couldNotSaveObject
    }
    
    func getOrCreateQuestionByObjectId(objectId: Int32) -> Question? {
        let managedObjectContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        let request: NSFetchRequest<Question> = NSFetchRequest(entityName: String(describing: Question.self))
        request.predicate = NSPredicate(format: "objectId == %@", objectId)
        
        do {
            let fetchedQuestions = try managedObjectContext.fetch(request) as [Question]
            
            if fetchedQuestions.count == 1 {
                return fetchedQuestions.first
            } else {
                if let newQuestion = NSEntityDescription.entity(forEntityName: String(describing: Question.self), in: managedObjectContext) {
                    let question = Question(entity: newQuestion, insertInto: managedObjectContext)
                    question.objectId = objectId
                    question.createdAt = NSDate()
                    return question
                } else {
                    return nil
                }
            }
        } catch {
            return nil
        }
    }
    
    
    
    
}
