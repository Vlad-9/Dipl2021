

import UIKit

class AvBenTableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var rating: UILabel!
    
    var userbalance: Float = 0.0
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        selectedBackgroundView = backgroundView
        view.layer.cornerRadius=11.0
        price.layer.masksToBounds = true
        price.layer.cornerRadius = 11.0
     
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        contentView.backgroundColor = UIColor(red: 0, green: 114/255, blue: 230/255, alpha: 1)
        self.isHighlighted = selected
        super.setSelected(selected, animated: animated)
        
    }
}
