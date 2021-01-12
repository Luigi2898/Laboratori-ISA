#include <stdio.h>
#include <stdlib.h>

#pragma warning(disable:4996)
#define NT 9  /// number of coeffs
#define NB 11 /// number of bits myfilter1
#define NB2 8 /// number of bits myfilter2 my filter 3
#define NF 3 // unfolding degree

const int b[NT] = {-7, -14, 52, 272, 415, 272, 52, -14, -7}; /// b array

// myfilter1 : 11 bits truncated to 8 after multiplication
void myfilter1(int x0, int x1, int x2, int *y0, int *y1, int *y2)
{
  static int sx[NT+2];       /// x shift register
  static int first_run = 0;  /// for cleaning shift registers
  int i;                     /// index
  int tmp0[NT];              /// partial products - state 0
  int tmp1[NT];              /// partial products - state 1
  int tmp2[NT];              /// partial products - state 2
  int tmps0 = 0;              /// partial sum - state 0
  int tmps1 = 0;              /// partial sum - state 1
  int tmps2 = 0;              /// partial sum - state 2
  static int state_x[NF];    /// special arrangement for different samples

  /// clean the buffers
  if (first_run == 0)
  {
    first_run = 1;
    for (i = 0; i < NT+1; i++)
      sx[i] = 0;
    //for (i = 0; i < NT - 1; i++)
      //sy[i] = 0;
  }

    /// shift and insert new sample in x shift register
    for (i = 3; i > 0; i--) {
    if ((3 * i + 2) > 10) {}
    else {
        sx[3 * i + 2] = sx[3 * (i - 1) + 2];
    }
    sx[3 * i + 1] = sx[3 * (i - 1) + 1];
    sx[3 * i + 0] = sx[3 * (i - 1) + 0];
    }
    sx[0] = x2;
    sx[1] = x1;
    sx[2] = x0;

    /// make the convolution
    *y0 = 0;
    *y1 = 0;
    *y2 = 0;
    for (i = 0; i < NT; i++) {
        tmp0[i] = 0;
        tmp1[i] = 0;
        tmp2[i] = 0;
    }

    for (i = 0; i < NT; i++)
    {
    tmp0[i] = (sx[i + 2] * b[i]) >> (NB + 2);
    tmp1[i] = (sx[i + 1] * b[i]) >> (NB + 2);
    tmp2[i] = (sx[i + 0] * b[i]) >> (NB + 2);
    }


    for (i = 0; i < NT; i++) {
        tmps0 += tmp0[i];
        tmps1 += tmp1[i];
        tmps2 += tmp2[i];
    }

    *y0 = tmps0 << 3;
    *y1 = tmps1 << 3;
    *y2 = tmps2 << 3;
      
    return;
}

// myfilter2 : everything processed with 8 msbits out of the 11 of data and coeffs
void myfilter2(int x0, int x1, int x2, int* y0, int* y1, int* y2)
{
    static int sx[NT + 2];       /// x shift register
    static int first_run = 0;  /// for cleaning shift registers
    int i;                     /// index
    int tmp0[NT];              /// partial products - state 0
    int tmp1[NT];              /// partial products - state 1
    int tmp2[NT];              /// partial products - state 2
    int tmps0 = 0;              /// partial sum - state 0
    int tmps1 = 0;              /// partial sum - state 1
    int tmps2 = 0;              /// partial sum - state 2
    static int state_x[NF];    /// special arrangement for different samples

    /// clean the buffers
    if (first_run == 0)
    {
        first_run = 1;
        for (i = 0; i < NT + 1; i++)
            sx[i] = 0;
        //for (i = 0; i < NT - 1; i++)
          //sy[i] = 0;
    }

    /// shift and insert new sample in x shift register
    for (i = 3; i > 0; i--) {
        if ((3 * i + 2) > 10) {}
        else {
            sx[3 * i + 2] = sx[3 * (i - 1) + 2];
        }
        sx[3 * i + 1] = sx[3 * (i - 1) + 1];
        sx[3 * i + 0] = sx[3 * (i - 1) + 0];
    }
    sx[0] = x2 >> 3;
    sx[1] = x1 >> 3;
    sx[2] = x0 >> 3;

    /// make the convolution
    *y0 = 0;
    *y1 = 0;
    *y2 = 0;
    for (i = 0; i < NT; i++) {
        tmp0[i] = 0;
        tmp1[i] = 0;
        tmp2[i] = 0;
    }

    for (i = 0; i < NT; i++)
    {
        tmp0[i] = (sx[i + 2] * (b[i] >> 3)) >> (NB2 - 1);
        tmp1[i] = (sx[i + 1] * (b[i] >> 3)) >> (NB2 - 1);
        tmp2[i] = (sx[i + 0] * (b[i] >> 3)) >> (NB2 - 1);
    }

    for (i = 0; i < NT; i++) {
        tmps0 += tmp0[i];
        tmps1 += tmp1[i];
        tmps2 += tmp2[i];
    }

    *y0 = tmps0 << 3;
    *y1 = tmps1 << 3;
    *y2 = tmps2 << 3;

    printf("%d\t%d\t%d\n", *y0, *y1, *y2);
    //printf("----------------------\n\n");

    return;
}

// myfilter3 : 8 bits truncated to 7 after multiplication
void myfilter3(int x0, int x1, int x2, int* y0, int* y1, int* y2)
{
    static int sx[NT + 2];       /// x shift register
    static int first_run = 0;  /// for cleaning shift registers
    int i;                     /// index
    int tmp0[NT];              /// partial products - state 0
    int tmp1[NT];              /// partial products - state 1
    int tmp2[NT];              /// partial products - state 2
    int tmps0 = 0;              /// partial sum - state 0
    int tmps1 = 0;              /// partial sum - state 1
    int tmps2 = 0;              /// partial sum - state 2
    static int state_x[NF];    /// special arrangement for different samples

    /// clean the buffers
    if (first_run == 0)
    {
        first_run = 1;
        for (i = 0; i < NT + 1; i++)
            sx[i] = 0;
        //for (i = 0; i < NT - 1; i++)
          //sy[i] = 0;
    }

    /// shift and insert new sample in x shift register
    for (i = 3; i > 0; i--) {
        if ((3 * i + 2) > 10) {}
        else {
            sx[3 * i + 2] = sx[3 * (i - 1) + 2];
        }
        sx[3 * i + 1] = sx[3 * (i - 1) + 1];
        sx[3 * i + 0] = sx[3 * (i - 1) + 0];
    }
    sx[0] = x2 >> 3;
    sx[1] = x1 >> 3;
    sx[2] = x0 >> 3;

    /// make the convolution
    *y0 = 0;
    *y1 = 0;
    *y2 = 0;
    for (i = 0; i < NT; i++) {
        tmp0[i] = 0;
        tmp1[i] = 0;
        tmp2[i] = 0;
    }

    for (i = 0; i < NT; i++)
    {
        tmp0[i] = (sx[i + 2] * (b[i] >> 3)) >> (NB2);
        tmp1[i] = (sx[i + 1] * (b[i] >> 3)) >> (NB2);
        tmp2[i] = (sx[i + 0] * (b[i] >> 3)) >> (NB2);
    }

    for (i = 0; i < NT; i++) {
        tmps0 += tmp0[i];
        tmps1 += tmp1[i];
        tmps2 += tmp2[i];
    }

    *y0 = tmps0 << 4;
    *y1 = tmps1 << 4;
    *y2 = tmps2 << 4;


    printf("%d\t%d\t%d\n", *y0, *y1, *y2);
    //printf("----------------------\n\n");

    return;
}

// myfilterpipe : returns partial pipe contents for VHDL debug
void myfilterP(int x0, int x1, int x2, int* y0, int* y1, int* y2, FILE *outfilepipe)
{
    static int sx[NT + 2];       /// x shift register
    static int first_run = 0;  /// for cleaning shift registers
    int i,k;                     /// index
    int tmp0[NT] = {0};              /// partial products - state 0
    int tmp1[NT] = { 0 };              /// partial products - state 1
    int tmp2[NT] = { 0 };              /// partial products - state 2
    int tmps0_1[5] = { 0 }, tmps1_1[5] = { 0 }, tmps2_1[5] = { 0 };
    int tmps0_2[3] = { 0 }, tmps1_2[3] = { 0 }, tmps2_2[3] = { 0 };
    int tmps0_3[2] = { 0 }, tmps1_3[2] = { 0 }, tmps2_3[2] = { 0 };
    int res0, res1, res2;

    static int state_x[NF];    /// special arrangement for different samples

    outfilepipe = fopen("pipeContent.txt", "a");

    /// clean the buffers
    if (first_run == 0)
    {
        first_run = 1;
        for (i = 0; i < NT + 1; i++)
            sx[i] = 0;
        //for (i = 0; i < NT - 1; i++)
          //sy[i] = 0;
    }

    /// shift and insert new sample in x shift register
    for (i = 3; i > 0; i--) {
        if ((3 * i + 2) > 10) {}
        else {
            sx[3 * i + 2] = sx[3 * (i - 1) + 2];
        }
        sx[3 * i + 1] = sx[3 * (i - 1) + 1];
        sx[3 * i + 0] = sx[3 * (i - 1) + 0];
    }
    sx[0] = x2 >> 3;
    sx[1] = x1 >> 3;
    sx[2] = x0 >> 3;

    /// make the convolution
    *y0 = 0;
    *y1 = 0;
    *y2 = 0;
    for (i = 0; i < NT; i++) {
        tmp0[i] = 0;
        tmp1[i] = 0;
        tmp2[i] = 0;
    }

    // partial products - output of pipe 1
    for (i = 0; i < NT; i++)
    {
        tmp0[i] = (sx[i + 2] * (b[i] >> 3)) >> (NB2 - 1);
        tmp1[i] = (sx[i + 1] * (b[i] >> 3)) >> (NB2 - 1);
        tmp2[i] = (sx[i + 0] * (b[i] >> 3)) >> (NB2 - 1);
    }

    for (i = 0; i < NT; i++)
    {
        fprintf(outfilepipe, "%d\t", tmp0[i]);
    }
    fprintf(outfilepipe, "\t\t");
    for (i = 0; i < NT; i++)
    {
        fprintf(outfilepipe, "%d\t", tmp1[i]);
    }
    fprintf(outfilepipe, "\t\t");
    for (i = 0; i < NT; i++)
    {
        fprintf(outfilepipe, "%d\t", tmp2[i]);
    }
    fprintf(outfilepipe, "\n");

    // partial sum 1 - output of pipe 2

    k = 0;

    for (i = 0; i < 7; i = i + 2) {
        tmps0_1[k] = tmp0[i] + tmp0[i + 1];
        tmps1_1[k] = tmp1[i] + tmp1[i + 1];
        tmps2_1[k] = tmp2[i] + tmp2[i + 1];
        k++;
    }
    tmps0_1[4] = tmp0[8];
    tmps1_1[4] = tmp1[8];
    tmps2_1[4] = tmp2[8];

    for (i = 0; i < 5; i++)
    {
        fprintf(outfilepipe, "%d\t", tmps0_1[i]);
    }
    fprintf(outfilepipe, "\t\t\t\t\t\t");
    for (i = 0; i < 5; i++)
    {
        fprintf(outfilepipe, "%d\t", tmps1_1[i]);
    }
    fprintf(outfilepipe, "\t\t\t\t\t\t");
    for (i = 0; i < 5; i++)
    {
        fprintf(outfilepipe, "%d\t", tmps1_1[i]);
    }
    fprintf(outfilepipe, "\n");

    // partial sum 2 - output of pipe 3

    k = 0;

    for (i = 0; i < 4; i = i + 2) {
        tmps0_2[k] = tmps0_1[i] + tmps0_1[i + 1];
        tmps1_2[k] = tmps1_1[i] + tmps1_1[i + 1];
        tmps2_2[k] = tmps2_1[i] + tmps2_1[i + 1];
        k++;
    }
    tmps0_2[2] = tmps0_1[4];
    tmps1_2[2] = tmps1_1[4];
    tmps2_2[2] = tmps2_1[4];


    for (i = 0; i < 3; i++)
    {
        fprintf(outfilepipe, "%d\t", tmps0_2[i]);
    }
    fprintf(outfilepipe, "\t\t\t\t\t\t\t\t");
    for (i = 0; i < 3; i++)
    {
        fprintf(outfilepipe, "%d\t", tmps1_2[i]);
    }
    fprintf(outfilepipe, "\t\t\t\t\t\t\t\t");
    for (i = 0; i < 3; i++)
    {
        fprintf(outfilepipe, "%d\t", tmps1_2[i]);
    }
    fprintf(outfilepipe, "\n");


    // partial sum 2 - output of pipe 4

    tmps0_3[0] = tmps0_2[0] + tmps0_2[1];
    tmps1_3[0] = tmps1_2[0] + tmps1_2[1];
    tmps2_3[0] = tmps2_2[0] + tmps2_2[1];
    tmps0_3[1] = tmps0_2[2];
    tmps1_3[1] = tmps1_2[2];
    tmps2_3[1] = tmps2_2[2];

    for (i = 0; i < 2; i++)
    {
        fprintf(outfilepipe, "%d\t", tmps0_3[i]);
    }
    fprintf(outfilepipe, "\t\t\t\t\t\t\t\t\t");
    for (i = 0; i < 2; i++)
    {
        fprintf(outfilepipe, "%d\t", tmps1_3[i]);
    }
    fprintf(outfilepipe, "\t\t\t\t\t\t\t\t\t");
    for (i = 0; i < 2; i++)
    {
        fprintf(outfilepipe, "%d\t", tmps1_3[i]);
    }
    fprintf(outfilepipe, "\n");

    // final result - output of result reg

    res0 = tmps0_3[0] + tmps0_3[1];
    res1 = tmps1_3[0] + tmps1_3[1];
    res2 = tmps2_3[0] + tmps2_3[1];

   
    fprintf(outfilepipe, "%d\t",res0);
    fprintf(outfilepipe, "\t\t\t\t\t\t\t\t\t\t"); 
    fprintf(outfilepipe, "%d\t", res1);
    fprintf(outfilepipe, "\t\t\t\t\t\t\t\t\t\t");  
    fprintf(outfilepipe, "%d\t",res2);
    fprintf(outfilepipe, "\n");

    fprintf(outfilepipe, "\n\n\n");

    fclose(outfilepipe);

    // shift to move from Q1.7 to Q1.10

    *y0 = res0 << 3;
    *y1 = res1 << 3;
    *y2 = res2 << 3;

    printf("%d\t%d\t%d\n", *y0, *y1, *y2);
    //printf("----------------------\n\n");

    return;
}



//int main(int argc, char **argv)
int main ()
{
  FILE *fp_in;
  FILE *fp_out1,*fp_out2,*fp_out3;
  FILE *outfilepipe, *resultCPipe;

  int x0,x1,x2;
  int y0,y1,y2;

  /// check the command line
  //if (argc != 3)
  //{
  //  printf("Use: %s <input_file> <output_file>\n", argv[0]);
  //  exit(1);
  //}

  /// open files
  //fp_in = fopen(argv[1], "r");
  fp_in = fopen("samples.txt", "r");
  if (fp_in == NULL)
  {
    printf("Error: cannot open file\n");
    exit(2);
  }
  //fp_out = fopen(argv[2], "w");
  fp_out1 = fopen("resultC_unfolded11then8.txt", "w");
  fp_out2 = fopen("resultC_unfolded8.txt", "w");
  fp_out3 = fopen("resultC_unfolded8then7.txt", "w");
  resultCPipe = fopen("resultC_Pipe.txt", "w");
  if ((fp_out1 == NULL) || (fp_out2 == NULL) || (fp_out3 == NULL))
  {
      printf("Error: cannot open one of the output files.\n");
      exit(3);
  }

  outfilepipe = fopen("pipeContent.txt", "w");
  fclose(outfilepipe);




  /// get triplet of samples and apply filter unfolded
  fscanf(fp_in, "%d", &x0);
  fscanf(fp_in, "%d", &x1);
  fscanf(fp_in, "%d", &x2);

  do
  {
    //myfilter1(x0,x1,x2,&y0,&y1,&y2);
    //fprintf(fp_out1, "%d\n", y0);
    //fprintf(fp_out1, "%d\n", y1);
    //fprintf(fp_out1, "%d\n", y2);

    myfilter2(x0, x1, x2, &y0, &y1, &y2);
    fprintf(fp_out2, "%d\n", y0);
    fprintf(fp_out2, "%d\n", y1);
    fprintf(fp_out2, "%d\n", y2);

    myfilterP(x0, x1, x2, &y0, &y1, &y2, outfilepipe);
    fprintf(resultCPipe, "%d\n", y0);
    fprintf(resultCPipe, "%d\n", y1);
    fprintf(resultCPipe, "%d\n", y2);

    //myfilter3(x0, x1, x2, &y0, &y1, &y2);
    //fprintf(fp_out3, "%d\n", y0);
    //fprintf(fp_out3, "%d\n", y1);
    //fprintf(fp_out3, "%d\n", y2);

    fscanf(fp_in, "%d", &x0);
    fscanf(fp_in, "%d", &x1);
    fscanf(fp_in, "%d", &x2);
  } 
  while (!feof(fp_in));

  fclose(fp_in);
  fclose(fp_out1);
  fclose(fp_out2);
  fclose(fp_out3);

  return 0;
}
