//
//  ShelfStatus.m
//  Baker
//
//  ==========================================================================================
//
//  Copyright (c) 2010-2013, Davide Casali, Marco Colombo, Alessandro Morandi
//  All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are
//  permitted provided that the following conditions are met:
//
//  Redistributions of source code must retain the above copyright notice, this list of
//  conditions and the following disclaimer.
//  Redistributions in binary form must reproduce the above copyright notice, this list of
//  conditions and the following disclaimer in the documentation and/or other materials
//  provided with the distribution.
//  Neither the name of the Baker Framework nor the names of its contributors may be used to
//  endorse or promote products derived from this software without specific prior written
//  permission.
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY
//  EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
//  OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT
//  SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
//  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
//  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
//  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
//  LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
//  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

#import "ShelfStatus.h"

@implementation ShelfStatus

@synthesize prices;

- (id)init {
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *statusPath = [[cachePath stringByAppendingPathComponent:@"shelf-status"] stringByAppendingPathExtension:@"json"];

    self = [super initWithJSONPath:statusPath];
    if (self) {
        self.prices = [[[NSMutableDictionary alloc] init] retain];
    }
    return self;
}

- (NSDictionary *)load {
    NSDictionary *jsonDict = [super load];

    NSDictionary *jsonPrices = [jsonDict objectForKey:@"prices"];
    [jsonPrices enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [self setPrice:obj for:key];
    }];

    return jsonDict;
}

- (void)save {
    NSDictionary *jsonDict = [NSDictionary dictionaryWithObjectsAndKeys:prices, @"prices", nil];

    [super save:jsonDict];
}

- (NSString *)priceFor:(NSString *)productID {
    return [prices objectForKey:productID];
}

- (void)setPrice:(NSString *)price for:(NSString *)productID {
    [prices setObject:price forKey:productID];
}

- (void)dealloc {
    [prices release];

    [super dealloc];
}

@end
