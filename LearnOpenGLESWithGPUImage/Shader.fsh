//
//  ViewController.m
//  LearnOpenGLESWithGPUImage
//
//  Created by loyinglin on 16/5/10.
//  Copyright © 2016年 loyinglin. All rights reserved.
//

varying highp vec2 texCoordVarying;
precision mediump float;

uniform sampler2D SamplerY;
uniform sampler2D SamplerUV;
uniform mat3 colorConversionMatrix;
uniform sampler2D SamplePNG;

void main()
{
	mediump vec3 yuv;
	lowp vec3 rgb;
	
	// Subtract constants to map the video range start at 0
    yuv.x = (texture2D(SamplerY, texCoordVarying).r);// - (16.0/255.0));
    yuv.yz = (texture2D(SamplerUV, texCoordVarying).ra - vec2(0.5, 0.5));
	
	rgb = colorConversionMatrix * yuv;

    vec3 color;
    color = rgb;
    
    vec4 bitmaodata = texture2D(SamplePNG, texCoordVarying);

    if(color.b-color.g>0.1 && color.b-color.r>0.1){
        color[0] = bitmaodata.r;
        color[1] = bitmaodata.g;
        color[2] = bitmaodata.b;
    }
    
	gl_FragColor = vec4(color,1.0);
//    gl_FragColor = bitmaodata;
//    gl_FragColor = vec4(1, 0, 0, 1);
}
