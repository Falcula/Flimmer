//
//  PhotoCollectionViewController.swift
//  Flimmer
//
//  Created by Jesper Kramming on 2018-02-20.
//  Copyright © 2018 NegativeZero. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ImageCell"

class ImageCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private var viewModel = ImageCollectionViewModel()
   
    var images: [Image] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel.loadImages(completion: { (data) in
            self.images = data
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        })
   
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImageCollectionViewCell
        
            viewModel.getImage(index: indexPath.item, completion: { (image) in
                cell.ImageView.image = image
            })
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.frame.size.width - 40) / 3 //some width
        let height = width
        return CGSize(width: width, height: height);
    }
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
