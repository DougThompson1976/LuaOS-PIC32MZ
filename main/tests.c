#include <stdio.h>
#include <stdlib.h>

void tests() {
    int i;
    int boot;
    FILE *fp;
	
    char c;
    char str1[20], str2[30];
    int d;
    float e;
    
    char buff[512];
    
    
    for(;;) {
        printf("\ngetc / outc test\n");
    	c = getc(stdin);
     	putc(c,stdout);
    
        printf("\nscanf test\n");
        printf("\nEnter name: ");
        scanf("%s", &str1);
        printf("\nEnter int number: ");
        scanf("%d", &d);
        printf("\nEnter double number: ");
        scanf("%f", &e);
        printf("\nName: %s\n",str1);
        printf("Int number: %d\n",d);
        printf("Float number: %f\n",e);
    }
}

void test_io() {
   FILE *fp;
   char buff[11];
   int size;
   int i;

   printf("open file in w mode, and write 5 lines of text: ");
   fp = fopen("test.lua","w");
   for(i=0;i<5;i++) {
       fprintf(fp,"test\n");
    }
   fclose(fp);
   
   i=0;
   fp = fopen ("test.lua", "r");
   while (!feof(fp)){
       size = fread(buff, 10, 1, fp);
       printf("%s",buff);
//       if (strcmp(buff,"test\n") != 0) {
  //         printf("fail\n");
    //       break;
      // }
       i++;
   }
   
   return;
   
   if (i==5) {
       printf("ok\n");
   } else {
       printf("fail\n");       
   }
   fclose(fp);

   printf("open previous file in a mode, and add 5 lines of text: ");
   fp = fopen("test.lua","a");
   for(i=0;i<5;i++) {
       fprintf(fp,"test\n");
   }
   fclose(fp);

   i=0;
   fp = fopen ("test.lua", "r");
   while (!feof(fp)){
       bzero(buff,11);
       size = fread(buff, 10, 1, fp);
       if (strcmp(buff,"test\n") != 0) {
           printf("fail\n");
           break;
       }
       i++;
   }
   if (i==10) {
       printf("ok\n");
   } else {
       printf("fail\n");       
   }
   fclose(fp);

   printf("open previous file in w mode, and write 5 lines of text: ");
   fp = fopen("test.lua","w");
   for(i=0;i<5;i++) {
       fprintf(fp,"test\n");
    }
   fclose(fp);
   
   i=0;
   fp = fopen ("test.lua", "r");
   while (!feof(fp)){
       bzero(buff,11);
       size = fread(buff, 10, 1, fp);
       if (strcmp(buff,"test\n") != 0) {
           printf("fail\n");
           break;
       }
       i++;
   }
   if (i==5) {
       printf("ok\n");
   } else {
       printf("fail\n");       
   }
   fclose(fp);
   
   for(;;);
}
