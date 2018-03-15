//
//  PhotoCollectionViewController.swift
//  Flimmer
//
//  Created by Jesper Kramming on 2018-02-20.
//  Copyright © 2018 NegativeZero. All rights reserved.
//

import UIKit
import CoreLocation

private let reuseIdentifier = "ImageCell"

class ImageCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private var imageCollectionViewModel = ImageCollectionViewModel()
    private var imageDetailViewModel : ImageDetailViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create the searchbar
        createSearchbar()
        
        // Get the initial images, just some random.
        self.imageCollectionViewModel.loadImages(query: " ", location: nil ,completion: { () in
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        })
    }
        
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageCollectionViewModel.images.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImageCollectionViewCell
        
        // Get the image for the current indexPath, if not in cache, add to NSCache.
        imageCollectionViewModel.getImage(index: indexPath.item, completion: { (image) in
            cell.ImageView.image = image
        })
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.frame.size.width - 41) / 3
        let height = width
        return CGSize(width: width, height: height);
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Get the cell that was selected.
        let cell = collectionView.cellForItem(at: indexPath) as! ImageCollectionViewCell;
        
        // Create the ImageDetailViewModel, used in the prepare for seque.
        self.imageDetailViewModel = ImageDetailViewModel(imageDetail: self.imageCollectionViewModel.images[indexPath.item], imageData: cell.ImageView.image!)
        
        // Perform a navigation to the detail imageview.
        self.performSegue(withIdentifier: "ImageDetail", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ImageDetail" {
            if let vc = segue.destination as? ImageDetailViewController {
                vc.imageDetailViewModel = self.imageDetailViewModel
            }
        }
        
        if let mapViewController = segue.destination as? MapViewController {
             mapViewController.delegate = self
        }
    }
  
    func createSearchbar() {
        let searchBar = UISearchBar()
        searchBar.showsSearchResultsButton = true
        searchBar.keyboardType = UIKeyboardType.alphabet
        searchBar.placeholder = "Enter search here"
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
        
        //self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Map", style: UIBarButtonItemStyle.plain, target: self,action:#selector(addTapped(sender:)))
    }
    
    @objc func addTapped(sender: UIBarButtonItem) {
         self.performSegue(withIdentifier: "map", sender: self)
    }
}


// Extension for the SearchByLocation via map
extension ImageCollectionViewController: MapViewControllerDelegate{
    func mapViewLocation(location: CLLocationCoordinate2D) {
        self.imageCollectionViewModel.loadImages(query: nil, location: location) { () in
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }
}

// Extension for the searchbar, implement the delegate methods that is needed.
extension ImageCollectionViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText.count == 0){
            searchBar.showsCancelButton = false
        }else {
            searchBar.showsCancelButton = true
        }
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = nil
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.imageCollectionViewModel.loadImages(query: searchBar.text, location: nil) { () in
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
        searchBar.text = nil
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
    }
    
}

