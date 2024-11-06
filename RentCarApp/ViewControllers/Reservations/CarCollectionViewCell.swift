import UIKit

class CarCollectionViewCell: UICollectionViewCell {
    
    // UI Elements for the cell
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var carNameLabel: UILabel!
    @IBOutlet weak var carPriceLabel: UILabel!
    
    override func awakeFromNib() {
            super.awakeFromNib()
            
            // Configura el contenedor con bordes redondeados y sombra
            containerView.layer.cornerRadius = 10
            containerView.layer.masksToBounds = false
            containerView.layer.shadowColor = UIColor.black.cgColor
            containerView.layer.shadowOpacity = 0.2
            containerView.layer.shadowOffset = CGSize(width: 0, height: 1)
            containerView.layer.shadowRadius = 5
            containerView.backgroundColor = UIColor.systemGray5
            
            // Ajusta la imagen para que no se deforme
            carImageView.contentMode = .scaleAspectFit
        }
        
        func configure(with vehiculo: Vehiculo) {
            // Genera el nombre de la imagen en base a la marca y modelo
            let imageName = "\(vehiculo.marca ?? "")\(vehiculo.modelo ?? "")"
            
            // Intenta cargar la imagen desde los assets o usa una imagen predeterminada
            carImageView.image = UIImage(named: imageName) ?? UIImage(named: "defaultCarImage")
            
            // Configura las etiquetas
            carNameLabel.text = "\(vehiculo.marca ?? "") \(vehiculo.modelo ?? "") \(vehiculo.anio)"
            carPriceLabel.text = "S/ \(vehiculo.precioPorDia) por día"
        }
}
