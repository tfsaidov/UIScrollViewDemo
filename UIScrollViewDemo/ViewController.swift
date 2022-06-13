//
//  ViewController.swift
//  UIScrollViewDemo
//
//  Created by Саидов Тимур on 07.06.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private var imageViews: [UIImageView] = []
    private let imageNames = ["first_image", "second_image", "third_image"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(self.scrollView)
        self.imageNames.forEach {
            let image = UIImage(named: $0)
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            self.imageViews.append(imageView)
            self.scrollView.addSubview(imageView)
        }
        
        let scrollViewConstraints = self.scrollViewConstraints()
        let imageViewsConstraints = self.imageViewsConstraints()
        NSLayoutConstraint.activate(
            scrollViewConstraints +
            imageViewsConstraints
        )
    }
    
    private func scrollViewConstraints() -> [NSLayoutConstraint] {
        let topAnchor = self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor)
        let leadingAnchor = self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailingAnchor = self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let bottomAnchor = self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        
        return [
            topAnchor, leadingAnchor, trailingAnchor, bottomAnchor
        ]
    }
    
    private func imageViewsConstraints() ->  [NSLayoutConstraint] {
        var imageViewsConstraints: [NSLayoutConstraint] = []
        
        for (index, imageView) in self.imageViews.enumerated() {
            let topAnchor = imageView.topAnchor.constraint(equalTo: self.scrollView.topAnchor)
            let bottomAnchor = imageView.topAnchor.constraint(equalTo: self.scrollView.bottomAnchor)
            let widthAnchor = imageView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor, multiplier: 1.0)
            let heightAnchor = imageView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor, multiplier: 1.0)
            imageViewsConstraints.append(topAnchor)
            imageViewsConstraints.append(bottomAnchor)
            imageViewsConstraints.append(widthAnchor)
            imageViewsConstraints.append(heightAnchor)
            
            if index == 0 {
                let leadingAnchor = imageView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor)
                let trailingAnchor = imageView.trailingAnchor.constraint(equalTo: self.imageViews[index + 1].leadingAnchor)
                imageViewsConstraints.append(leadingAnchor)
                imageViewsConstraints.append(trailingAnchor)
                continue
            }
            
            if index == self.imageViews.count - 1 {
                let leadingAnchor = imageView.leadingAnchor.constraint(equalTo: self.imageViews[index - 1].trailingAnchor)
                let trailingAnchor = imageView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor)
                imageViewsConstraints.append(leadingAnchor)
                imageViewsConstraints.append(trailingAnchor)
                continue
            }
            
            let leadingAnchor = imageView.leadingAnchor.constraint(equalTo: self.imageViews[index - 1].trailingAnchor)
            let trailingAnchor = imageView.trailingAnchor.constraint(equalTo: self.imageViews[index + 1].leadingAnchor)
            imageViewsConstraints.append(leadingAnchor)
            imageViewsConstraints.append(trailingAnchor)
        }
        
        return imageViewsConstraints
    }
}
