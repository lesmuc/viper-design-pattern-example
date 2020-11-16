//
//  QuestionListRemoteDataManager.swift
//  viper42
//
//  Created by Udo von Eynern on 08.12.18.
//  Copyright © 2018 Udo von Eynern. All rights reserved.
//

import Foundation
import Alamofire

// Interactor -> RemoteDataManager
protocol QuestionListRemoteDataManagerProtocol: class {
    
    func retrieveQuestions(_ completion: @escaping (_ questions: [Question], _ error: Error?)-> Void)
}

class QuestionListRemoteDataManager: QuestionListRemoteDataManagerProtocol {
    
    func retrieveQuestions(_ completion: @escaping (_ questions: [Question], _ error: Error?)-> Void) {
        
        Alamofire
            .request(Endpoints.Questions.fetchFresh.url)
            .validate()
            .responseData { response in
                
                do {
                    // If we do not have any data
                    guard let responseData = response.data else {
                        completion([], nil)
                        return
                    }
                
                    guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext else {
                        fatalError("Failed to retrieve context")
                    }

                    let decoder = JSONDecoder()
                    
                    // Date Formatter for JSONDecoder
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
                    dateFormatter.calendar = Calendar(identifier: .iso8601)
                    decoder.dateDecodingStrategy = .formatted(dateFormatter)
                    
                    // Managed Object Context for JSONDecoder
                    decoder.userInfo[codingUserInfoKeyManagedObjectContext] = CoreDataManager.sharedManager.persistentContainer.viewContext
                    
                    let responseString = String(decoding: responseData, as: UTF8.self)
                    
                    print(responseString)

                    let questionList = try decoder.decode(QuestionListStruct.self, from: responseData)
    
                    completion(questionList.questions, nil)
                    
                } catch let error {
                    
                    print("error trying to decode response")
                    print(error)
                    
                    completion([], error)
                }
        }
    }
}
