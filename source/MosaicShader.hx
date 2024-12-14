package;

import flixel.math.FlxPoint;
import flixel.addons.display.FlxRuntimeShader;

/**
 * A classic mosaic effect, just like in the old days!
 *
 * Usage notes:
 * - The effect will be applied to the whole screen.
 * - Set the x/y-values on the 'uBlocksize' vector to the desired size (setting this to 0 will make the screen go black)
 */
class MosaicShader extends FlxRuntimeShader
{
	public var blockSize:FlxPoint = FlxPoint.get(1.0, 1.0);

	public function new()
	{
		super("
			#pragma header
			uniform vec2 uBlocksize;

			void main()
			{
				vec2 blocks = openfl_TextureSize / uBlocksize;
				gl_FragColor = flixel_texture2D(bitmap, floor(openfl_TextureCoordv * blocks) / blocks);
			}
		");
		setBlockSize(1.0, 1.0);
	}

	public function setBlockSize(w:Float, h:Float)
	{
		blockSize.set(w, h);
		setFloatArray("uBlocksize", [w, h]);
	}
}
