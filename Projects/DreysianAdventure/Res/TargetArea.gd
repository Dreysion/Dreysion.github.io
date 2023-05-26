extends MeshInstance2D



func _ready():
	
	
	self.set_mesh(generateCircleMesh())


func generateCircleMesh(radius: float = 0.5, segments: int = 72) -> ArrayMesh:
	
	var st = SurfaceTool.new()
	var mesh = Mesh.new()
	var mat = Material.new()
	
	st.set_material(mat)
	#st.begin(Mesh.PRIMITIVE_TRIANGLE_FAN)
	st.begin(Mesh.PRIMITIVE_TRIANGLES)
	st.add_color(Color(1,0,1,0.8))
	st.add_uv(0.5 * Vector2.ONE)
	st.add_vertex(Vector3.ZERO)
	
	for i in range(segments + 1):
		var angle = i / float(segments) * TAU
		var p = Vector3.RIGHT.rotated(Vector3.DOWN, angle)
		
		var uv = 0.5 * (Vector2(p.x, p.z) + Vector2.ONE)
		var position = radius * p
		
		st.add_color(Color(1,0,1,0.8))
		st.add_uv(uv)
		st.add_vertex(position)
	
	return st.commit(mesh)
