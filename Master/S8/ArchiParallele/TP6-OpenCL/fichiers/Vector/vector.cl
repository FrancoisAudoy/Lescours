
__kernel void vecmul(__global float *vec,
		     __global float *res,
		     float k)
{
	int id  = get_global_id(0);
	res[id] = vec[id] * k;
	res[(id+16)%get_global_size(0)] = vec[(id+16)%get_global_size(0)] * k;
}
