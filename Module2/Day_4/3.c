#include<stdio.h>
#include<string.h>

int main(){
   FILE *f= fopen("sample_sim.log", "r");
   if (!f) { 
    perror("Cannot open log file"); 
        return -1; 
    } 
    char line[256];
    int cnt_fail = 0,cnt_pass = 0,cnt_skip = 0;
    while (fgets(line,sizeof(line),f) != NULL){
        if (strstr(line, "FAIL")) cnt_fail +=1;
        if (strstr(line, "PASS")) cnt_pass +=1;
        if (strstr(line, "SKIP")) cnt_skip +=1;
    }
    printf("PASS = %d\nFAIL = %d\nSKIP = %d\n", cnt_pass,cnt_fail,cnt_skip);
    fclose(f);
}