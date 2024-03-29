//
//  DirectoryViewController + DataSource.swift
//  Files
//
//  Created by Lukas Danckwerth on 21.03.20.
//  Copyright © 2020 Lukas Danckwerth. All rights reserved.
//

#if canImport(UIKit)
import UIKit.UITableView

public extension DirectoryViewController {
   
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return contents?.count ?? 0
   }
   
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
      guard let file = contents?[indexPath.row] else { return cell }
      
      if file.hasDirectoryPath {
         if #available(iOS 13.0, *) {
            cell.imageView?.image = UIImage(systemName: "folder")
         }
         cell.accessoryType = .disclosureIndicator
         cell.selectionStyle = .default
      } else if Constants.supportedTextfileExtensions.contains(where: { $0 == file.pathExtension }) {
         if #available(iOS 13.0, *) {
            cell.imageView?.image = UIImage(systemName: "doc")
         }
         cell.accessoryType = .disclosureIndicator
         cell.selectionStyle = .default
      } else if Constants.supportedImageFileExtensions.contains(where: { $0 == file.pathExtension }) {
         if #available(iOS 13.0, *) {
            cell.imageView?.image = UIImage(systemName: "photo")
         }
         cell.accessoryType = .disclosureIndicator
         cell.selectionStyle = .default
      } else {
         if #available(iOS 13.0, *) {
            cell.imageView?.image = UIImage(systemName: "doc")
         }
         cell.accessoryType = .none
         cell.selectionStyle = .none
      }
      
      cell.textLabel?.text = directory.name
      cell.detailTextLabel?.text = directory.formattedSize
      
      return cell
   }
}
#endif
