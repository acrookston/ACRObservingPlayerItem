//
//  ACRObservingPlayerItem.m
//
//  Created by Andrew Crookston on 9/30/14.
//  Copyright (c) 2014 Andrew Crookston. All rights reserved.
//  Released under MIT License.
//

#import "ACRObservingPlayerItem.h"

static NSString *const kStatusKeyPath = @"status";

@implementation ACRObservingPlayerItem

- (void)setDelegate:(id<ACRObservingPlayerItemDelegate>)delegate {
    if (delegate != nil) {
        [self removeObservers];
    }
    _delegate = delegate;
    [self addObservers];
}

- (void)dealloc {
    [self removeObservers];
}

- (void)addObservers {
    [self addObserver:self forKeyPath:kStatusKeyPath options:NSKeyValueObservingOptionNew context:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemReachedEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemStalled:)
                                                 name:AVPlayerItemPlaybackStalledNotification
                                               object:self];
}

- (void)removeObservers {
    if (self.delegate) {
        [self removeObserver:self forKeyPath:kStatusKeyPath context:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:AVPlayerItemDidPlayToEndTimeNotification
                                                      object:self];

        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:AVPlayerItemPlaybackStalledNotification
                                                      object:self];
        if ([self.delegate respondsToSelector:@selector(playerItemRemovedObservation)]) {
            [self.delegate playerItemRemovedObservation];
        }
        _delegate = nil;
    }
}

- (void)playerItemReachedEnd:(NSNotification *)notification {
    if (self.delegate && [self.delegate respondsToSelector:@selector(playerItemReachedEnd)]) {
        [self.delegate playerItemReachedEnd];
    }
}

- (void)playerItemStalled:(NSNotification *)notification {
    if (self.delegate && [self.delegate respondsToSelector:@selector(playerItemStalled)]) {
        [self.delegate playerItemStalled];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self && [keyPath isEqualToString:kStatusKeyPath]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.status == AVPlayerItemStatusReadyToPlay) {
                if (self.delegate && [self.delegate respondsToSelector:@selector(playerItemReadyToPlay)]) {
                    [self.delegate playerItemReadyToPlay];
                }
            } else if (self.status == AVPlayerItemStatusFailed) {
                if (self.delegate && [self.delegate respondsToSelector:@selector(playerItemPlayFailed)]) {
                    [self.delegate playerItemPlayFailed];
                }
            }
        });
        return;
    }
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    return;
}

@end
