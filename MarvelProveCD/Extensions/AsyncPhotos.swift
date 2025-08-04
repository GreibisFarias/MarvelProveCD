//
//  AsyncPhotos.swift
//  MarvelProveCD
//
//  Created by Greibis Farias on 8/3/25.
//
import Foundation
import UIKit

extension UIImageView {
    func loadImageRemote(url: URL) {
        // Usa URLSession para hacer la petición de forma asíncrona
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            // 1. Verifica si hubo un error en la petición
            if let error = error {
                print("Error al descargar la imagen: \(error.localizedDescription)")
                return
            }

            // 2. Verifica si se recibieron datos
            guard let data = data else {
                print("Error: No se recibieron datos de imagen.")
                return
            }

            // 3. Intenta crear la imagen desde los datos
            guard let imagen = UIImage(data: data) else {
                print("Error: Los datos recibidos no son una imagen válida.")
                return
            }

            // 4. Actualiza la UI en el hilo principal
            DispatchQueue.main.async {
                self?.image = imagen
            }
        }
        
        // Inicia la tarea de descarga
        task.resume()
    }
}
