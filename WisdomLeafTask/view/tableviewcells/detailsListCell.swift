//
//  detailsListCell.swift
//  WisdomLeafTask
//
//  Created by Venkatesh on 24/08/20.
//  Copyright © 2020 Venkatesh. All rights reserved.
//

import UIKit

class detailsListCell: UITableViewCell {
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var imgVw: ImageViewLoader!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDes: UILabel!
    
    static let identifier = "detailsListCell"
    
    //Setting data to elements
    func configure(with model: ArrayResultsObj) {
        labelTitle.text = model.author
        labelDes.text = model.url
        if let imageUrl = URL(string: model.download_url ?? ""){
            imgVw.loadImage(imageUrl)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    //Setting UI Elements properties
    func setupUI() {
        viewHeader.layer.cornerRadius = 5
        viewHeader.layer.masksToBounds = false
        viewHeader.layer.borderWidth = 1
        viewHeader.layer.borderColor = UIColor.lightGray.cgColor
    }

}
