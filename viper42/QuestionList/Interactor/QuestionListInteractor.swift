//
//  QuestionListInteractor.swift
//  viper42
//
//  Created by Udo von Eynern on 08.12.18.
//  Copyright © 2018 Udo von Eynern. All rights reserved.
//

// Presenter -> Interactor
protocol QuestionListInteractorProtocol: class {
    
    var presenter: QuestionListPresenterProtocol? { get set }
    var localDatamanager: QuestionListLocalDataManagerProtocol? { get set }
    var remoteDatamanager: QuestionListRemoteDataManagerProtocol? { get set }
    
    func retrieveQuestions(_ completion: @escaping (_ questions: [Question], _ error: Error?)-> Void)
}

class QuestionListInteractor: QuestionListInteractorProtocol {

    weak var presenter: QuestionListPresenterProtocol?
    var localDatamanager: QuestionListLocalDataManagerProtocol?
    var remoteDatamanager: QuestionListRemoteDataManagerProtocol?

    func retrieveQuestions(_ completion: @escaping (_ questions: [Question], _ error: Error?)-> Void) {
        
        localDatamanager?.retrieveQuestions({ (localQuestions, error) in
            if error == nil {
                if localQuestions.isEmpty {
                    self.remoteDatamanager?.retrieveQuestions({ (remoteQuestions, error) in
                        completion(remoteQuestions, error)
                    });
                } else {
                    completion(localQuestions, error)
                }
            } else {
                completion([], error)
            }
        })
    }
}
