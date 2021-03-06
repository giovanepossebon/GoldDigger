//
//  GDGQuery.m
//  GoldDigger
//
//  Created by Pietro Caselani on 2/15/16.
//

#import "GDGQuery.h"

#import "GDGQuery_Protected.h"
#import "GDGFilter.h"

@implementation GDGQuery

+ (instancetype)query
{
	return [(GDGQuery *)[self.class alloc] init];
}

#pragma mark - Initialization

- (instancetype)init
{
	if (self = [super init])
	{
		__weak typeof(self) weakSelf = self;

		_limit = ^GDGQuery *(int limit) {
			[weakSelf limit:limit];
			return weakSelf;
		};

		_filter = ^GDGQuery *(NSArray<id <GDGFilter>> *filters) {
			[weakSelf filter:filters];
			return weakSelf;
		};
	}

	return self;
}

#pragma mark - Abstract

- (id)visit
{
	@throw [NSException exceptionWithName:@"Abstract Implementation Exception"
	                               reason:@"[GDGQuery -visit] throws that child classes must override this method"
	                             userInfo:nil];
}

- (id)pluck
{
	@throw [NSException exceptionWithName:@"Abstract Implementation Exception"
	                               reason:@"[GDGQuery -pluck] throws that child classes must override this method"
	                             userInfo:nil];
}

- (NSDictionary *)args
{
	@throw [NSException exceptionWithName:@"Abstract Implementation Exception"
	                               reason:@"[GDGQuery -pluck] throws that child classes must override this method"
	                             userInfo:nil];
}

#pragma - Copying

- (__kindof GDGQuery *)copyWithZone:(nullable NSZone *)zone
{
	GDGQuery *copy = [(GDGQuery *) [[self class] allocWithZone:zone] init];
	copy->_limitValue = _limitValue;

	return copy;
}

#pragma mark - Protected impl

- (void)limit:(int)limit
{
	_limitValue = limit;
}

- (void)filter:(NSArray <id <GDGFilter>> *)filters
{
	for (id <GDGFilter> filter in filters)
		[filter apply:self];
}

@end
