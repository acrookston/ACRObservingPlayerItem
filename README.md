# ACRObservingPlayerItem

#### Why?

Because I was having problem removing a KVO observation on AVPlayerItem when it randomly got deallocated in a UITableView.

#### What?

A simple wrapper class for AVPlayerItem which handles the observing of some common playback events.

#### How?

Copy the .m and .h files into your project.

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


#### Bugs!

There may be some. I wrote this late at night but it seems to be doing the trick for me.

Submit an issue or pull-request. Please. I don't like doing bug fixes over email or Github messages.