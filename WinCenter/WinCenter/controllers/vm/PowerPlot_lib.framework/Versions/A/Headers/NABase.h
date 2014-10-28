/**
 *  @file
 *  NABase.h
 *  NuAS Amethyst Graphics System
 *
 *  This header interfaces basic definitions of interfaces to
 *  functions of the NuAS Amethyst Graphics library.
 *
 *
 *  Created by Wolfram Schroers on 11/02/09.
 *  Copyright 2009-2013 Numerik & Analyse Schroers. All rights reserved.
 *
 */

#ifndef __NABASE_H__
#define __NABASE_H__

#include <CoreGraphics/CoreGraphics.h>
#include <math.h>

/** Generic definition of floating point numbers. */
typedef CGFloat NAFloat;

/** Constant: Golden ratio. */
static const NAFloat M_GOLDENRATIO = 1.6180339887498949;

/** Constant: 1/sqrt(2). */
static const NAFloat M_ISQRT2 = 0.70710678118654746;

/** Constant: Invalid @p CGPoint. */
static const CGPoint CGPOINT_INVALID = (CGPoint){ .x = NAN, .y = NAN };

/** Check for screen-coordinate singularity. */
static inline int IS_EPSILON(a) { return (fabs(a) < 1.0e-08); }

#endif /* __NABASE_H__ */

