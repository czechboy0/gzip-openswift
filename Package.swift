import PackageDescription

let package = Package(
    name: "ZewoGzip",
    dependencies: [
        .Package(url: "https://github.com/Zewo/HTTP.git", majorVersion: 0, minor: 14),
    	.Package(url: "https://github.com/Zewo/gzip.git", majorVersion: 0, minor: 6),
    	.Package(url: "https://github.com/Zewo/Axis.git", majorVersion: 0, minor: 14),
    ]
)
