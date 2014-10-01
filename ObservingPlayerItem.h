//
//  ObservingPlayerItem.h
//
//  Created by Andrew Crookston on 9/30/14.
//  Copyright (c) 2014 Andrew Crookston. All rights reserved.
//  Released under MIT License.
//

#import <AVFoundation/AVFoundation.h>

@protocol ObservingPlayerItemDelegate <NSObject>
@optional
- (void)playerItemReachedEnd;
- (void)playerItemStalled;
- (void)playerItemReadyToPlay;
- (void)playerItemPlayFailed;
- (void)playerItemRemovedObservation;
@end

@interface ObservingPlayerItem : AVPlayerItem

@property (nonatomic, assign) id<ObservingPlayerItemDelegate> __unsafe_unretained delegate;

@end
