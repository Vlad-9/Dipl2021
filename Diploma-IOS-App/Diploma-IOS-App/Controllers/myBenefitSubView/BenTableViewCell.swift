

import UIKit

class BenTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var descr: UILabel!
    
    override func awakeFromNib() {

        super.awakeFromNib()

        selectedBackgroundView = backgroundView
        view.layer.cornerRadius=11.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {

        super.setSelected(selected, animated: animated)
        contentView.backgroundColor = UIColor(red: 0, green: 114/255, blue: 230/255, alpha: 1)
        self.isHighlighted = selected
        super.setSelected(selected, animated: animated)

    }
}
