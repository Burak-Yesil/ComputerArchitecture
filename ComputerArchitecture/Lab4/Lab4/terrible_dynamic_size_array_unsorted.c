#include "terrible_dynamic_size_array_unsorted.h"


void init(struct int_array* arr) {
	arr->count 		= 	0;
	arr->capacity 	= 	DEFAULT_CAPACITY;
	arr->data 		= 	(int*)malloc(sizeof(int) * arr->capacity);
}

void clear(struct int_array* arr) {
	destr(arr);
	init(arr);
}

void destr(struct int_array* arr) {
	free(arr->data);
	arr->count = 0;
}

void print_array(struct int_array* arr) {
	for (unsigned int i = 0; i < arr->count; ++ i)
		printf("%d ", arr->data[i]);
	printf("\n");
}

int contains(struct int_array* arr, int target) {

	unsigned int i;

	for (i = 0; i < arr->count; ++i) //removed the semicolon
	{
		if (arr->data[i] == target)
			return TRUE; //removed the else statement
	}
	return FALSE;
}

void resize(struct int_array* arr) {

	arr->capacity *= 2;
	int* new_data = (int*)malloc(sizeof(int) * arr->capacity);
	for (unsigned int i = 0; i < arr->count; ++i)
	{
		new_data[i] = arr->data[i];
	}
	free(arr->data);//Put free before arr->data = new_data;
	arr->data = new_data;

}

void add(struct int_array* arr,  int payload) {

	if (arr->count == arr->capacity)

		resize(arr);

	arr->data[arr->count++] = payload; //we changed the placement of ++
}



int remove_elem(struct int_array* arr,  int target) {

	unsigned int i = 0;

	if ((arr->count == 0)){ //Changed = to == and added brackets
		return FALSE;
	}

	while (arr->data[i] != target){ //Replaced the && with a || and moved the first conditional statement to inside of the loop
	
		if (i >= arr->count){ //changed == to >=
			return FALSE;
			}

		i++;
	}

	arr->data[i] = arr->data[arr->count];

	arr->count--;
	
	return TRUE;
}
