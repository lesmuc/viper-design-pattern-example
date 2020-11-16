//
//  QuestionListViewController.swift
//  viper42
//
//  Created by Udo von Eynern on 07.12.18.
//  Copyright © 2018 Udo von Eynern. All rights reserved.
//

import UIKit
import PKHUD

// Presenter -> View
protocol QuestionListViewProtocol : class {
    
    var presenter: QuestionListPresenterProtocol? { get set }
    
    func showQuestions(with questions: [Question])
    func showError()
    func showLoading()
    func hideLoading()
}

class QuestionListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var presenter: QuestionListPresenterProtocol?
    var questionList: [Question] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.viewWillAppear()
    }
}

extension QuestionListViewController: QuestionListViewProtocol {
    func showQuestions(with questions: [Question]) {
        questionList = questions
        tableView.reloadData()
    }
    
    func showError() {
        HUD.flash(.label("Bitte überprüfen Sie Ihre Internetverbindung und versuchen Sie es erneut."))
    }
    
    func showLoading() {
        HUD.show(.progress)
    }
    
    func hideLoading() {
        HUD.hide()
    }
}

extension QuestionListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionListTableViewCell", for: indexPath) as! QuestionListTableViewCell
        
        let question = questionList[indexPath.row]
        cell.set(forQuestion: question)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230.0;
    }
    
    
}
