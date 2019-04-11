import Foundation

struct Image {
    let data: Data?
    let url: String?
    
    var isEmpty: Bool {
        return data == nil && url == nil
    }
    
    init(data: Data? = nil, url: String? = nil) {
        self.data = data
        self.url = url
    }
    
}
