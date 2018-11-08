//
//  SongsCollectionViewCell.swift
//  MusicApp
//
//  Created by Madan on 08/11/18.
//  Copyright © 2018 TCS. All rights reserved.
//

import UIKit
import QuartzCore

class SongsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var coverSmallImageView: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        coverSmallImageView.backgroundColor = .clear
        movieTitle.backgroundColor = .clear
    }
}
