//
//  GlissView.m
//  Gliss
//
//  Created by Charles Feduke on 2/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GlissView.h"
#import <GLUT/GLUT.h>

#define LIGHT_X_TAG 0
#define THETA_TAG 1
#define RADIUS_TAG 2

@implementation GlissView

-(void)prepare {
	NSLog(@"prepare");
	
	NSOpenGLContext *glcontext = [self openGLContext];
	[glcontext makeCurrentContext];
	
	glShadeModel(GL_SMOOTH);
	glEnable(GL_LIGHTING);
	glEnable(GL_DEPTH_TEST);
	
	GLfloat ambient[] = { 0.2, 0.2, 0.2, 1.0 };
	glLightModelfv(GL_LIGHT_MODEL_AMBIENT, ambient);
	
	GLfloat diffuse[] = { 1.0, 1.0, 1.0, 1.0 };
	glLightfv(GL_LIGHT0, GL_DIFFUSE, diffuse);
	glEnable(GL_LIGHT0);
	
	GLfloat mat[] = { 0.1, 0.1, 0.7, 1.0 };
	
	glMaterialfv(GL_FRONT, GL_DIFFUSE, mat);
}

-(id)initWithCoder:(NSCoder *)c {
	self = [super initWithCoder:c];
	[self prepare];
	return self;
}

-(void)reshape {
	NSLog(@"reshape");
	NSRect baseRect = [self convertRectToBase:[self bounds]];
	
	glViewport(0, 0, baseRect.size.width, baseRect.size.height);
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	gluPerspective(60.0, baseRect.size.width/baseRect.size.height, 0.2, 7);
}

-(void)awakeFromNib {
	[self changeParameter:nil];
}

-(IBAction)changeParameter:(id)sender {
	lightX = [[sliderMatrix cellWithTag:LIGHT_X_TAG] floatValue];
	theta = [[sliderMatrix cellWithTag:THETA_TAG] floatValue];
	radius = [[sliderMatrix cellWithTag:RADIUS_TAG] floatValue];
	[self setNeedsDisplay:YES];
}

-(void)drawRect:(NSRect)r {
	glClearColor(0.2, 0.4, 0.1, 0.0);
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
	
	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity();
	gluLookAt(radius * sin(theta), 0, radius * cos(theta), 0, 0, 0, 0, 1, 0);
	
	GLfloat lightPosition[] = { lightX, 1, 3, 0.0 };
	glLightfv(GL_LIGHT0, GL_POSITION, lightPosition);
	
	if (!displayList) {
		displayList = glGenLists(1);
		glNewList(displayList, GL_COMPILE_AND_EXECUTE);
		
		glTranslatef(0, 0, 0);
		glutSolidTorus(0.3, 1.8, 35, 31);
		
		glEndList();
	} else {
		glCallList(displayList);
	}
	
	glFinish();
}
@end
