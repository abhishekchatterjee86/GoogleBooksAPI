//
//  ViewController.swift
//  ListGoogleBooks
//
//  Created by Abhishek Chatterjee on 23/12/17.
//  Copyright © 2017 Abhishek Chatterjee. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var allBooks: [Book] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.estimatedRowHeight = 68.0
        self.tableView.rowHeight = UITableViewAutomaticDimension

        self.fetchList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Fetch Books
    func fetchList() {
        let session = URLSession.shared
        let client = GoogleBooksApiClient(session: session)

        let req = GoogleBooksApi.VolumeRequest.List(query: "Cormen")
        let task: URLSessionDataTask = client.invoke(
            req,
            onSuccess: { volumes in 
                self.allBooks = volumes.items
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
        },
            onError: { error in NSLog("\(error)") }
        )
        task.resume()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allBooks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! BooksTableViewCell

        let volume = self.allBooks[indexPath.row]

        cell.bookTitle.text = volume.volumeInfo.title

        cell.bookAuthor.text = volume.volumeInfo.authors.joined(separator: ",")

        return cell
    }
}

