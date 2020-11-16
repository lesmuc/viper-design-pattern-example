//
//  QuestionListRouter.swift
//  viper42
//
//  Created by Udo von Eynern on 08.12.18.
//  Copyright © 2018 Udo von Eynern. All rights reserved.
//

import UIKit

protocol QuestionListRouterProtocol : class {
    
    func createQuestionListModule() -> UIViewController
    
    func presentQuestionDetailScreen(from view: QuestionListViewProtocol, forQuestion question: Question)
}

class QuestionListRouter: QuestionListRouterProtocol {
    
    var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    func createQuestionListModule() -> UIViewController {
        let navigationController:UINavigationController = mainStoryboard.instantiateViewController(withIdentifier: "QuestionsNavigationController") as! UINavigationController
        if let view = navigationController.children.first as? QuestionListViewController {
            
            let presenter:QuestionListPresenterProtocol = QuestionListPresenter()
            let interactor: QuestionListInteractorProtocol = QuestionListInteractor()
            let localDataManager:QuestionListLocalDataManagerProtocol = QuestionListLocalDataManager()
            let remoteDataManager:QuestionListRemoteDataManagerProtocol = QuestionListRemoteDataManager()
            let router: QuestionListRouterProtocol = QuestionListRouter()
            
            view.presenter = presenter
            
            presenter.view = view
            presenter.router = router
            presenter.interactor = interactor
            
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager
            interactor.remoteDatamanager = remoteDataManager
            
            return navigationController
        }
        
        return UIViewController()
    }
    
    func presentQuestionDetailScreen(from view: QuestionListViewProtocol, forQuestion question: Question) {
        
    }
    
    
}
