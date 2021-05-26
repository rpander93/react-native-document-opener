import UIKit

@objc(DocumentOpener)
class DocumentOpener: NSObject, UIDocumentInteractionControllerDelegate {
    @objc(openAsync:mimeType:resolve:reject:)
    func openAsync(_ filePath: String, mimeType: String?, resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) -> Void {
        let documentController = UIDocumentInteractionController(url: URL.init(fileURLWithPath: filePath))
        documentController.delegate = self

        DispatchQueue.main.async {
            if documentController.presentPreview(animated: true) {
                resolve(nil)
            } else {
                reject("EINVAL", "Document is not supported", nil)
            }
        }
    }

    @objc(presentOptionsAsync:resolve:reject:)
    func presentOptionsAsync(_ filePath: String, resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) -> Void {
        let documentController = UIDocumentInteractionController(url: URL.init(fileURLWithPath: filePath))
        documentController.delegate = self

        DispatchQueue.main.async {
            let rectangle = CGRect(x: 0, y: 0, width: 0, height: 0)
            let root = UIApplication.shared.delegate!.window!!.rootViewController!

            if documentController.presentOptionsMenu(from: rectangle, in: root.view, animated: true) {
                resolve(nil)
            } else {
                reject("EINVAL", "Document is not supported", nil)
            }
        }
    }

    // MARK: -UIDocumentInteractionControllerDelegate
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return RCTPresentedViewController()!
    }
}
