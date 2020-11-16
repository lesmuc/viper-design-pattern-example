//
//  QuestionListPresenterTests.swift
//  viper42Tests
//
//  Created by Udo von Eynern on 19.12.18.
//  Copyright © 2018 Udo von Eynern. All rights reserved.
//

import XCTest
@testable import viper42

class QuestionListPresenterTests : XCTestCase {
    
    var presenter : QuestionListPresenterProtocol!
    var interactor : TestQuestionListInteractor!
    var router : TestQuestionListRouter!

    override func setUp() {
        super.setUp()
        
        self.interactor = TestQuestionListInteractor()
        self.router = TestQuestionListRouter()

        self.presenter = QuestionListPresenter()
        self.presenter.interactor = self.interactor
        self.presenter.router = self.router
    }
    
    func testThatItRetrievesQuestions() {
        let testExpectation = expectation(description: #function)
        
        if let filePath = Bundle.main.path(forResource: "response", ofType: "json", inDirectory: nil) {
            do {
                let fileUrl = URL(fileURLWithPath: filePath)
                let jsonData = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                
                let responseString = String(decoding: jsonData, as: UTF8.self)
                
                print(responseString)
                
                guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext else {
                    fatalError("Failed to retrieve context")
                }
                
                let decoder = JSONDecoder()
                decoder.userInfo[codingUserInfoKeyManagedObjectContext] = CoreDataManager.sharedManager.persistentContainer.viewContext
                
                // Date Formatter for JSONDecoder
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
                dateFormatter.calendar = Calendar(identifier: .iso8601)
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                
                let questionList = try decoder.decode(QuestionListStruct.self, from: jsonData)
                
                XCTAssertEqual(questionList.questions.count, 152)
                
                // next step: calling the presenter with the list of questions
                
                testExpectation.fulfill()
                
            } catch {
                print(error)
                fatalError("Unable to read contents of the file url")
            }
        }
        
         waitForExpectations(timeout: 3.0, handler: nil)
        
    }
}

extension QuestionListPresenterTests {
    class TestQuestionListRouter: QuestionListRouterProtocol {

        var showCreateQuestionListCalled = false
        var showDetailCalled = false
        
        func createQuestionListModule() -> UIViewController {
            showCreateQuestionListCalled = true
            return UIViewController()
        }
        
        func presentQuestionDetailScreen(from view: QuestionListViewProtocol, forQuestion question: Question) {
            showDetailCalled = true
        }
    }
    
    class TestQuestionListInteractor: QuestionListInteractorProtocol {
        var presenter: QuestionListPresenterProtocol?
        
        var localDatamanager: QuestionListLocalDataManagerProtocol?
        
        var remoteDatamanager: QuestionListRemoteDataManagerProtocol?
        
        func retrieveQuestions(_ completion: @escaping ([Question], Error?) -> Void) {
            
        }
    }
}
