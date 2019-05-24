//
//  MovieTableViewCell.swift
//  mtech-coding-challenge-three
//
//  Created by Justin Snider on 5/22/19.
//  Copyright © 2019 Justin Snider. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    //========================================
    //MARK: - Properties
    //========================================
    
    var delegate: favoriteButtonDelegate?
    
    //========================================
    //MARK: - IBOutlets
    //========================================
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    //========================================
    //MARK: - IBActions
    //========================================
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        delegate?.favoriteButtonTapped(sender: sender)
    }
    
    //========================================
    //MARK: - Life Cycle Methods
    //========================================

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
