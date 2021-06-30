import UIKit

class HomeViewController: UIViewController
{
    @IBOutlet weak var nowPlayingCollectionView: UICollectionView!
    @IBOutlet weak var popularCollectionView: UICollectionView!
    @IBOutlet weak var upcomingCollectionView: UICollectionView!
    @IBOutlet weak var topRatedCollectionView: UICollectionView!
    
    var movieArray = [NSDictionary]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        nowPlayingApi()
        popularApi()
        upcomingApi()
        topRatedApi()
    }
    
    @IBAction func searchPress(_ sender: UIButton)
    {
        let vc = storyboard?.instantiateViewController(identifier: "SearchViewController") as! SearchViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    func nowPlayingApi()
    {
        URLSession.shared.dataTask(with: URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=788d5300cc78eb044c2a777e9852e841")!) { data, response, error in
            if let error = error
            {
                print("Error: \(error.localizedDescription)")
                return
            }
            if let data = data
            {
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! NSDictionary
                    let response = jsonResponse.value(forKey: "results") as! [NSDictionary]
                    self.movieArray = response
                    DispatchQueue.main.async
                    {
                        self.nowPlayingCollectionView.reloadData()
                    }
                } catch {
                    print("Exception Here")
                }
            }
        }.resume()
    }
    
    func popularApi()
    {
        URLSession.shared.dataTask(with: URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=788d5300cc78eb044c2a777e9852e841")!) { data, response, error in
            if let error = error
            {
                print("Error: \(error.localizedDescription)")
                return
            }
            if let data = data
            {
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! NSDictionary
                    let response = jsonResponse.value(forKey: "results") as! [NSDictionary]
                    self.movieArray = response
                    DispatchQueue.main.async
                    {
                        self.popularCollectionView.reloadData()
                    }
                } catch {
                    print("Exception Here")
                }
            }
        }.resume()
    }
    
    func upcomingApi()
    {
        URLSession.shared.dataTask(with: URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=788d5300cc78eb044c2a777e9852e841")!) { data, response, error in
            if let error = error
            {
                print("Error: \(error.localizedDescription)")
                return
            }
            if let data = data
            {
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! NSDictionary
                    let response = jsonResponse.value(forKey: "results") as! [NSDictionary]
                    self.movieArray = response
                    DispatchQueue.main.async
                    {
                        self.upcomingCollectionView.reloadData()
                    }
                } catch {
                    print("Exception Here")
                }
            }
        }.resume()
    }
    
    func topRatedApi()
    {
        URLSession.shared.dataTask(with: URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=788d5300cc78eb044c2a777e9852e841")!) { data, response, error in
            if let error = error
            {
                print("Error: \(error.localizedDescription)")
                return
            }
            if let data = data
            {
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! NSDictionary
                    let response = jsonResponse.value(forKey: "results") as! [NSDictionary]
                    self.movieArray = response
                    DispatchQueue.main.async
                    {
                        self.topRatedCollectionView.reloadData()
                    }
                } catch {
                    print("Exception Here")
                }
            }
        }.resume()
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return movieArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if collectionView == nowPlayingCollectionView
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NowPlayingCollectionViewCell", for: indexPath) as! NowPlayingCollectionViewCell
            return cell
        }
        if collectionView == popularCollectionView
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularCollectionViewCell", for: indexPath) as! PopularCollectionViewCell
            return cell
        }
        if collectionView == upcomingCollectionView
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpcomingCollectionViewCell", for: indexPath) as! UpcomingCollectionViewCell
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopRatedCollectionViewCell", for: indexPath) as! TopRatedCollectionViewCell
        return cell
    }
}
