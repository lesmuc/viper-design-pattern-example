//
//  QuestionListPresenter.swift
//  viper42
//
//  Created by Udo von Eynern on 08.12.18.
//  Copyright © 2018 Udo von Eynern. All rights reserved.
//

protocol QuestionListPresenterProtocol: class {
    
    var view: QuestionListViewProtocol?  { get set }
    var interactor: QuestionListInteractorProtocol? { get set }
    var router: QuestionListRouterProtocol? { get set }
    
    func viewDidLoad()
    func viewWillAppear()
    func showQuestionDetail(forQuestion question: Question)
}

class QuestionListPresenter: QuestionListPresenterProtocol { // View -> Presenter

    weak var view: QuestionListViewProtocol?
    var interactor: QuestionListInteractorProtocol?
    var router: QuestionListRouterProtocol?
    
    func viewDidLoad() {

    }
    
    func viewWillAppear() {
        self.view?.showLoading()
        interactor?.retrieveQuestions({ (questions, error) in
            self.view?.hideLoading()
            
            if error != nil {
                self.view?.showError()
            } else {
                self.view?.showQuestions(with: questions)
            }
        })
    }
    
    func showQuestionDetail(forQuestion question: Question) {
        router?.presentQuestionDetailScreen(from: view!, forQuestion: question)
    }
}
