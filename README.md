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

Don't worry about the deallocation of the object. The object will attempt to call `playerItemRemovedObservation` when observers are removed or the object is deallocated (I'm unsure how reliable the latter case is).

However you may want to nil the delegate to avoid any memory leaks.

```objc
- (void)dealloc {
    playerItem.delegate = nil;
}
```

#### License?

MIT


#### Bugs?

There may be some. I wrote this late at night but it seems to be doing the trick for me.

Submit an issue or pull-request. Please. I don't like doing bug fixes over email or Github messages.

#### Thanks?

Let me know if you find this library helpful. I'm [@acr](http://twitter.com/acr) on Twitter or ping me here on Github.