# ACRObservingPlayerItem

#### Why?

I was getting a lot of crash reports with deallocated AVPlayerItem's while a KVO was still active.
It was hard to manually remove the KVO when the AVPlayerItem was randomly deallocated from inside a UITableViewCell.

#### What?

ACRObservingPlayerItem is a simple wrapper class for AVPlayerItem which handles the observing of some common playback events and safely releases the KVO on deallocation.


#### How?

Install with Cocoapods

```ruby
pod "ACRObservingPlayerItem"
```

Or copy the .m and .h files into your project.

##### Objective-C

Import the header file in your desired view.

```objc
#import "ACRObservingPlayerItem.h"
```

Add the delegate to your class/controller:

```objc
@interface YourViewController () <ACRObservingPlayerItemDelegate>
@end
```

Then implement the desired delegate methods (all optional):

```objc
- (void)playerItemReachedEnd;
- (void)playerItemStalled;
- (void)playerItemReadyToPlay;
- (void)playerItemPlayFailed;
- (void)playerItemRemovedObservation;
```

Create the player item and assign the delegate:

```objc
ACRObservingPlayerItem *playerItem = [[ACRObservingPlayerItem alloc] initWithAsset:self.videoAsset];
playerItem.delegate = self;
```

If the object is deallocated/deinit it will attempt to call `playerItemRemovedObservation` on the delegate.

The entire point of the object is to automatically release the KVO when deallocated/deinit but to be safe you should nil out the delegate when your view or delegate is removed:

```objc
- (void)dealloc {
    playerItem.delegate = nil;
    // or
    playerItem = nil;
}
```

##### Swift

Version 1.1 was changed to support Swift through an Obj-C Bridging-Header file. Read this excellent tutorial to get started with Swift and Cocoapods: [Cocoapods with Swift](https://medium.com/@jigarm/cocoapods-with-swift-93bd373a7111)

In your bridging header put:

```objc
#import "ACRObservingPlayerItem.h"
```

Full Swift example:

```swift
import UIKit
import AVFoundation

class VideoPlayerController: UIViewController, ACRObservingPlayerItemDelegate {
  var playerItem : ACRObservingPlayerItem?

  init {
    self.playerItem = ACRObservingPlayerItem(asset: self.video)
    self.playerItem!.delegate = self
  }

  deinit {
      playerItem?.delegate = nil
      // or
      playerItem = nil
  }

  // MARK: ACRObservingPlayerItemDelegate

  func playerItemReachedEnd() {
      // rewind and play?
  }

  func playerItemReadyToPlay() {
    // play!
  }

  func playerItemPlayFailed() { }
  func playerItemStalled() { }
  func playerItemRemovedObservation() { }
}
```


#### License?

MIT


#### Bugs?

There may be some. I wrote this late at night but it seems to be doing the trick for me.

Submit an issue or pull-request. Please. I don't like doing bug fixes over email or Github messages.

#### Thanks?

Let me know if you find this library helpful. I'm [@acr](http://twitter.com/acr) on Twitter or ping me here on Github.