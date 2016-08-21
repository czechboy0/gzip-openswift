import PackageDescription

let package = Package(
    name: "gzip-openswift",
    dependencies: [
    	.Package(url: "https://github.com/Zewo/gzip.git", majorVersion: 0, minor: 6),
    	.Package(url: "https://github.com/open-swift/C7.git", majorVersion: 0, minor: 10),
    	.Package(url: "https://github.com/open-swift/S4.git", majorVersion: 0, minor: 11)
    ]
)
