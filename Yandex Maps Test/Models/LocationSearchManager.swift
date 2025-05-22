//
//  LocationSearchManager.swift
//  Yandex Maps Test
//
//  Created by Abdulloh Murodilloyev on 22/02/25.
//

import YandexMapsMobile

class LocationSearchManager {
    static let shared = LocationSearchManager()
    private var searchSession: YMKSearchSession?
    private let searchManager = YMKSearchFactory.instance().createSearchManager(with: .combined)

    // MARK: - Search by Point
    func searchByPoint(_ point: YMKPoint, completion: @escaping (SearchResult?) -> Void) {
        let options = YMKSearchOptions()
        options.resultPageSize = 10

        searchSession = searchManager.submit(
            with: point,
            zoom: 18,
            searchOptions: options
        ) { response, error in
            if let error = error {
                print("Search error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let results = response?.collection.children.compactMap({ $0.obj }),
                  let firstResult = results.first,
                  let resultPoint = firstResult.geometry.first?.point else {
                completion(nil)
                return
            }

            let result = SearchResult(
                name: firstResult.name ?? "Noma'lum joy",
                address: firstResult.descriptionText ?? "Manzil mavjud emas",
                latitude: resultPoint.latitude,
                longitude: resultPoint.longitude,
                distance: DistanceCalculator.calculateDistance(to: point)
            )

            completion(result)
        }
    }

    // MARK: - Search by Text
    func searchByText(_ query: String, completion: @escaping ([SearchResult]) -> Void) {
        let searchOptions = YMKSearchOptions()

        let boundingBox = YMKBoundingBox(
               southWest: YMKPoint(latitude: 41.0, longitude: 68.5),
               northEast: YMKPoint(latitude: 41.5, longitude: 69.5)
           )

        searchSession = searchManager.submit(
            withText: query,
            geometry: YMKGeometry(boundingBox: boundingBox),
            searchOptions: searchOptions
        ) { response, error in
            if let error = error {
                print("Search error: \(error.localizedDescription)")
                completion([])
                return
            }

            let results = response?.collection.children.compactMap { geoObject -> SearchResult? in
                guard let obj = geoObject.obj,
                      let point = obj.geometry.first?.point else { return nil }

                return SearchResult(
                    name: obj.name ?? "Noma'lum joy",
                    address: obj.descriptionText ?? "Manzil mavjud emas",
                    latitude: point.latitude,
                    longitude: point.longitude,
                    distance: DistanceCalculator.calculateDistance(to: point)
                )
            } ?? []

            completion(results)
        }
    }
}
