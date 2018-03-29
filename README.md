# Flimmer

Flimmer is a iOS application built with Xcode and Swift 4. You can search for Flicker images by text/keyword or by a geolocation via a mapview.

Technical features
* Integration with Flicker API https://www.flickr.com/services/api/
* URLSessions is used to manage data tasks.
* Decodable protocol to map the application models with the JSON-data. 
* Images is loaded asynchronously in a background thread.
* All images is cached with NSCache.
* MKMapView is used to search for images by geolocation, your current location or tap on map for a custom location.

