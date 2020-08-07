//
//  SearchCell.swift
//  StoreSearch
//
//  Created by Vincent Angelo on 05/08/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import UIKit


class SearchCell: UITableViewCell {
    
    var searchResult: SearchResult?
    
    let albumImage: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.setDimensions(height: 60, width: 60)
        iv.image = #imageLiteral(resourceName: "LandscapeButton")
        iv.layer.cornerRadius = 60/4
        return iv
    }()
    
    let songLabel: UILabel = {
       let label = UILabel()
        label.text = "Song Placeholder"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let artistLabel: UILabel = {
        let label = UILabel()
        label.text = "Artist Placeholder"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
        configureSelectedRow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureSelectedRow(){
        let selectedView = UIView(frame: CGRect.zero)
        selectedView.backgroundColor = UIColor(red: 20/255,
            green: 160/255, blue: 160/255, alpha: 0.5)
        selectedBackgroundView = selectedView
    }
    
    func configureCell() {
        addSubview(albumImage)
        albumImage.centerY(inView: self)
        albumImage.anchor(left: leftAnchor, paddingLeft: 16)
        
        let stack = UIStackView(arrangedSubviews: [songLabel, artistLabel])
        stack.axis = .vertical
        stack.spacing = 10
        
        addSubview(stack)
        stack.anchor(top: albumImage.topAnchor, left: albumImage.rightAnchor, bottom: albumImage.bottomAnchor, paddingLeft: 18, paddingRight: 18)
    }
    
}
