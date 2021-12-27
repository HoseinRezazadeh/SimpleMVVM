//
//  DataViewModelHome.swift
//  SimpleMVVM
//
//  Created by 𝙷𝚘𝚜𝚎𝚒𝚗 𝙹𝚊𝚗𝚊𝚝𝚒  on 12/27/21.
//

import Foundation

class DataViewModelHome {
  
    var datas: [Search] = [Search]()
    var reloadTableView: (()->())?
    var showError: (()->())?
    
    private var pageNumber : Int = 1
    private var vms = [DataListCellViewModel]()
    private var cellViewModels: [DataListCellViewModel] = [DataListCellViewModel]() {
        didSet {
            self.reloadTableView?()
        }
    }
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    public func fetchData(_ StringSearch : String) {
        RequestHelper.dataRequest(with: "http://www.omdbapi.com/?s=\(StringSearch)&apikey=6ca8df0&page=\(pageNumber)", objectType: GeneralSearch.self) { [weak self] (result: Result) in
            switch result {
            case .success(let object):
                self?.createCell(datas: object.search)
                DispatchQueue.main.async {
                    self!.reloadTableView?()
                }
            case .failure(let error):
                print(error)
                self?.showError?()
            }
        }
        
    }
    
   
   public func getCellViewModel( at indexPath: IndexPath ) -> DataListCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
   public func createCell(datas: [Search]){
        self.datas = datas
        for data in datas {
            vms.append(DataListCellViewModel(titleText: data.title!, typeText: data.type.rawValue,
                                             yearText: data.year!,
                                             imageURL: data.poster))
        }
        cellViewModels = vms
    }
    
   public func paginationAPI(_ indexPath : IndexPath) {
        let indexTotal = indexPath.row
        let dataCount = cellViewModels.count
        if indexTotal == dataCount - 1 {
            pageNumber += 1
            fetchData("run")
        }
    }
    
    
}

struct DataListCellViewModel {
    let titleText: String
    let typeText: String
    let yearText: String
    let imageURL : String
}
