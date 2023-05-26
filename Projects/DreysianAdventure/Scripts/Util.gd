extends Node


func in_box(VTarget,VStart,VEnd):
	return (VTarget.x > VStart.x) && (VTarget.x < VEnd.x) && (VTarget.y > VStart.y) && (VTarget.y < VEnd.y)
