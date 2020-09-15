//
//  PhotosViewModel.swift
//  Flickr
//
//  Created by Basma on 9/13/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import Foundation

enum State {
    case loading
    case loaded
    case noPhotos
    case error
}
class PhotosVM {
    
    let apiService = PhotoRequest()
    private var photos: [Photo] = [Photo]()
    
    var reloadCVClosure: (()->())?
    var updateLoadingStatus: (()->())?
    
    private var cellVMs: [PhotoCellVM] = [PhotoCellVM]() {
        didSet {
            self.reloadCVClosure?()
        }
    }

    var state: State = .noPhotos {
        didSet {
            self.updateLoadingStatus?()
        }
    }
        
    var numberOfCells: Int {
        return cellVMs.count
    }
        
    func getPhotos(isRecent: Bool, searchText : String) {
        state = .loading
        apiService.requestPhotos(isRecent: isRecent, searchText: searchText, completion: {(photos) in
            if photos.count != 0 {
                
            }
            self.createCellsVMs(photos: photos)
            let isPhotos = (photos.count == 0) ? State.noPhotos : State.loaded
            self.state = isPhotos
            })
    }
        
    func getCellVM(indexPath: IndexPath) -> PhotoCellVM {
        return cellVMs[indexPath.row]
    }

    private func createCellsVMs(photos: [Photo]) {
        self.photos = photos
        var photoCellsViewModels = [PhotoCellVM]()
        for photo in photos {
            photoCellsViewModels.append(createCellViewModel(photo: photo))
        }
        self.cellVMs = photoCellsViewModels
    }
    private func createCellViewModel( photo: Photo ) -> PhotoCellVM {
        return PhotoCellVM(imageUrl : photo.imageURL(), title: photo.title ?? "No Title")
    }
    func selectphoto(index : Int) -> Photo{
        return photos[index]
    }
    }
