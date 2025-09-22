//
//  SearchResultsTableViewController.swift
//  DiscoveryTestApp
//
//  Created by Jonathan Backer on 11/3/20.
//  Copyright © 2020 Ticketmaster. All rights reserved.
//

import UIKit
import TicketmasterFoundation
import TicketmasterDiscoveryAPI

class SearchResultsTableViewController: UITableViewController {
    
    enum DiscoveryResponse {
        case searchSuggest(results: DiscoverySuggestResponse)
        case eventSearch(results: ConnectionDriver.PaginatedResponse<DiscoveryEvent>, criteria: DiscoveryEventSearchCriteria)
        case venueSearch(results: ConnectionDriver.PaginatedResponse<DiscoveryVenue>, criteria: DiscoveryVenueSearchCriteria)
        case attractionSearch(results: ConnectionDriver.PaginatedResponse<DiscoveryAttraction>, criteria: DiscoveryAttractionSearchCriteria)
        case classificationSearch(results: ConnectionDriver.PaginatedResponse<DiscoveryClassification>, criteria: DiscoveryClassificationSearchCriteria)
    }
    
    var discoveryResponse: DiscoveryResponse!
    
    private var additionalEventSearchPages: [ConnectionDriver.PaginatedResponse<DiscoveryEvent>] = []
    private var additionalVenueSearchPages: [ConnectionDriver.PaginatedResponse<DiscoveryVenue>] = []
    private var additionalAttractionSearchPages: [ConnectionDriver.PaginatedResponse<DiscoveryAttraction>] = []
    private var additionalClassificationSearchPages: [ConnectionDriver.PaginatedResponse<DiscoveryClassification>] = []

    //override func viewDidLoad() {
        //super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    //}

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        switch discoveryResponse {
        case .searchSuggest:
            return 4
            
        case .eventSearch:
            return additionalEventSearchPages.count + 2
            
        case .venueSearch:
            return additionalVenueSearchPages.count + 2

        case .attractionSearch:
            return additionalAttractionSearchPages.count + 2

        case .classificationSearch:
            return additionalClassificationSearchPages.count + 2

        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch discoveryResponse {
        case .searchSuggest(let results):
            if section == 0 {
                return results.eventArray.count
            } else if section == 1 {
                return results.venueArray.count
            } else if section == 2 {
                return results.attractionArray.count
            } else if section == 3 {
                return results.productArray.count
            } else {
                return 0
            }
            
        case .eventSearch(let results, criteria: _):
            if section == 0 {
                return results.data.count
            } else {
                if section > additionalEventSearchPages.count {
                    // load more cell
                    return 1
                } else {
                    return additionalEventSearchPages[section - 1].data.count
                }
            }
            
        case .venueSearch(let results, criteria: _):
            if section == 0 {
                return results.data.count
            } else {
                if section > additionalVenueSearchPages.count {
                    // load more cell
                    return 1
                } else {
                    return additionalVenueSearchPages[section - 1].data.count
                }
            }
            
        case .attractionSearch(let results, criteria: _):
            if section == 0 {
                return results.data.count
            } else {
                if section > additionalAttractionSearchPages.count {
                    // load more cell
                    return 1
                } else {
                    return additionalAttractionSearchPages[section - 1].data.count
                }
            }
            
        case .classificationSearch(let results, criteria: _):
            if section == 0 {
                return results.data.count
            } else {
                if section > additionalClassificationSearchPages.count {
                    // load more cell
                    return 1
                } else {
                    return additionalClassificationSearchPages[section - 1].data.count
                }
            }
            
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch discoveryResponse {
        case .searchSuggest:
            if section == 0 {
                return "Events"
            } else if section == 1 {
                return "Venues"
            } else if section == 2 {
                return "Attractions"
            } else if section == 3 {
                return "Products"
            } else {
                return "?"
            }
            
        case .eventSearch(let results, criteria: _):
            if section == 0 {
                return "Page \(results.pageNumber + 1) of \(results.pageCount)"
            } else {
                if section > additionalEventSearchPages.count {
                    // load more
                    return nil
                } else {
                    return "Page \(additionalEventSearchPages[section - 1].pageNumber + 1) of \(results.pageCount)"
                }
            }
            
        case .venueSearch(let results, criteria: _):
            if section == 0 {
                return "Page \(results.pageNumber + 1) of \(results.pageCount)"
            } else {
                if section > additionalVenueSearchPages.count {
                    // load more
                    return nil
                } else {
                    return "Page \(additionalVenueSearchPages[section - 1].pageNumber + 1) of \(results.pageCount)"
                }
            }
            
        case .attractionSearch(let results, criteria: _):
            if section == 0 {
                return "Page \(results.pageNumber + 1) of \(results.pageCount)"
            } else {
                if section > additionalAttractionSearchPages.count {
                    // load more
                    return nil
                } else {
                    return "Page \(additionalAttractionSearchPages[section - 1].pageNumber + 1) of \(results.pageCount)"
                }
            }
            
        case .classificationSearch(let results, criteria: _):
            if section == 0 {
                return "Page \(results.pageNumber + 1) of \(results.pageCount)"
            } else {
                if section > additionalClassificationSearchPages.count {
                    // load more
                    return nil
                } else {
                    return "Page \(additionalClassificationSearchPages[section - 1].pageNumber + 1) of \(results.pageCount)"
                }
            }
            
        default:
            return nil
        }
    }
    
    // MARK: Navigation
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let result = resultSelected(forIndexPath: indexPath) else { return }
        
        guard let discoveryHelper = ConfigurationManager.shared.discoveryHelper else { return }
        
        switch discoveryResponse {
        case .searchSuggest:
            if indexPath.section == 0 {
                discoveryHelper.eventDetails(result.event!.eventIdentifier.rawValue, type: .discovery, onNavigationController: navigationController!)
            } else if indexPath.section == 1 {
                discoveryHelper.venueDetails(result.venue!.venueIdentifier.rawValue, type: .discovery, onNavigationController: navigationController!)
            } else if indexPath.section == 2 {
                discoveryHelper.attractionDetails(result.attraction!.attractionIdentifier.rawValue, type: .discovery, onNavigationController: navigationController!)
            } else if indexPath.section == 3 {
                // Product Details?
                return
            } else {
                return
            }
            
        case .eventSearch:
            discoveryHelper.eventDetails(result.event!.eventIdentifier.rawValue, type: .discovery, onNavigationController: navigationController!)
            
        case .venueSearch:
            discoveryHelper.venueDetails(result.venue!.venueIdentifier.rawValue, type: .discovery, onNavigationController: navigationController!)
            
        case .attractionSearch:
            discoveryHelper.attractionDetails(result.attraction!.attractionIdentifier.rawValue, type: .discovery, onNavigationController: navigationController!)
            
        case .classificationSearch:
            if let identifier = result.classification?.mostSpecificItemIdentifier?.rawValue {
                discoveryHelper.classificationDetails(identifier, type: .discovery, onNavigationController: navigationController!)
            }
            
        default:
            // do nothing
            break
        }
    }
     
    
    // MARK: Configure UITableViewCells

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        if let oldCell = tableView.dequeueReusableCell(withIdentifier: "searchResults") {
            cell = oldCell
        } else {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "searchResults")
            cell.accessoryType = .disclosureIndicator
        }
        
        let result = resultSelected(forIndexPath: indexPath)

        // Configure the cell...
        switch discoveryResponse {
        case .searchSuggest:
            if indexPath.section == 0 {
                configure(cell, forEvent: result?.event)
            } else if indexPath.section == 1 {
                configure(cell, forVenue: result?.venue)
            } else if indexPath.section == 2 {
                configure(cell, forAttraction: result?.attraction)
            } else if indexPath.section == 3 {
                configure(cell, forProduct: result?.product)
            } else {
                configure(cell, forEvent: nil)
            }
            
        case .eventSearch(let results, criteria: _):
            if indexPath.section == 0 {
                configure(cell, forEvent: result?.event)
            } else {
                if indexPath.section > additionalEventSearchPages.count {
                    if additionalEventSearchPages.count < results.pageCount - 1 {
                        configure(cell, forLoadNextPage: additionalEventSearchPages.count + 2, of: results.pageCount)
                        // the fact the UITableView is asking for this cell means that it's time to load the next page
                        loadNextPage()
                    } else {
                        // no more pages to load
                        configure(cell, forLoadNextPage: nil, of: results.pageCount)
                    }
                } else {
                    configure(cell, forEvent: result?.event)
                }
            }
            
        case .venueSearch(let results, criteria: _):
            if indexPath.section == 0 {
                configure(cell, forVenue: result?.venue)
            } else {
                if indexPath.section > additionalVenueSearchPages.count {
                    if additionalVenueSearchPages.count < results.pageCount - 1 {
                        configure(cell, forLoadNextPage: additionalVenueSearchPages.count + 2, of: results.pageCount)
                        // the fact the UITableView is asking for this cell means that it's time to load the next page
                        loadNextPage()
                    } else {
                        // no more pages to load
                        configure(cell, forLoadNextPage: nil, of: results.pageCount)
                    }
                } else {
                    configure(cell, forVenue: result?.venue)
                }
            }
            
        case .attractionSearch(let results, criteria: _):
            if indexPath.section == 0 {
                configure(cell, forAttraction: result?.attraction)
            } else {
                if indexPath.section > additionalAttractionSearchPages.count {
                    if additionalAttractionSearchPages.count < results.pageCount - 1 {
                        configure(cell, forLoadNextPage: additionalAttractionSearchPages.count + 2, of: results.pageCount)
                        // the fact the UITableView is asking for this cell means that it's time to load the next page
                        loadNextPage()
                    } else {
                        // no more pages to load
                        configure(cell, forLoadNextPage: nil, of: results.pageCount)
                    }
                } else {
                    configure(cell, forAttraction: result?.attraction)
                }
            }
            
        case .classificationSearch(let results, criteria: _):
            if indexPath.section == 0 {
                configure(cell, forClassification: result?.classification)
            } else {
                if indexPath.section > additionalAttractionSearchPages.count {
                    if additionalAttractionSearchPages.count < results.pageCount - 1 {
                        configure(cell, forLoadNextPage: additionalAttractionSearchPages.count + 2, of: results.pageCount)
                        // the fact the UITableView is asking for this cell means that it's time to load the next page
                        loadNextPage()
                    } else {
                        // no more pages to load
                        configure(cell, forLoadNextPage: nil, of: results.pageCount)
                    }
                } else {
                    configure(cell, forAttraction: result?.attraction)
                }
            }
            
        default:
            configure(cell, forEvent: nil)
        }

        return cell
    }
    
    func configure(_ cell: UITableViewCell, forEvent event: DiscoveryEvent?) {
        if let event = event {
            if let venueName = event.venueArray.first?.name {
                cell.textLabel?.text = "\(event.name) @ \(venueName)"
            } else {
                cell.textLabel?.text = "\(event.name)"
            }
            if let legacyID = event.legacyEventIdentifier {
                if let startDate = event.startDates.first {
                    cell.detailTextLabel?.text = "\(event.eventIdentifier.rawValue) (\(legacyID.rawValue)) \(startDate.description)"
                } else {
                    cell.detailTextLabel?.text = "\(event.eventIdentifier.rawValue) (\(legacyID.rawValue))"
                }
            } else {
                if let startDate = event.startDates.first {
                    cell.detailTextLabel?.text = "\(event.eventIdentifier.rawValue) \(startDate.description)"
                } else {
                    cell.detailTextLabel?.text = "\(event.eventIdentifier.rawValue)"
                }
            }
        } else {
            cell.textLabel?.text = nil
            cell.detailTextLabel?.text = nil
        }
    }
    
    func configure(_ cell: UITableViewCell, forVenue venue: DiscoveryVenue?) {
        if let venue = venue {
            cell.textLabel?.text = venue.name
            if let legacyID = venue.legacyVenueIdentifier {
                cell.detailTextLabel?.text = "\(venue.venueIdentifier.rawValue) (\(legacyID.rawValue))"
            } else {
                cell.detailTextLabel?.text = "\(venue.venueIdentifier.rawValue)"
            }
        } else {
            cell.textLabel?.text = nil
            cell.detailTextLabel?.text = nil
        }
    }
    
    func configure(_ cell: UITableViewCell, forAttraction attraction: DiscoveryAttraction?) {
        if let attraction = attraction {
            cell.textLabel?.text = attraction.name
            if let legacyID = attraction.legacyAttractionIdentifier {
                cell.detailTextLabel?.text = "\(attraction.attractionIdentifier.rawValue) (\(legacyID.rawValue))"
            } else {
                cell.detailTextLabel?.text = "\(attraction.attractionIdentifier.rawValue)"
            }
        } else {
            cell.textLabel?.text = nil
            cell.detailTextLabel?.text = nil
        }
    }
    
    func configure(_ cell: UITableViewCell, forProduct product: DiscoveryProduct?) {
        if let product = product {
            cell.textLabel?.text = product.name
            if let legacyID = product.legacyProductIdentifier {
                cell.detailTextLabel?.text = "\(product.productIdentifier.rawValue) (\(legacyID.rawValue))"
            } else {
                cell.detailTextLabel?.text = "\(product.productIdentifier.rawValue)"
            }
        } else {
            cell.textLabel?.text = nil
            cell.detailTextLabel?.text = nil
        }
    }
    
    func configure(_ cell: UITableViewCell, forClassification classification: DiscoveryClassification?) {
        if let classification = classification {
            cell.textLabel?.text = classification.description
            if let identifier = classification.mostSpecificItemIdentifier {
                cell.detailTextLabel?.text = "\(identifier.rawValue)"
            } else {
                cell.detailTextLabel?.text = nil
            }
        } else {
            cell.textLabel?.text = nil
            cell.detailTextLabel?.text = nil
        }
    }
    
    func configure(_ cell: UITableViewCell, forLoadNextPage nextPage: Int?, of totalPages: Int?) {
        if let nextPage = nextPage {
            if let totalPages = totalPages {
                cell.textLabel?.text = "Loading Next Page (Page \(nextPage) of \(totalPages))..."
            } else {
                cell.textLabel?.text = "Loading Next Page (Page \(nextPage))..."
            }
        } else {
            if let totalPages = totalPages {
                cell.textLabel?.text = "Last Page Reached (Page \(totalPages) of \(totalPages))"
            } else {
                cell.textLabel?.text = "Last Page Reached"
            }
        }
        cell.detailTextLabel?.text = nil
    }
        
    // MARK: Next Page Load
    
    func loadNextPage() {
        guard let discoveryService = TMDiscoveryAPI.shared.discoveryService else {
            print("Missing DiscoveryService, probably did not call TMDiscoveryAPI.shared.configure(...)")
            return
        }
        
        switch discoveryResponse {
        case .searchSuggest:
            // do nothing
            break
            
        case .eventSearch(let results, let criteria):
            if additionalEventSearchPages.count < results.pageCount - 1 {
                var newCriteria = criteria
                newCriteria.currentPage = additionalEventSearchPages.count + 1
                
                discoveryService.eventSearch(newCriteria) { response in
                    switch response {
                    case .success(let newResults):
                        DispatchQueue.main.async {
                            self.additionalEventSearchPages.append(newResults)
                            self.tableView.reloadData()
                        }
                    case .failure(let error):
                        print("Event Search Error: \(error.localizedDescription)")
                    }
                }
            }
            
        case .venueSearch(let results, let criteria):
            if additionalVenueSearchPages.count < results.pageCount - 1 {
                var newCriteria = criteria
                newCriteria.currentPage = additionalVenueSearchPages.count + 1
                
                discoveryService.venueSearch(newCriteria) { response in
                    switch response {
                    case .success(let newResults):
                        DispatchQueue.main.async {
                            self.additionalVenueSearchPages.append(newResults)
                            self.tableView.reloadData()
                        }
                    case .failure(let error):
                        print("Venue Search Error: \(error.localizedDescription)")
                    }
                }
            }
            
        case .attractionSearch(let results, let criteria):
            if additionalAttractionSearchPages.count < results.pageCount - 1 {
                var newCriteria = criteria
                newCriteria.currentPage = additionalAttractionSearchPages.count + 1
                
                discoveryService.attractionSearch(newCriteria) { response in
                    switch response {
                    case .success(let newResults):
                        DispatchQueue.main.async {
                            self.additionalAttractionSearchPages.append(newResults)
                            self.tableView.reloadData()
                        }
                    case .failure(let error):
                        print("Attraction Search Error: \(error.localizedDescription)")
                    }
                }
            }
            
        case .classificationSearch(let results, let criteria):
            if additionalClassificationSearchPages.count < results.pageCount - 1 {
                var newCriteria = criteria
                newCriteria.currentPage = additionalClassificationSearchPages.count + 1
                
                discoveryService.classificationSearch(newCriteria) { response in
                    switch response {
                    case .success(let newResults):
                        DispatchQueue.main.async {
                            self.additionalClassificationSearchPages.append(newResults)
                            self.tableView.reloadData()
                        }
                    case .failure(let error):
                        print("Classification Search Error: \(error.localizedDescription)")
                    }
                }
            }
            
        default:
            // do nothing
            break
        }
    }
    
    func resultSelected(forIndexPath indexPath: IndexPath) -> SearchResultSelected? {
        let result: SearchResultSelected = SearchResultSelected()
        
        switch discoveryResponse {
        case .searchSuggest(let results):
            if indexPath.section == 0 {
                result.event = results.eventArray[indexPath.row]
            } else if indexPath.section == 1 {
                result.venue = results.venueArray[indexPath.row]
            } else if indexPath.section == 2 {
                result.attraction = results.attractionArray[indexPath.row]
            } else if indexPath.section == 3 {
                result.product = results.productArray[indexPath.row]
            } else {
                return nil
            }
            
        case .eventSearch(let results, criteria: _):
            if indexPath.section == 0 {
                result.event = results.data[indexPath.row]
            } else {
                if indexPath.section > additionalEventSearchPages.count {
                    return nil
                } else {
                    result.event = additionalEventSearchPages[indexPath.section - 1].data[indexPath.row]
                }
            }
            
        case .venueSearch(let results, criteria: _):
            if indexPath.section == 0 {
                result.venue = results.data[indexPath.row]
            } else {
                if indexPath.section > additionalVenueSearchPages.count {
                    return nil
                } else {
                    result.venue = additionalVenueSearchPages[indexPath.section - 1].data[indexPath.row]
                }
            }
            
        case .attractionSearch(let results, criteria: _):
            if indexPath.section == 0 {
                result.attraction = results.data[indexPath.row]
            } else {
                if indexPath.section > additionalAttractionSearchPages.count {
                    return nil
                } else {
                    result.attraction = additionalAttractionSearchPages[indexPath.section - 1].data[indexPath.row]
                }
            }
            
        case .classificationSearch(let results, criteria: _):
            if indexPath.section == 0 {
                result.classification = results.data[indexPath.row]
            } else {
                if indexPath.section > additionalAttractionSearchPages.count {
                    return nil
                } else {
                    result.attraction = additionalAttractionSearchPages[indexPath.section - 1].data[indexPath.row]
                }
            }
            
        default:
            return nil
        }
        
        return result
    }
    
    class SearchResultSelected {
        var event: DiscoveryEvent?
        var venue: DiscoveryVenue?
        var attraction: DiscoveryAttraction?
        
        var product: DiscoveryProduct?
        var classification: DiscoveryClassification?
    }
}
