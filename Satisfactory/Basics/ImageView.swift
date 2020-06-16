import UIKit

class ImageView: UIImageView {
    override init(image: UIImage? = nil) {
        super.init(image: image)
        
        contentMode = .scaleAspectFit
        clipsToBounds = true
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
