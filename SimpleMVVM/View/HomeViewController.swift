//
//  HomeViewController.swift
//  SimpleMVVM
//
//  Created by 𝙷𝚘𝚜𝚎𝚒𝚗 𝙹𝚊𝚗𝚊𝚝𝚒  on 12/27/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataViewModel = DataViewModelHome()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        initViewModel()

    }
    
   private func initViewModel(){
        dataViewModel.reloadTableView = {
            DispatchQueue.main.async { self.tableView.reloadData() }
        }
        dataViewModel.showError = {
            DispatchQueue.main.async { self.showAlert("Ups, something went wrong") }
        }
        dataViewModel.fetchData("run")
    }
    
    
}
//MARK: - UITableViewDataSource
extension HomeViewController : UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataViewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! HomeTableViewCell
        let cellViewModel = dataViewModel.getCellViewModel(at: indexPath)
        cell.configuration(yearMovie: cellViewModel.yearText,
                           typeMovie: cellViewModel.typeText,
                           titelMoview: cellViewModel.titleText,
                           imageURLString: cellViewModel.imageURL)
        return cell
    }
}
//MARK: - UITableViewDelegate
extension HomeViewController : UITableViewDelegate {
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
     func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
         
         if indexPath.row == dataViewModel.numberOfCells - 1 {
             dataViewModel.paginationAPI(indexPath)
         }
    }
}
