//
//  UIImageViewController.swift
//  Files
//
//  Created by Lukas Danckwerth on 09.12.17.
//

#if canImport(UIKit)
import UIKit

public class UIImageViewController: UIViewController {
    
    // MARK: - Properties
    
    /// The underlying image view of this image view controller.
    ///
    open lazy var imageView = UIImageView()
    
    // MARK: - Initialization
    
    /// Initialization with given image.
    ///
    init(image: UIImage?) {
        super.init(nibName: nil, bundle: nil)
        imageView.image = image
    }
    
    /// Initialization from storyboard.
    ///
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /// Initialization from given image name.
    ///
    convenience init(imageName name: String?) {
        self.init(image: name != nil ? UIImage(named: name!) : nil)
    }
    
    // MARK: - Override UIViewController
    
    public override func loadView() {
        imageView.alpha = 0
        imageView.contentMode = .scaleAspectFill
        view = imageView
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        alphaAnimation(to: 1)
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        alphaAnimation(to: 0)
    }
    
    private func alphaAnimation(to alpha: CGFloat) {
        
        guard imageView.alpha != alpha else { return }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.imageView.alpha = alpha
        })
    }
}
#endif
