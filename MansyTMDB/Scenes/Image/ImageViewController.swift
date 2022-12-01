//
//  ImageViewController.swift
//  MansyTMDB
//
//  Created by Ahmed Elmansy on 30/11/2022.
//

import UIKit

class ImageViewController: BaseViewController {
    
    static func instantiate(source: ImageSource) -> Self {
        let vc = instantiate()
        vc.source = source
        return vc
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    lazy var saveImageButton: UIBarButtonItem = {
        UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.down.fill"), style: .plain, target: self, action: #selector(saveImage))
    }()
    
    private var source: ImageSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        navigationItem.rightBarButtonItem = saveImageButton
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setImage()
    }
    
    private func setImage(){
        switch source{
        case .url(let data):
            imageView.setImage(url: data.absoluteString, config: .init(isDownsamplingEnabled: true))
        case .image(let data):
            imageView.image = data
        case .none:
            break
        }
    }
    
    private func setupUI(){
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 3.0
    }
    
}

//MARK: Allow zoom

extension ImageViewController: UIScrollViewDelegate{
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        imageView
    }
}

//MARK: Handling saving image to photo library

extension ImageViewController{
    
    @objc func saveImage() {
        guard let image = imageView.image else{return}
        showAlert(title: "Save Photo", body: "Are you sure you want to save this photo to your photos library?", actions: [
            .init(title: "Save", style: .default, handler: { _ in
                ImageSaver().writeToPhotoAlbum(image: image)
            }),
            .close
        ])
    }
    
}
