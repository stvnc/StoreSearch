//
//  NothingCell.swift
//  StoreSearch
//
//  Created by Vincent Angelo on 05/08/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import UIKit

class NothingCell: UITableViewCell {
    let nothingLabel: UILabel = {
       let label = UILabel()
        label.text = "No Results!"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(){
        addSubview(nothingLabel)
        nothingLabel.centerX(inView: self)
        nothingLabel.centerY(inView: self)
    }
}
