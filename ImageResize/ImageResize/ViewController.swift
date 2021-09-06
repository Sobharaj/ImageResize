//
//  ViewController.swift
//  ImageResize
//
//  Created by sobharaj mohapatra on 29/07/21.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    
    @IBOutlet private weak var bannerImageView: UIImageView!
    
    @IBOutlet private weak var layoutWidth: NSLayoutConstraint!
    
    @IBOutlet private weak var layoutHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadContent()
    }
    
    private func loadContent() {
        //https://i.picsum.photos/id/0/5616/3744.jpg?hmac=3GAAioiQziMGEtLbfrdbcoenXoWAW-zlyEAMkfEdBzQ
        guard let imageUrl = URL(string: "https://picsum.photos/id/1/900/300") else {
            return
        }
       
        // Download Image
        bannerImageView.kf.setImage(with: imageUrl, placeholder: nil, options: nil) { result in
            switch result {
            case .success(_):
                // Resize Image
                var newHeight = self.view.frame.height
                var newWidth = self.view.frame.width
                DispatchQueue.main.async {
                    if let image = self.bannerImageView.image {
                        if(image.size.width >= newWidth){
                            let ratio = image.size.width / image.size.height
                            newHeight = newWidth / ratio
                        }
                        else if(image.size.height >= newHeight) {
                            let ratio = image.size.height / image.size.width
                            newWidth = newHeight / ratio
                        } else{
                            newHeight = image.size.height
                            newWidth = image.size.width
                        }
                        
                        self.bannerImageView.frame.size = CGSize(width: newWidth, height: newHeight)
                        self.layoutHeight.constant = newHeight
                        self.layoutWidth.constant = newWidth
                    }
                }
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
}

