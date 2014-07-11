package util;

import haxe.io.Bytes;
import sys.FileSystem;
import sys.io.File;
import sys.io.FileInput;

/**
 * A very simple wrapper for ImageMagick to resize icons for Android and/or iOS.
 * 
 * @author Steve Richey
 */
class Resizer
{
	static public function main():Void
	{
		var args:Array<String> = Sys.args();
		
		if (args.length < 1)
		{
			throw("You need to pass in an image path!");
		}
		
		if (args.length < 2)
		{
			throw("You need to pass in desired sizes!");
		}
		
		var desiredSizes:Array<Int> = [];
		var targetImage:String = args[0];
		args.splice(0, 1);
		
		for (arg in args)
		{
			desiredSizes.push(Std.parseInt(arg));
		}
		
		var fileInput:FileInput;
		
		try {
			fileInput = File.read(targetImage);
		} catch (e:Dynamic) {
			throw("Couldn't open your file!");
		}
		
		var fileAsBytes:Bytes = fileInput.readAll();
		fileInput.close();
		
		var filePathEnd:Int = targetImage.indexOf("_", 0);
		var fileTypeStart:Int = targetImage.indexOf(".", 0);
		var filePath:String = targetImage.substring(0, filePathEnd);
		var fileType:String = targetImage.substring(fileTypeStart + 1, targetImage.length);
		
		if (fileAsBytes == null)
		{
			throw("Image data not valid! Are you sure it's an image file?");
		}
		
		var generatedFiles:Array<String> = [];
		var genfile:String = "";
		var killBg:String = fileType.toLowerCase() == "svg" ? " -background transparent " : " ";
		
		for (size in desiredSizes)
		{
			genfile = filePath + "_" + size + ".png";
			generatedFiles.push(genfile);
			Sys.command("convert" + killBg + "-resize " + size + "x " + targetImage + " " + genfile);
			Sys.println("Created " + genfile);
		}
	}
}