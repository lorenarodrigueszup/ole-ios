//
//  SearchCellViewModel.swift
//  LocadoraOleTraining
//
//  Created by Lorena Rodrigues Bruno on 27/11/18.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import Foundation

class SearchCellViewModel {
    
    var movies = [Film]()
    
    
    func configureCell(imageFilm : UIImageView, viewNote: UIView, viewBack: UIView, labelPrice: UILabel, viewYellPoint: UIView) {
        viewNote.layer.cornerRadius = 18
        viewYellPoint.layer.cornerRadius = 5
        viewBack.layer.cornerRadius = 5
        
        imageFilm.layer.cornerRadius = 5
        imageFilm.layer.masksToBounds = true
        
        labelPrice.layer.shadowRadius = 3.0
        labelPrice.layer.shadowOpacity = 0.6
        labelPrice.layer.shadowOffset = CGSize(width: 0, height: 5)
    }
    
    func setNoResultsInformation(noResultsLabel: UILabel, searchText: String) {
        Attributes.setAttributesLabel(label: noResultsLabel, labelText: "Sem resultados para '\(searchText)'", size: 14, fontFamily: "Roboto-Reglar", spaceLine: 1.4, textColor: UIColor.black)
    }
    
    
    
    func setFilmInformations(film: Film, labelFilmName: UILabel, labelFilmCategory: UILabel, labelFilmDuration: UILabel, labelFilmYear: UILabel, labelFilmSynopsis: UILabel, LabelFilmPrice: UILabel, labelNote: UILabel, imageFilm: UIImageView, iconFilm: UIImageView, buttonLike: UIButton, loadingImage: UIActivityIndicatorView) {
        
        imageFilm.isHidden = true
        loadingImage.startAnimating()
        guard let posterId = film.posterId else { return }
        guard let url = APIManager.shared.getImagePoster(id: posterId, size: "original") else { return }
        let request = URLRequest(url: url)
        imageFilm.setImageWith(request, placeholderImage: UIImage(named: "noImage"), success: { (request, response, image) in
            imageFilm.isHidden = false
            imageFilm.image = image
            loadingImage.isHidden = true
        }) { (request, response, error) in
            imageFilm.isHidden = false
            loadingImage.isHidden = true
        }

        
        labelFilmName.text = film.title
        labelFilmCategory.text = ValidateForm.arrayToString(array: film.genreNames)
        labelFilmDuration.text = film.runtime
        labelFilmYear.text = String(film.year)
        labelFilmSynopsis.text = film.overview
        LabelFilmPrice.text = "R$ " + String(film.price)
        labelNote.text = String(film.voteAverage)
        
        ValidateForm.checkFilmAcquired(acquired: film.acquired, labelPrice: LabelFilmPrice, imageAcquired: iconFilm)
        ValidateForm.checkFavorite(buttonLike: buttonLike, favorite: film.favorit)
        
    }
}
