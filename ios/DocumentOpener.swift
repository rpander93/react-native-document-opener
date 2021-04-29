import UIKit

@objc(DocumentOpener)
class DocumentOpener: NSObject, UIDocumentInteractionControllerDelegate {
    var documentController: UIDocumentInteractionController?
    
    @objc(openAsync:mimeType:resolve:reject:)
    func openAsync(_ filePath: String, mimeType: String?, resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) -> Void {
        documentController = UIDocumentInteractionController(url: URL.init(fileURLWithPath: filePath))
        documentController?.delegate = self
        
        DispatchQueue.main.async { [weak self] in
            if self?.documentController?.presentPreview(animated: true) == true {
                resolve(nil)
            } else {
                reject("EINVAL", "Document is not supported", nil)
            }
        }
    }
    
    @objc(presentOptionsAsync:resolve:reject:)
    func presentOptionsAsync(_ filePath: String, resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) -> Void {
        documentController = UIDocumentInteractionController(url: URL.init(fileURLWithPath: filePath))
        documentController?.delegate = self
                
        DispatchQueue.main.async { [weak self] in
            let rectangle = CGRect(x: 0, y: 0, width: 0, height: 0)
            let root = UIApplication.shared.delegate!.window!!.rootViewController!

            if self?.documentController?.presentOptionsMenu(from: rectangle, in: root.view, animated: true) == true {
                resolve(nil)
            } else {
                reject("EINVAL", "Document is not supported", nil)
            }
        }
    }
    
    // MARK: -UIDocumentInteractionControllerDelegate
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return UIApplication.shared.delegate!.window!!.rootViewController!
    }
    
    func documentInteractionControllerDidEndPreview(_ controller: UIDocumentInteractionController) {
        self.documentController = nil
    }
}
