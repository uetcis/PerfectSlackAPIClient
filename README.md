<p align="center">
	<img src="https://raw.githubusercontent.com/SvenTiigi/PerfectSlackAPIClient/master/.assets/logo.png" alt="logo">
</p>
<br/>
<p align="center">
	<a href="https://developer.apple.com/swift/" target="_blank">
		<img src="https://img.shields.io/badge/Swift-4.0-orange.svg" alt="Swift 3.2">
	</a>
	<img src="https://img.shields.io/badge/platform-macOS%20%7C%20Linux-yellow.svg" alt="Platform">
	<a href="https://twitter.com/SvenTiigi" target="_blank">
		<img src="https://img.shields.io/badge/contact-@SvenTiigi-blue.svg" alt="@SvenTiigi">
	</a>
</p>

PerfectSlackAPIClient is an API Client to access the Slack API from your [Perfect Server Side Swift](https://github.com/PerfectlySoft/Perfect) application. It is build on top of [PerfectAPIClient](https://github.com/SvenTiigi/PerfectAPIClient).

# Installation
To integrate using Apple's [Swift Package Manager](https://swift.org/package-manager/), add the following as a dependency to your `Package.swift`:

```swift
.package(url: "https://github.com/SvenTiigi/PerfectSlackAPIClient.git", from: "1.0.0")
```
Here's an example `PackageDescription`:

```swift
// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "MyPackage",
    products: [
        .library(
            name: "MyPackage",
            targets: ["MyPackage"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/SvenTiigi/PerfectSlackAPIClient.git", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "MyPackage",
            dependencies: ["PerfectSlackAPIClient"]
        ),
        .testTarget(
            name: "MyPackageTests",
            dependencies: ["MyPackage", "PerfectSlackAPIClient"]
        )
    ]
)
```

# Setup
In order to send a message to your Slack-Channel, you have to generate a `Webhook URL` for your Slack-Workspace.
Checkout the Slack API [Hello world example](https://api.slack.com/tutorials/slack-apps-hello-world). After you successfully generated a Slack Webhook URL you can configure the `PerfectSlackAPIClient`.

```swift
// Configure the Webhook URL
PerfectSlackAPIClient.Configuration.webhookURL = "YOUR_WEBHOOK_URL"
```

It is recommend to set the Webhook URL in your initialization code just before you start your `PerfectHTTPServer`.

# Usage
The following example demonstrates how to post a `SlackMessage`.

```swift
// Initialize SlackMessage
var message = SlackMessage()
message.text = "Hello Developer".toMarkdown(format: .code)

// Initialize SlackAttachment
var attachment = SlackAttachment()
attachment.title = "Mindblown 🤯"
attachment.imageURL = "https://media.giphy.com/media/Um3ljJl8jrnHy/giphy.gif"

// Add the attachment to the message
message.attachments = [attachment]

PerfectSlackAPIClient.send(message).request { (result: APIClientResult<APIClientResponse>) in
    result.analysis(success: { (response: APIClientResponse) in
        // SlackMessage has been posted
        print(response.payload)
    }, failure: { (error: APIClientError) in
        // SlackMessage could not be sent 😱
        // Perform error.analysis(....) to get more information
    }
}
```

Fore more details on `APIClientResult`, `APIClientResponse` and error handling check out [PerfectAPIClient](https://github.com/SvenTiigi/PerfectAPIClient).

# Slack Message Builder Preview
You can generate a [Slack Message Builder](https://api.slack.com/docs/messages/builder) URL from your `SlackMessage` to get a brief look of how your message will be presented in your Slack-Channel.

```swift
// Initialize SlackMessage
var message = SlackMessage(text: "Posted via PerfectSlackAPIClient")

// Configure the message...

// Print Slack Message Builder Preview URL
print(message.messageBuilderPreviewURL)
```

This example will generate the following url

[https://api.slack.com/docs/messages/builder?msg=%7B%22text%22:%22Posted%20via%20PerfectSlackAPIClient%22%7D](https://api.slack.com/docs/messages/builder?msg=%7B%22text%22:%22Posted%20via%20PerfectSlackAPIClient%22%7D)

<p align="center">
	<img src="https://raw.githubusercontent.com/SvenTiigi/PerfectSlackAPIClient/master/.assets/message_builder_example.png" alt="Message Builder Example Preview">
</p>
