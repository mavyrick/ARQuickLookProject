//
//  NewsFeedTableViewCell.swift
//  TetaviAssignment
//
//  Created by Josh Sorokin on 01/07/2021.
//

import UIKit

class NewsFeedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var newsFeedItemImage: UIImageView!
    @IBOutlet weak var addGraphicButton: UIButton!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var isAnimatedImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var newsFeedItem: NewsFeedItem? {
        didSet {
            updateUI()
        }
    }
    
    var downloaded = false {
        didSet {
            updateUIDownloaded()
        }
    }
    
    let likeGraphicService: LikeGraphicServiceProtocol = FirebaseLikeGraphicService()
    
    let addGraphicService: AddGraphicServiceProtocol = FirebaseAddGraphicService()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        if let newsFeedItem = newsFeedItem {
            addGraphicService.addGraphic(newsFeedItem: newsFeedItem, completion: { () -> Void in
                DispatchQueue.main.async {
                    self.addGraphicButton.setImage(UIImage(named: "done"), for: .normal)
                    self.addGraphicButton.isUserInteractionEnabled = false;
                }
            })
        }
    }
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        likeGraphicService.likeGraphic(id: newsFeedItem?.id ?? "")
    }
    
    func updateUI() {
        newsFeedItemImage.image = UIImage(named: newsFeedItem?.modelImageName ?? "placeholder")
        likesLabel.text = "\(newsFeedItem?.likes ?? 0)"
        titleLabel.text = "\(newsFeedItem?.title ?? "")"
        isAnimatedImage.isHidden = !(newsFeedItem?.animated ?? false)
        
    }
    
    func updateUIDownloaded() {
        if (downloaded == true) {
            self.addGraphicButton.setImage(UIImage(named: "done"), for: .normal)
            self.addGraphicButton.isUserInteractionEnabled = false;
        } else {
            self.addGraphicButton.setImage(UIImage(named: "add"), for: .normal)
            self.addGraphicButton.isUserInteractionEnabled = true;
        }
    }
    
}
