//
//  GlissView.h
//  Gliss
//
//  Created by Charles Feduke on 2/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface GlissView : NSOpenGLView {
	IBOutlet NSMatrix *sliderMatrix;
	float lightX, theta, radius;
	int displayList;
}

-(IBAction)changeParameter:(id)sender;

@end
