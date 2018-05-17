import UIKit
import GooglePlaces

class selectUserAddressViewController: UIViewController
{
    @IBAction func backTap(_ sender: UIButton)
    {
        self.dismiss(animated: true, completion: nil)

    }
    
    var selectAddressStr: NSString!
    
    var addressInt: Int!
    
    var appDelegate = UIApplication.shared.delegate as! AppDelegate

    var resultsViewController: GMSAutocompleteResultsViewController?
    
    var searchController: UISearchController?
    
    var resultView: UITextView?
    
    //    var searchQuery: HNKGooglePlacesAutocompleteQuery?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //        searchTF.isHidden = false
        //        searchTableVIew.isHidden = false
        
        
        
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self as? GMSAutocompleteResultsViewControllerDelegate
        
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController
        
        
        let subView = UIView(frame: CGRect(x: 0, y: 60, width: self.view.frame.size.width, height: 45))
        subView.backgroundColor = UIColor.clear
        subView.addSubview((searchController?.searchBar)!)
        view.addSubview(subView)
        
        searchController?.searchBar.frame = (CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 45))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: (searchController?.searchBar)!)
        searchController?.searchBar.text = selectAddressStr as! String
        searchController?.searchBar .becomeFirstResponder()
        // When UISearchController presents the results view, present it in
        // this view controller, not one further up the chain.
        definesPresentationContext = true
        
        // Keep the navigation bar visible.
        searchController?.hidesNavigationBarDuringPresentation = false
        searchController?.modalPresentationStyle = .custom
        
        
        // Put the search bar in the navigation bar.
        searchController?.searchBar.sizeToFit()
        navigationItem.titleView = searchController?.searchBar
        
        // When UISearchController presents the results view, present it in
        // this view controller, not one further up the chain.
        definesPresentationContext = true
        
        // Prevent the navigation bar from being hidden when searching.
        searchController?.hidesNavigationBarDuringPresentation = false
        
        navigationController?.navigationBar.isTranslucent = false
        searchController?.hidesNavigationBarDuringPresentation = false
        
        // This makes the view area include the nav bar even though it is opaque.
        // Adjust the view placement down.
        self.extendedLayoutIncludesOpaqueBars = true
        self.edgesForExtendedLayout = .all
    }
    
    
    // Present the Autocomplete view controller when the button is pressed.
    @IBAction func autocompleteClicked(_ sender: UIButton)
    {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self as! GMSAutocompleteViewControllerDelegate
        present(autocompleteController, animated: true, completion: nil)
    }
    
    //    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    //    {
    //
    //        var str: NSString = (searchTF.text! as NSString).replacingCharacters(in: range, with: string) as NSString
    //
    ////        if (str.characters.count ?? 0) > 0
    ////        {
    //            searchTableVIew.isHidden = false
    //            searchQuery.fetchPlaces(forSearchQuery: str, completion: {(_ places: [Any], _ error: Error?) -> Void in
    //                if error != nil
    //                {
    //                    print("ERROR: \(error)")
    //                    try? self.handleSearchError()
    //                }
    //                else
    //                {
    //                    searchResults = places
    //                    print("\(searchResults)")
    //                    autocompleteTable.reloadData()
    //                }
    //            })
    ////        }
    ////        else
    ////        {
    ////            autocompleteTable.isHidden = true
    ////        }
    //        return true
    //    }
    
    
}

// Handle the user's selection.
extension selectUserAddressViewController: GMSAutocompleteResultsViewControllerDelegate
{
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didAutocompleteWith place: GMSPlace)
    {
        searchController?.isActive = false
        // Do something with the selected place.
        print("Place name: c(place.name)")
        print("Place address: \(place.formattedAddress)")
        print("Place attributions: \(place.attributions)")

        
        let lat: Double = place.coordinate.latitude
       
        let long: Double = place.coordinate.longitude


        if  addressInt == 1
        {
            appDelegate.oldPlaces = place


        }
        else if addressInt == 2
        
        {
            appDelegate.newPlaces = place
        }
            
        else
        
        {
            appDelegate.oldPlaces = place
        }
        print(appDelegate.oldLongitude)

        let appendString = place.formattedAddress!
        
        appDelegate.selectAddressStr? = appendString as NSString
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didFailAutocompleteWithError error: Error)
    {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController)
    {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController)
    {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}



extension selectUserAddressViewController: GMSAutocompleteViewControllerDelegate
{
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace)
    {
        print("Place name: \(place.name)")
        print("Place address: \(place.formattedAddress)")
        print("Place attributions: \(place.attributions)")
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error)
    {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController)
    {
        dismiss(animated: true, completion: nil)
    }
    
    //    // Turn the network activity indicator on and off again.
    //    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController)
    //    {
    //        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    //    }
    //
    //    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController)
    //    {
    //        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    //    }
    
}
