# TwitterStream-Sample
 
Realtime display of tweets associated with keyword.

Twitter provides an endpoint that delivers a continuous stream of tweets filtered by a keyword (https://stream.twitter.com/1.1/statuses/filter.json?track=India)

Further details of the APIs can be found at https://dev.twitter.com/docs/streaming-apis.


### Setup

Follow these steps to run the demo project:
* Install the CocaPods dependencies.
* You need to create a app on https://apps.twitter.com/ and setup the Bearer Token on Constants.swift
 
### references:
* [Consuming Streaming Data](https://developer.twitter.com/en/docs/twitter-api/tweets/filtered-stream/api-reference/get-tweets-search-stream#Optional)
* [POST statuses/filter](https://developer.twitter.com/en/docs/twitter-api/tweets/filtered-stream/api-reference/post-tweets-search-stream-rules)

### Viper
VIPER architecure used for this app. Using [SOLID]
Made using viper to be more testable and to divide responsabilities.

### Tests
* Snapshot to test my view states.

## Built With
new tweets showing in tableview with DifferenceKit
* [DifferenceKit](https://github.com/ra1028/DifferenceKit)



https://user-images.githubusercontent.com/89471912/160639799-e11f18bc-1f06-4602-9bc1-fa0e949e55f6.mp4

