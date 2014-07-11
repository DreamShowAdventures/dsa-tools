package util;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;

/**
 * A base class for treating a bunch of sprites like one. Similar to FlxSpriteGroup.
 * 
 * @author Steve Richey
 */
class SubSprite extends FlxSprite
{
	private var _spawn:FlxPoint;
	private var _members:Array<FlxSprite>;
	private var _scroll:Float = 0;
	
	public function new(X:Float = 0, Y:Float = 0, ?Graphic:FlxGraphicAsset, Scroll:Bool = false)
	{
		// members array has to be defined before super() so that setting x doesn't cause null error
		_members = new Array<FlxSprite>();
		
		super(X, Y, Graphic);
		
		if (Graphic == null)
		{
			makeGraphic(1, 1, 0);
		}
		
		_spawn = FlxPoint.get(X, Y);
		
		if (Scroll)
		{
			_scroll = 1;
		}
		
		scrollFactor.set(_scroll, _scroll);
	}
	
	override public function update():Void
	{
		super.update();
		
		// Update children
		
		for (obj in _members)
		{
			if (obj != null)
			{
				obj.update();
			}
		}
	}
	
	/**
	 * Similar to FlxGroup, allows you to add child objects.
	 */
	public function add(Object:FlxSprite):FlxSprite
	{
		if (_members.indexOf(Object) == -1)
		{
			Object.alpha = alpha;
			
			if (!Std.is(Object, TextRender))
			{
				Object.color = color;
			}
			
			Object.visible = visible;
			Object.scrollFactor.set(_scroll, _scroll);
			_members.push(Object);
		}
		
		return Object;
	}
	
	/**
	 * Similar to FlxGroup, allows you to remove child objects.
	 */
	public function remove(Object:FlxSprite):SubSprite
	{
		if (_members.indexOf(Object) != -1)
		{
			_members.splice(_members.indexOf(Object), 1);
		}
		
		return this;
	}
	
	/**
	 * Just calls draw on all child objects.
	 */
	override public function draw():Void
	{
		super.draw();
		
		for (obj in _members)
		{
			if (obj != null)
			{
				obj.draw();
			}
		}
	}
	
	override private function set_x(Value:Float):Float
	{
		var old:Float = x;
		
		super.set_x(Value);
		
		for (obj in _members)
		{
			if (obj != null)
			{
				obj.x += Value - old;
			}
		}
		
		return Value;
	}
	
	override private function set_y(Value:Float):Float
	{
		var old:Float = y;
		
		super.set_y(Value);
		
		for (obj in _members)
		{
			if (obj != null)
			{
				obj.y += Value - old;
			}
		}
		
		return Value;
	}
	
	override private function set_alpha(Value:Float):Float
	{
		var old:Float = alpha;
		
		super.set_alpha(Value);
		
		for (obj in _members)
		{
			if (obj != null)
			{
				obj.alpha += Value - old;
			}
		}
		
		return Value;
	}
	
	override private function set_color(Value:FlxColor):FlxColor
	{
		super.set_color(Value);
		
		for (obj in _members)
		{
			if (obj != null)
			{
				obj.color = Value;
			}
		}
		
		return Value;
	}
}