//
//  @file
//  WSAuxiliary.h
//  PowerPlot
//
//  Created by Wolfram Schroers on 16.10.10.
//  Copyright 2010-2013 Numerik & Analyse Schroers. All rights reserved.
//

#ifndef __WSAUXILIARY_H__
#define __WSAUXILIARY_H__

@import Foundation;

/// Header file with auxiliary key definitions that are used
/// throughout the library.

/// Manual KVO notifications for the @p values property.
static NSString *const KVO_VALUES = @"values";
static NSString *const KVO_DATUM = @"datum";

/// Dictionary keys for serialization of objects.
static NSString *const kAxisStyleKey = @"axisstyle";
static NSString *const kAxisOverhangKey = @"axisoverhang";
static NSString *const kAxisPaddingKey = @"axispadding";
static NSString *const kGridStyleKey = @"gridstyle";
static NSString *const kLabelStyleKey = @"labelStyle";
static NSString *const kLabelOffsetKey = @"labelOffset";
static NSString *const kAxisLabelKey = @"axisLabel";
static NSString *const kLabelColorKey = @"labelcolor";
static NSString *const kLabelFontnameKey = @"labelfontname";
static NSString *const kLabelFontsizeKey = @"labelfontsize";
static NSString *const kWidthKey = @"width";
static NSString *const kOffsetKey = @"offset";
static NSString *const kOutlineStrokeKey = @"outlinestroke";
static NSString *const kShadowScaleKey = @"shadowscale";
static NSString *const kStyleKey = @"style";
static NSString *const kShadowEnabledKey = @"shadow";
static NSString *const kOutlineColorKey = @"outlinecolor";
static NSString *const kColorKey = @"color";
static NSString *const kColorAltKey = @"color2";
static NSString *const kShadowColorKey = @"shadowcolor";
static NSString *const kColorschemeKey = @"colorscheme";
static NSString *const kConnectionToKey = @"to";
static NSString *const kConnectionFromKey = @"from";
static NSString *const kConnectionDirectionKey = @"direction";
static NSString *const kConnectionStrengthKey = @"strength";
static NSString *const kLabelKey = @"label";
static NSString *const kNameKey = @"name";
static NSString *const kValuesKey = @"values";
static NSString *const kErrorMinYKey = @"errorMinY";
static NSString *const kErrorMaxYKey = @"errorMaxY";
static NSString *const kErrorMinXKey = @"errorMinX";
static NSString *const kErrorMaxXKey = @"errorMaxX";
static NSString *const kSizeKey = @"size";
static NSString *const kErrorbarLenKey = @"eblen";
static NSString *const kErrorBarStyleKey = @"ebstyle";
static NSString *const kValueKey = @"value";
static NSString *const kValueXKey = @"valueX";
static NSString *const kAnnotationKey = @"annotation";
static NSString *const kDatumKey = @"datum";
static NSString *const kCustomKey = @"custom";
static NSString *const kCorrelationKey = @"errorCorr";
static NSString *const kAlertedKey = @"alerted";
static NSString *const kConnectionsKey = @"connections";
static NSString *const kHeightKey = @"height";
static NSString *const kLabelPaddingKey = @"labelpadding";

#endif /* __WSAUXILIARY_H__ */
