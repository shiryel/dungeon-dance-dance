#Source: https://github.com/pigdevstudio/godot_tools
#MIT License
#
#Copyright (c) 2018 Pigdev Studio
#
#Permission is hereby granted, free of charge, to any person obtaining a copy
#of this software and associated documentation files (the "Software"), to deal
#in the Software without restriction, including without limitation the rights
#to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#copies of the Software, and to permit persons to whom the Software is
#furnished to do so, subject to the following conditions:
#
#The above copyright notice and this permission notice shall be included in all
#copies or substantial portions of the Software.
#
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#SOFTWARE.

tool
class_name Geometry2D
extends CollisionShape2D

export (Color) var color = Color(1, 1, 1, 1) setget set_color

func set_color(new_color):
	color = new_color
	update()

func _draw():
	var offset_position = Vector2(0, 0)
	 
	if shape is CircleShape2D:
		draw_circle(offset_position, shape.radius, color)
	elif shape is RectangleShape2D:
		var rect = Rect2(offset_position - shape.extents, shape.extents * 2.0)
		draw_rect(rect, color)
	elif shape is CapsuleShape2D:
		var upper_circle_position = offset_position + Vector2(0, shape.height * 0.5)
		draw_circle(upper_circle_position, shape.radius, color)
		
		var lower_circle_position = offset_position - Vector2(0, shape.height * 0.5)
		draw_circle(lower_circle_position, shape.radius, color)
		
		var rect_position = offset_position - Vector2(shape.radius, shape.height * 0.5)
		var rect = Rect2(rect_position, Vector2(shape.radius * 2, shape.height))
		draw_rect(rect, color)
