//
//  PhotoCell.swift
//  Flickr
//
//  Created by Basma on 9/13/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit
import SDWebImage

class PhotoCell: UICollectionViewCell {
    @IBOutlet weak var photoIV: UIImageView?
    var photoCellViewModel : PhotoCellVM? {
        didSet {
            photoIV?.sd_setImage(with: URL( string: photoCellViewModel?.imageUrl ?? "" ), completed: nil)
            print(photoCellViewModel?.imageUrl ?? "")
        }
    }
}
