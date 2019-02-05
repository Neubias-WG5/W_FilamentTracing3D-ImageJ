// Author: Sébastien Tosi (IRB Barcelona)
// Version: 1.0
// Date: 04/02/2019

// Path to input image and result table
inputDir = "/data";
outputDir = "/out";

// Functional parameters
Gblur = 2;
BckLvl = 30;

arg = getArgument();
parts = split(arg, ",");

setBatchMode(true);

for(i=0; i<parts.length; i++) {
	nameAndValue = split(parts[i], "=");
	if (indexOf(nameAndValue[0], "input")>-1) inputDir=nameAndValue[1];
	if (indexOf(nameAndValue[0], "output")>-1) outputDir=nameAndValue[1];
	if (indexOf(nameAndValue[0], "gblur")>-1) Gblur=nameAndValue[1];
	if (indexOf(nameAndValue[0], "bcklvl")>-1) BckLvl=nameAndValue[1];
}

images = getFileList(inputDir);

for(i=0; i<images.length; i++) {
	image = images[i];
	if (endsWith(image, ".tif")) {
		// Workflow
		run("Gaussian Blur 3D...", "x="+d2s(Gblur,2)+" y="+d2s(Gblur,2)+" z="+d2s(Gblur,2));
		setThreshold(BckLvl, 255);
		setOption("BlackBackground", false);
		run("Convert to Mask", "method=Default background=Dark");
		run("Skeletonize (2D/3D)");
		rename("Skel");
		run("Analyze Skeleton (2D/3D)", "prune=none");
		selectImage("Skel");
		close();
		
	}
}

run("Quit");
