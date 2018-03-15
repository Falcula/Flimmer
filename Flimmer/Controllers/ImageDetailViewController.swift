//
//  ImageDetailViewController.swift
//  Flimmer
//
//  Created by Jesper Kramming on 2018-02-21.
//  Copyright © 2018 NegativeZero. All rights reserved.
//

import UIKit

class ImageDetailViewController: UIViewController {
    
    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var imageTitle: UILabel!
    
    private var imageCollectionViewModel = ImageCollectionViewModel()
    
    var imageDetailViewModel: ImageDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let imageDetailViewModel = imageDetailViewModel {
            
            // Set the selected UIImage to the UIImageView.
            selectedImage.image = imageDetailViewModel.ImageData
            
            // Get more information about the selected image
            imageDetailViewModel.getImageinfo(imageId: imageDetailViewModel.ImageDetail?.id, completion: { (info) in
                DispatchQueue.main.async {
                    let imageInfo = info as! ImageDetailRoot
                    self.imageTitle.text = (imageInfo.photo.owner.realname.count > 0) ? imageInfo.photo.owner.realname : "unknown"
                }
            })
        }
    }
    
    @IBAction func CloseModal(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
   
}


