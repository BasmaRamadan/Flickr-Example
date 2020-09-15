//
//  PhotosVC.swift
//  Flickr
//
//  Created by Basma on 9/13/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit

class PhotosVC: UIViewController {

    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var noPhotosLbl: UILabel!
    
    lazy var viewModel: PhotosVM = PhotosVM ()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initVM()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    func initView () {
        collectionView.delegate = self
        collectionView.dataSource = self
        searchTF.addTarget(self, action: #selector(self.searchTFDidChange(_:)), for: .editingChanged)
    }
    func initVM() {

        viewModel.updateLoadingStatus = { () in
            DispatchQueue.main.async {
                switch self.viewModel.state {
                case .error:
                    self.indicator.stopAnimating()
                    self.collectionView.alpha = 0.0
                case .loading:
                    self.indicator.startAnimating()
                    self.indicator.alpha = 1.0
                    self.collectionView.alpha = 0.0
                    self.noPhotosLbl.alpha = 0.0
                case .loaded:
                    self.indicator.stopAnimating()
                    self.collectionView.alpha = 1.0
                case .noPhotos:
                    self.indicator.stopAnimating()
                    self.collectionView.alpha = 0.0
                    self.indicator.alpha = 0.0
                    self.noPhotosLbl.alpha = 1.0
                }
            }
        }
            viewModel.reloadCVClosure = { () in
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
            viewModel.getPhotos(isRecent: true, searchText: "")
        }
       
    
    @objc func searchTFDidChange(_ textField: UITextField) {
        if textField.text == "" {
            viewModel.getPhotos(isRecent: true, searchText: "")
        }else{
            viewModel.getPhotos(isRecent: false, searchText: textField.text ?? "")
        }
    }
    }

extension PhotosVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        let cellVM = viewModel.getCellVM( indexPath: indexPath )
        cell.photoCellViewModel = cellVM
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = viewModel.selectphoto(index: indexPath.row)
        openPhotoDetails (photo : photo)
    }
    func openPhotoDetails (photo : Photo) {
        let photoDetailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PhotoDetailsVC") as! PhotoDetailsVC
        photoDetailsVC.photo = photo
        self.navigationController?.pushViewController(photoDetailsVC, animated: true)
    }
    }
