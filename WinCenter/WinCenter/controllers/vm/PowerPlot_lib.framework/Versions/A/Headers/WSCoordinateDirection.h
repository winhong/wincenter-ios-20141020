//
//  WSCoordinateDirection.h
//  PowerPlot
//
//  Created by Wolfram Schroers on 15.10.10.
//  Copyright 2010-2013 Numerik & Analyse Schroers. All rights reserved.
//

#ifndef __WSCOORDINATEDIRECTION_H__
#define __WSCOORDINATEDIRECTION_H__

/// This enum defines an elementary data type that specifies the
/// direction (either X- or Y-) any coordinate-related datum can have.
typedef NS_ENUM(NSInteger, WSCoordinateDirection) {
    kCoordinateDirectionNone = 0, ///< No direction specified.
    kCoordinateDirectionX,        ///< X-direction.
    kCoordinateDirectionY         ///< Y-direction.
};

#endif /* __WSCOORDINATEDIRECTION_H__ */

