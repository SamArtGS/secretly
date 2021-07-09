//
//  PostCollectionViewCell.swift
//  Secretly
//
//  Created by Luis Ezcurdia on 28/05/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import UIKit

protocol goCommentDelegate: AnyObject{
    func goComment(post: Post)
}

class PostCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "feedPostCell"
    
    weak var delegate:goCommentDelegate?
    
    var post: Post? {
        didSet {
           updateView()
        }
    }
    
    @IBOutlet weak var authorView: AuthorView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var likeState: UIImageView!
    @IBOutlet var commentButton: UIButton!
    
    @IBAction func onCommentPressed(_ sender: UIButton) {
        guard let unwrapPost = post else { return }
        delegate?.goComment(post: unwrapPost)
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateCountedLikes(numLikes:Int){
        commentButton.setTitle("\(numLikes)", for: .normal)
    }
    
    func updateView() {
        guard let post = post else { return }
        if let color = UIColor(hex: post.backgroundColor) {
            self.imageView.backgroundColor = color
        }
        self.contentLabel.text = post.content
        if let postImg = post.image {
            ImageLoader.load(postImg.mediumUrl) { img in self.imageView.image = img }
        }
        self.authorView.author = post.user
    }
}
