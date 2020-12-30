//
//  DirectoryViewController + Delegate.swift
//  FileKit
//
//  Created by Lukas Danckwerth on 21.03.20.
//  Copyright © 2020 Lukas Danckwerth. All rights reserved.
//

#if canImport(UIKit)
import UIKit.UITableView

public extension DirectoryViewController {
    
    // ===-----------------------------------------------------------------------------------------------------------===
    //
    // MARK: - Table View Delegate
    // ===-----------------------------------------------------------------------------------------------------------===
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let fileURL = contents?[indexPath.row]
        
        if fileURL?.hasDirectoryPath == true {
            let controller = DirectoryViewController(directory: directory)
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
        else if Constants.supportedTextfileExtensions.contains(where: { $0 == fileURL?.pathExtension }) {
            let sampleData = try? String(contentsOf: directory.url, encoding: .utf8)
            let controller = UITextViewController()
            controller.textView.text = sampleData
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
        else if Constants.supportedImageFileExtensions.contains(where: { $0 == fileURL?.pathExtension }) {
            let image = UIImage(url: directory.url)
            let controller = UIImageViewController(image: image)
            controller.title = directory.url.name
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return directory.url.name
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        guard let contents = self.contents else { return nil }
        if contents.isEmpty == true {
            return NSLocalizedString("Empty", comment: "Empty Directory Footer")
        } else if contents.count == 1 {
            return "\(contents.count) \(NSLocalizedString("File", comment: ""))"
        } else {
            return "\(contents.count) \(NSLocalizedString("Files", comment: ""))"
        }
    }
}
#endif
