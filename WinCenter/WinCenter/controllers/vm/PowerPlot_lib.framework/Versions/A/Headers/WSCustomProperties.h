//
//  WSCustomProperties.h
//  PowerPlot
//
//  Created by Wolfram Schroers on 1/18/12.
//  Copyright (c) 2012-2013 Numerik & Analyse Schroers. All rights reserved.
//

@import Foundation;

/// This is the base class for custom properties that my be inserted
/// in the @p customDatum slot in a @p WSDatum to configure the
/// appearance of an individual datum.
@interface WSCustomProperties : NSObject <NSCopying, NSCoding, NSObject>

@end
