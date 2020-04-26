//
//  FavouriteCell.swift
//  Play Time
//
//  Created by Brandon Gouws on 2020/04/26.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import Foundation
import UIKit
import PTFramework

class FavouriteCell: UITableViewCell {
    @IBOutlet weak var imgAlbumArt: UIImageView!
    @IBOutlet weak var lblTrackTitle: UILabel!
    @IBOutlet weak var lblTrackArtist: UILabel!
    func setFavCell(favTrack: FavTrack) {
        if let image = UIImage(urlString: favTrack.artworkUrl100) {
            DispatchQueue.main.async {
            self.imgAlbumArt.image = image
            self.lblTrackTitle.text = favTrack.trackTitle
            self.lblTrackArtist.text = favTrack.artistName
            }
        }
    }
}
