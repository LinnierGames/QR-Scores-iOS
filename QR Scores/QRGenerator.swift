import Foundation
import UIKit

struct QRCoeGenerator {
    
    let url: URL
    
    private var image: UIImage?
    
    init(url: URL) {
        self.url = url
    }
    
    func generateImage(outputSize: CGSize = CGSize(width: 512, height: 512)) -> UIImage? {
        if let cachedImage = self.image {
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
        
        return UIImage(ciImage: transformedImage)
    }
}

