//
//  UITextViewController.swift
//  Files
//
//  Created by Lukas Danckwerth on 14.10.19.
//  Copyright © 2019 Lukas Danckwerth. All rights reserved.
//

#if canImport(UIKit)
import UIKit

class UITextViewController: UIViewController {
   
   let textView = UITextView()
   
   override func loadView() {
      self.view = textView
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      textView.font = UIFont.preferredFont(forTextStyle: .body)
   }
}
#endif
