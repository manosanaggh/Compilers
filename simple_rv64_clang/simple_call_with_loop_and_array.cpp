// Type your code here, or load an example.
#include <stdio.h>

int square(int *arr, unsigned int size) {
    int sum = 0;
    for(int i = 0; i < size; i++){
        sum += arr[i];
    }
    return sum;
}

int main(){
    int arr[5]={0,1,2,3,4};
    printf("%d\n", square(arr,5));
    return 0;
}
