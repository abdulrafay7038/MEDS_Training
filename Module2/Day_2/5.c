/*Exercise 5: Implement strcat_safe(char *dest, size_t dest_size, const char *src) that 
concatenates strings safely without buffer overflow. Return -1 on error. */

#include <stdio.h>
#include <string.h>

int strcat_safe(char *dest, size_t dest_size, const char *src){
    if (strlen(src) + strlen(dest) + 1 > dest_size) return -1;
    size_t dlen = strlen(dest);
    size_t slen = strlen(src);
    for(size_t i = 0; i<slen; i++){
        dest[dlen + i] = src[i];
    }
    dest[dlen + slen] = '\0';
    return 0;
}
int main(){
    char a[] = "fay";
    char b[6] = "Ra";
    strcat_safe(b,sizeof(b),a);
    printf("%s", b);
    return 0;
}