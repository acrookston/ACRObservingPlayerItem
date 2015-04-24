//
//  ACRObservingPlayerItem.h
//
//  Created by Andrew Crookston on 9/30/14.
//  Copyright (c) 2014 Andrew Crookston. All rights reserved.
//  Released under MIT License.
//

#import <AVFoundation/AVFoundation.h>

@protocol ACRObservingPlayerItemDelegate <NSObject>
@optional
- (void)playerItemReachedEnd;
- (void)playerItemStalled;
- (void)playerItemReadyToPlay;
- (void)playerItemPlayFailed;
- (void)playerItemRemovedObservation;
@end

@interface ACRObservingPlayerItem : AVPlayerItem

- (void)removeObservers;
@property (nonatomic, weak) id<ACRObservingPlayerItemDelegate> delegate;

@end
