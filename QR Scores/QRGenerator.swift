import Foundation
import UIKit

struct QRCodeGenerator {
    
    let url: URL
    
    private(set) var cachedImage: UIImage?
    
    init(url: URL) {
        self.url = url
    }
    
    mutating func generateImage(outputSize: CGSize = CGSize(width: 512, height: 512)) -> UIImage? {
        if let cachedImage = self.cachedImage {
            return cachedImage
        }
        
        let data = self.url.absoluteString.data(using: String.Encoding.isoLatin1, allowLossyConversion: false)
        
        guard let filter = CIFilter(name: "CIQRCodeGenerator") else {
            return nil
        }
        
        filter.setValue(data, forKey: "inputMessage")
        filter.setValue("Q", forKey: "inputCorrectionLevel")
        
        guard let ciImage = filter.outputImage else {
            return nil
        }
        
        let scaleX = outputSize.width / ciImage.extent.size.width
        let scaleY = outputSize.height / ciImage.extent.size.height
        
        let transformedImage = ciImage.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))
        let qrCodeImage = UIImage(ciImage: transformedImage)

        //cache the image
        self.cachedImage = qrCodeImage
        
        return qrCodeImage
    }
}

