
__kernel void addmat(__global float *A,
		     __global float *B,
		     __global float *C)
{

	__local float tile[16][16];
	
	int x = get_global_id(0);
	int y = get_global_id(1);
	int decal = get_global_size(1);
	int x_loc = get_local_id(0);
	int y_loc = get_local_id(1);

	tile[x_loc][y_loc] = A[y * get_global_size(0) + x] + B[y * get_global_size(0) +x];
	barrier(CLK_LOCAL_MEM_FENCE);
	C[(x - x_loc + y_loc)* decal +(y -y_loc +x_loc)] = tile[x_loc][y_loc];

}
