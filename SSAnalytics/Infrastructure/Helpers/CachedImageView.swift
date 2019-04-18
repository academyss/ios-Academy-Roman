import Foundation
import UIKit
import SDWebImage
import STT

@objc
enum PlaceholderType: Int {
    case none
    case avatar
    case usual

    var name: String? {
        var imageName: String?

        switch self {
        case .avatar:
            imageName = "no_pic"
        case .usual:
            imageName = "placeholder"
        default: break
        }
        
        return imageName
    }
}

class CachedImageView: UIImageView {

    var imageData: Image? {
        didSet {
            if let imageUrl = imageData?.url {
                self.loadImage(url: imageUrl, placeholder: placeholderType)
            }
            else if let data = imageData?.data {
                self.image = UIImage(data: data)
            }
            else if let placeholderImage = placeholderType.name {
                self.image = UIImage.init(named: placeholderImage)
            }
        }
    }

    var placeholderType: PlaceholderType = .usual

}


extension SttBindingSet {

    func bind(_ context: CachedImageView) -> SttGenericBindingContext<TViewController, Image?> {

        return self.bind(Image?.self).forProperty({ context.imageData = $1 })
    }
}



extension CachedImageView {
    
    func loadImage(url: String?, placeholder: String?) {
        
        if let _url = url {
            self.sd_setImage(with: URL(string: _url), placeholderImage: UIImage(named: "placeholder"), completed: { (image: UIImage?, error: Error?, cacheType: SDImageCacheType, imageURL: URL?) in
                
                self.image = image
                
                if error != nil {
                    SttLog.error(message: "\(error!)", key: "SDWEBIMAGELOADER")
                    if self.placeholderType == .avatar
                    {
                        self.image = UIImage(named: "noUserAvatar")
                    }
                    else
                    {
                        self.image = UIImage(named: "placeholder")
                    }
                }
            })
        }
        else if let _placeholder = placeholder {
            self.image = UIImage(named: _placeholder)
        }
    }
    
    func loadImage(url: String?, placeholder: PlaceholderType) {
        
        self.loadImage(url: url, placeholder: placeholder == .none ? nil : placeholder.name )
        
    }
    
}
