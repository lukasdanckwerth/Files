//
//  DirectoryViewController.swift
//  UltraExpert-Go
//
//  Created by Lukas Danckwerth on 14.10.19.
//  Copyright © 2019 WinValue. All rights reserved.
//

#if canImport(UIKit)
import Foundation
import UIKit

public class DirectoryViewController: UITableViewController {
   
   open var activityIndicator: UIActivityIndicatorView = {
      if #available(iOS 13.0, *) {
         return UIActivityIndicatorView(style: .large)
      } else {
         return UIActivityIndicatorView(style: .gray)
      }
   }()
   
   /// A bar button item to dismiss this view controller.
   open var dismissButtonItem: UIBarButtonItem {
      return UIBarButtonItem(
         barButtonSystemItem: .done,
         target: self,
         action: #selector(dismissBarButtonAction)
      )
   }
   
   /// Selector for dismissing this view controller.
   @objc
   open func dismissBarButtonAction(sender: UIBarButtonItem?) {
      self.dismiss(animated: true)
   }
   
   
   
   // ===-----------------------------------------------------------------------------------------------------------===
   //
   // MARK: - Properties
   // ===-----------------------------------------------------------------------------------------------------------===
   
   public var directory: Directory
   
   public var contents: [URL]?
   
   public var sort: ((URL, URL) -> Bool) = {
      $0.name < $1.name
   }
   
   
   
   // ===-----------------------------------------------------------------------------------------------------------===
   //
   // MARK: - Initialization
   // ===-----------------------------------------------------------------------------------------------------------===
   
   public init(directory: Directory) {
      self.directory = directory
      if #available(iOS 13.0, *) {
         super.init(style: .insetGrouped)
      } else {
         super.init(style: .grouped)
      }
   }
   
   required public init() {
      self.directory = Directory(at: .home)
      if #available(iOS 13.0, *) {
         super.init(style: .insetGrouped)
      } else {
         super.init(style: .grouped)
      }
   }
   
   required public init?(coder aDecoder: NSCoder) {
      self.directory = Directory(at: .home)
      super.init(coder: aDecoder)
   }
   
   
   
   // ===-----------------------------------------------------------------------------------------------------------===
   //
   // MARK: - Override UIViewController
   // ===-----------------------------------------------------------------------------------------------------------===
   
   override public func viewDidLoad() {
      super.viewDidLoad()
      
      navigationItem.title = self.directory.name
      navigationItem.rightBarButtonItem = self.dismissButtonItem
      
      // table view
      self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "C0")
      
      
      // activity indicator
      self.activityIndicator.hidesWhenStopped = true
      self.activityIndicator.stopAnimating()
   }
   
   override public func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      self.contents = directory.contents.sorted(by: self.sort)
      self.tableView.reloadData()
   }
   
   override public func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      loadContents()
   }
   
   open func loadContents() {
      self.activityIndicator.startAnimating()
      DispatchQueue.global(qos: .background).async {
         self.contents = self.directory.contents
         DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
         }
      }
   }
   
   
   
   // ===-----------------------------------------------------------------------------------------------------------===
   //
   // MARK: - Constants
   // ===-----------------------------------------------------------------------------------------------------------===
   
   internal struct Patterns {
      static let supportedTextfileExtensions = [
         "txt",
         "log",
         "json",
         "plist"
      ]
      
      static let supportedImageFileExtensions = [
         "png",
         "jpg",
         "jpeg"
      ]
   }
}
#endif
