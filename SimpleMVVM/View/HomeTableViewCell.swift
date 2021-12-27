//
//  HomeTableViewCell.swift
//  SimpleMVVM
//
//  Created by 𝙷𝚘𝚜𝚎𝚒𝚗 𝙹𝚊𝚗𝚊𝚝𝚒  on 12/27/21.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var titelLabel: UILabel!
    
    public func configuration (yearMovie : String , typeMovie : String , titelMoview : String , imageURLString : String) {
        yearLabel.text = yearMovie
        typeLabel.text = typeMovie
        titelLabel.text = titelMoview
        FetchAndCashImage.fetchImageFromURL(UIImageView: movieImage, stringURL: imageURLString)
    }
}
