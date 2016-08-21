# gzip

[![Build Status](https://travis-ci.org/czechboy0/gzip-openswift.svg?branch=master)](https://travis-ci.org/czechboy0/gzip-openswift)
![Platforms](https://img.shields.io/badge/platforms-Linux%20%7C%20OS%20X-blue.svg)
![Package Managers](https://img.shields.io/badge/package%20managers-SwiftPM-yellow.svg)

[![Blog](https://img.shields.io/badge/blog-honzadvorsky.com-green.svg)](http://honzadvorsky.com)
[![Twitter Czechboy0](https://img.shields.io/badge/twitter-czechboy0-green.svg)](http://twitter.com/czechboy0)

> gzip support for S4 and C7

# Usage
Adds support for `C7.Data`.

```swift
let myData = ... //C7.Data
let myGzipCompressedData = try myData.gzipCompressed() //C7.Data
...
let myGzipUncompressedData = try myGzipCompressedData.gzipUncompressed() //C7.Data
... //PROFIT!
```

Also contains a `GzipStream` class which conforms to `C7.ReceivingStream`, so it can be easily attached in a pipeline, like

```swift
let gzippedStream = ... //e.g. from S4.Body
let uncompressedStream = try GzipStream(rawStream: gzippedStream, mode: .uncompress)
... //PROFIT!
```

Also contains a `S4` compatible `Middleware`, which automatically adds the right headers to the request and decompresses the response if it's compressed.

```swift
let client = HTTPSClient.Client("https://my.server")
let response = client.get("/compressed", middleware: GzipMiddleware())
response.body.becomeBuffer() //<- Already decompressed data
```

# Installation

## Swift Package Manager

```swift
.Package(url: "https://github.com/czechboy0/gzip-openswift.git", majorVersion: 0, minor: 1)
```

:gift_heart: Contributing
------------
Please create an issue with a description of your problem or open a pull request with a fix.

:v: License
-------
MIT

:alien: Author
------
Honza Dvorsky - http://honzadvorsky.com, [@czechboy0](http://twitter.com/czechboy0)
