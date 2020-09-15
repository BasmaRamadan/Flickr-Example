//
//  PhotoDetailsVC.swift
//  Flickr
//
//  Created by Basma on 9/15/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit
import SDWebImage

class PhotoDetailsVC: UIViewController {

    var photo : Photo?
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false

        guard let photoItem = photo else {
            fatalError("No Photo to display")
        }
        imageView.sd_setImage(with: URL(string: photoItem.imageURL()), completed: nil)
        let title = (photoItem.title == "") ? "No Title" : photoItem.title
        titleLbl.text = title
    }
    
}
