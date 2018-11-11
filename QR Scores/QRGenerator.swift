import Foundation

struct QRCoeGenerator {

   private(set) let url: URL
   
   init(url: URL) {
      self.url = url
   }
   
   func generateImage() -> UIImage {
      let data = self.url.absolutePath.text.dataUsingEncoding(NSISOLatin1StringEncoding, allowLossyConversion: false)
 
        let filter = CIFilter(name: "CIQRCodeGenerator")
 
        filter.setValue(data, forKey: "inputMessage")
        filter.setValue("Q", forKey: "inputCorrectionLevel")
 
        return filter.outputImage
   }
}